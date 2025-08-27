using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class update : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<UpdateSetting> updateSettings = new List<UpdateSetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe";

        [DllImport("user32.dll")]
        private static extern IntPtr GetDesktopWindow();

        public update()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializeUpdateSettings();

            // 检查NSudoLG.exe是否存在
            if (!File.Exists(nsudoPath))
            {
                Console.WriteLine($"警告: NSudoLG.exe不存在于路径: {nsudoPath}");
                nsudoPath = "NSudoLG.exe";
                if (!File.Exists(nsudoPath))
                {
                    Console.WriteLine("警告: NSudoLG.exe也不存在于当前目录");
                }
            }

            this.Load += Update_Load;
        }

        private void InitializeComponentReferences()
        {
            // 添加所有开关控件引用
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch4, uiSwitch5
            });
        }

        private void InitializeUpdateSettings()
        {
            // 1. 禁止Win10/11进行大版本更新
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate",
                ValueName = "DisableOSUpgrade",
                EnableValue = 1,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 2. Windows更新不包括恶意软件删除工具
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate",
                ValueName = "ExcludeWUDriversInQualityUpdate",
                EnableValue = 1,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 4. 禁用自动更新商店应用
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\WindowsStore",
                ValueName = "AutoDownload",
                EnableValue = 2,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 5. 禁用自动更新地图
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\Maps",
                ValueName = "AutoDownloadAndUpdateMapData",
                EnableValue = 0,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });
        }

        private void Update_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, updateSettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= updateSettings.Count)
                return;

            var sw = switches[index];
            var setting = updateSettings[index];

            try
            {
                bool isEnabled = CheckUpdateSetting(setting);
                SetSwitchState(sw, isEnabled);

                sw.ValueChanged -= Switch_ValueChanged;
                sw.ValueChanged += Switch_ValueChanged;
                sw.Tag = index;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载更新开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private async void Switch_ValueChanged(object sender, bool value)
        {
            if (sender is UISwitch sw && sw.Tag is int index)
            {
                try
                {
                    var setting = updateSettings[index];

                    // 如果是打开文件夹模式，不需要等待操作完成
                    if (setting.UseOpenFolderMode)
                    {
                        ApplySingleSetting(setting, value);
                        return;
                    }

                    await ApplyUpdateSettingAsync(setting, value);
                    Console.WriteLine($"更新开关 {index + 1} 设置为: {value}");

                    // 重新检查状态
                    bool newState = CheckUpdateSetting(setting);
                    SetSwitchState(sw, newState);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"应用更新设置失败 {index + 1}: {ex.Message}");
                    LoadSwitchState(index);
                }
            }
        }

        private bool CheckUpdateSetting(UpdateSetting setting)
        {
            return CheckSingleSetting(setting);
        }

        private bool CheckSingleSetting(UpdateSetting setting)
        {
            // 如果是打开文件夹模式，不需要检查注册表，直接返回 false
            if (setting.UseOpenFolderMode)
                return false;

            try
            {
                using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                {
                    using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                    {
                        if (key == null) return false;

                        object currentValue = key.GetValue(setting.ValueName, null);
                        if (currentValue == null) return false;

                        return CompareValues(currentValue, setting.EnableValue, setting.ValueKind);
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private bool CompareValues(object currentValue, object expectedValue, RegistryValueKind valueKind)
        {
            if (currentValue == null && expectedValue == null) return true;
            if (currentValue == null || expectedValue == null) return false;

            switch (valueKind)
            {
                case RegistryValueKind.DWord:
                    return Convert.ToInt32(currentValue) == Convert.ToInt32(expectedValue);
                case RegistryValueKind.String:
                    // 对于字符串，进行精确比较
                    return string.Equals(currentValue.ToString(), expectedValue.ToString(), StringComparison.Ordinal);
                default:
                    return false;
            }
        }

        private async Task ApplyUpdateSettingAsync(UpdateSetting setting, bool enable)
        {
            await Task.Run(() => ApplySingleSetting(setting, enable));
        }

        private void ApplySingleSetting(UpdateSetting setting, bool enable)
        {
            try
            {
                // 处理打开文件夹模式
                if (setting.UseOpenFolderMode)
                {
                    if (!string.IsNullOrEmpty(setting.FolderPath) && Directory.Exists(setting.FolderPath))
                    {
                        Process.Start("explorer.exe", setting.FolderPath);
                    }
                    else
                    {
                        Console.WriteLine($"文件夹不存在: {setting.FolderPath}");
                    }
                    return;
                }

                // 批处理文件模式
                if (setting.UseBatFileMode)
                {
                    string batFile = enable ? setting.EnableBatFile : setting.DisableBatFile;
                    if (!string.IsNullOrEmpty(batFile) && File.Exists(batFile))
                    {
                        ExecuteCmdHidden($"\"{batFile}\"");
                        return;
                    }
                    Console.WriteLine($"批处理文件不存在: {batFile}");
                    return;
                }

                object value = enable ? setting.EnableValue : setting.DisableValue;

                if (setting.RequiresAdmin)
                {
                    string registryPath = $"{GetRegistryPath(setting.Hive)}\\{setting.KeyPath}";

                    if (value == null)
                    {
                        string args = $"-U:T -P:E -ShowWindowMode:Hide reg delete \"{registryPath}\" /v \"{setting.ValueName}\" /f";
                        ExecuteNsudoCommand(args);
                    }
                    else
                    {
                        string valueType = GetRegistryValueKind(setting.ValueKind);
                        string valueData = GetValueString(value, setting.ValueKind);
                        string args = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{registryPath}\" /v \"{setting.ValueName}\" /t {valueType} /d \"{valueData}\" /f";
                        ExecuteNsudoCommand(args);
                    }
                }
                else
                {
                    using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                    {
                        using (var key = baseKey.CreateSubKey(setting.KeyPath, true))
                        {
                            if (value == null)
                            {
                                try
                                {
                                    key.DeleteValue(setting.ValueName, false);
                                }
                                catch (ArgumentException) { }
                            }
                            else
                            {
                                key.SetValue(setting.ValueName, value, setting.ValueKind);
                            }
                        }
                    }
                }

                System.Threading.Thread.Sleep(100);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用更新设置失败 ({setting.ValueName}): {ex.Message}");
                throw;
            }
        }

        private bool ExecuteCmdHidden(string commands)
        {
            try
            {
                using (Process p = new Process())
                {
                    p.StartInfo.FileName = "cmd.exe";
                    p.StartInfo.Arguments = "/c " + commands;
                    p.StartInfo.UseShellExecute = false;
                    p.StartInfo.CreateNoWindow = true;
                    p.StartInfo.RedirectStandardOutput = true;
                    p.StartInfo.RedirectStandardError = true;
                    p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;

                    p.Start();
                    string output = p.StandardOutput.ReadToEnd();
                    string error = p.StandardError.ReadToEnd();
                    p.WaitForExit();

                    if (p.ExitCode != 0)
                    {
                        throw new Exception($"CMD 退出码: {p.ExitCode}\n输出: {output}\n错误: {error}");
                    }

                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("CMD 执行失败: " + ex.Message);
            }
        }

        private void ExecuteNsudoCommand(string arguments)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = nsudoPath,
                    Arguments = arguments,
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true
                };

                using (Process process = new Process())
                {
                    process.StartInfo = startInfo;
                    process.Start();
                    process.WaitForExit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行NSudo命令失败: {ex.Message}");
                throw;
            }
        }

        private string GetRegistryPath(RegistryHive hive)
        {
            switch (hive)
            {
                case RegistryHive.ClassesRoot: return "HKEY_CLASSES_ROOT";
                case RegistryHive.CurrentUser: return "HKEY_CURRENT_USER";
                case RegistryHive.LocalMachine: return "HKEY_LOCAL_MACHINE";
                case RegistryHive.Users: return "HKEY_USERS";
                case RegistryHive.CurrentConfig: return "HKEY_CURRENT_CONFIG";
                default: return "HKEY_LOCAL_MACHINE";
            }
        }

        private string GetRegistryValueKind(RegistryValueKind valueKind)
        {
            switch (valueKind)
            {
                case RegistryValueKind.DWord: return "REG_DWORD";
                case RegistryValueKind.String: return "REG_SZ";
                default: return "REG_SZ";
            }
        }

        private string GetValueString(object value, RegistryValueKind valueKind)
        {
            return value?.ToString() ?? "";
        }

        private void SetSwitchState(UISwitch sw, bool isEnabled)
        {
            if (sw.InvokeRequired)
            {
                sw.Invoke(new Action(() => SetSwitchState(sw, isEnabled)));
                return;
            }
            sw.Active = isEnabled;
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void uiButton1_Click(object sender, EventArgs e)
        {
            Process.Start(".\\Bin\\update");
        }
    }

    public class UpdateSetting
    {
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public bool RequiresAdmin { get; set; }
        public RegistryValueKind ValueKind { get; set; }
        public bool UseBatFileMode { get; set; }
        public string EnableBatFile { get; set; }
        public string DisableBatFile { get; set; }
        public bool UseOpenFolderMode { get; set; }
        public string FolderPath { get; set; }
    }
}