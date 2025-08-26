using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class update : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<UpdateSetting> updateSettings = new List<UpdateSetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe";

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
            // 添加所有开关控件引用（根据实际控件名称）
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5
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
                DisableValue = null, // 删除值
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
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 3. 禁用Windows更新 停止更新到2999年
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\WindowsUpdate\UX\Settings",
                ValueName = "PauseUpdatesExpiryTime",
                EnableValue = "2999-12-01T09:59:52Z",
                DisableValue = "", // 空字符串
                RequiresAdmin = false, // 这个设置不需要提权
                ValueKind = RegistryValueKind.String
            });

            // 4. 禁用自动更新商店应用
            updateSettings.Add(new UpdateSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\WindowsStore",
                ValueName = "AutoDownload",
                EnableValue = 2,
                DisableValue = null, // 删除值
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
                DisableValue = null, // 删除值
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

                sw.ValueChanged += (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        if (value)
                            ApplyUpdateSetting(setting, setting.EnableValue);
                        else
                            ApplyUpdateSetting(setting, setting.DisableValue);

                        Console.WriteLine($"更新开关 {index + 1} 设置为: {value}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用更新设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载更新开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckUpdateSetting(UpdateSetting setting)
        {
            try
            {
                using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                {
                    using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                    {
                        if (key == null)
                        {
                            // 键不存在，检查是否应该返回true（对于某些设置，键不存在表示已启用）
                            return setting.EnableValue == null;
                        }

                        // 检查值是否存在
                        object currentValue = key.GetValue(setting.ValueName, null);
                        if (currentValue == null)
                        {
                            // 值不存在，检查是否应该返回true
                            return setting.EnableValue == null;
                        }

                        // 比较值
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
                    return currentValue.ToString().Equals(expectedValue.ToString(), StringComparison.OrdinalIgnoreCase);
                default:
                    return false;
            }
        }

        private void ApplyUpdateSetting(UpdateSetting setting, object value)
        {
            try
            {
                string registryPath = $"{GetRegistryPath(setting.Hive)}\\{setting.KeyPath}";
                string valueType = GetRegistryValueKind(setting.ValueKind);
                string valueData = GetValueString(value, setting.ValueKind);

                if (setting.RequiresAdmin)
                {
                    if (value == null)
                    {
                        // 删除值
                        string args = $"-U:T -P:E -ShowWindowMode:Hide reg delete \"{registryPath}\" /v \"{setting.ValueName}\" /f";
                        ExecuteNsudoCommand(args);
                    }
                    else
                    {
                        // 添加/修改值
                        string args = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{registryPath}\" /v \"{setting.ValueName}\" /t {valueType} /d {valueData} /f";
                        ExecuteNsudoCommand(args);
                    }
                }
                else
                {
                    // 普通注册表操作
                    using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                    {
                        using (var key = baseKey.CreateSubKey(setting.KeyPath, true))
                        {
                            if (value == null)
                            {
                                key.DeleteValue(setting.ValueName, false);
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
                Console.WriteLine($"应用更新设置失败: {ex.Message}");
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
                case RegistryValueKind.Binary: return "REG_BINARY";
                default: return "REG_SZ";
            }
        }

        private string GetValueString(object value, RegistryValueKind valueKind)
        {
            if (value == null) return "";
            return value.ToString();
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
            }
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

        // 刷新按钮点击事件
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
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
    }
}
