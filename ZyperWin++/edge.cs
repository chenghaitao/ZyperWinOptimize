using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class edge : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<EdgeSetting> edgeSettings = new List<EdgeSetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe";

        public edge()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializeEdgeSettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;

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

            this.Load += Edge_Load;
        }

        private void InitializeComponentReferences()
        {
            // 添加所有开关控件引用（根据实际控件名称）
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5,
                uiSwitch6, uiSwitch7, uiSwitch8, uiSwitch9, uiSwitch10,
                uiSwitch11, uiSwitch12, uiSwitch13, uiSwitch14
            });
        }

        private void InitializeEdgeSettings()
        {
            // 1. 禁用"首次运行"欢迎页面
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "HideFirstRunExperience",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 2. 关闭Adobe Flash即点即用
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "RunAllFlashInAllowMode",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 3. 关闭后禁止继续运行后台应用
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "BackgroundModeEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 4. 阻止必应搜索结果中的所有广告
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "AdsSettingForIntrusiveAdsSites",
                EnableValue = 2,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 5. 禁用新选项卡页面上的微软资讯
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "NewTabPageContentEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 6. 隐藏新标签页中的默认热门网站
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "NewTabPageHideDefaultTopSites",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 7. 隐藏Edge浏览器边栏
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "ShowSidebar",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 8. 禁用Smartscreen筛选器
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "SmartScreenEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<EdgeSetting>
                {
                    new EdgeSetting
                    {
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                        ValueName = "SmartScreenForTrustedDownloadsEnabled",
                        EnableValue = 0,
                        DisableValue = 1,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 9. 禁止发送任何诊断数据
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "DiagnosticData",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 10. 禁用标签页性能检测器
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "PerformanceDetectorEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 11. 关闭停止支持旧系统的通知
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "SuppressUnsupportedOSWarning",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 12. 关闭Edge自启动
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "StartupBoostEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 13. 启用效率模式
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "EfficiencyMode",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<EdgeSetting>
                {
                    new EdgeSetting
                    {
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                        ValueName = "EfficiencyModeOnPowerEnabled",
                        EnableValue = 2,
                        DisableValue = 0,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    },
                    new EdgeSetting
                    {
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                        ValueName = "EfficiencyModeEnabled",
                        EnableValue = 1,
                        DisableValue = 0,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 14. 关闭"由你的组织管理"提示
            edgeSettings.Add(new EdgeSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Edge",
                ValueName = "HideManagedBrowserWarning",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });
        }

        private void Edge_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, edgeSettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= edgeSettings.Count)
                return;

            var sw = switches[index];
            var setting = edgeSettings[index];

            try
            {
                bool isEnabled = CheckEdgeSetting(setting);
                SetSwitchState(sw, isEnabled);

                sw.ValueChanged += (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        if (value)
                            ApplyEdgeSetting(setting, setting.EnableValue);
                        else
                            ApplyEdgeSetting(setting, setting.DisableValue);

                        Console.WriteLine($"Edge开关 {index + 1} 设置为: {value}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用Edge设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载Edge开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckEdgeSetting(EdgeSetting setting)
        {
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
                    return currentValue.ToString().Equals(expectedValue.ToString(), StringComparison.OrdinalIgnoreCase);
                default:
                    return false;
            }
        }

        private void ApplyEdgeSetting(EdgeSetting setting, object value)
        {
            try
            {
                string registryPath = $"{GetRegistryPath(setting.Hive)}\\{setting.KeyPath}";
                string valueType = GetRegistryValueKind(setting.ValueKind);
                string valueData = GetValueString(value, setting.ValueKind);

                if (setting.RequiresAdmin)
                {
                    string args = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{registryPath}\" /v \"{setting.ValueName}\" /t {valueType} /d {valueData} /f";
                    ExecuteNsudoCommand(args);

                    // 处理附加设置
                    if (setting.AdditionalSettings != null)
                    {
                        foreach (var additionalSetting in setting.AdditionalSettings)
                        {
                            string additionalPath = $"{GetRegistryPath(additionalSetting.Hive)}\\{additionalSetting.KeyPath}";
                            string additionalValueType = GetRegistryValueKind(additionalSetting.ValueKind);
                            string additionalValueData = GetValueString(value, additionalSetting.ValueKind);
                            string additionalArgs = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{additionalPath}\" /v \"{additionalSetting.ValueName}\" /t {additionalValueType} /d {additionalValueData} /f";
                            ExecuteNsudoCommand(additionalArgs);
                        }
                    }
                }
                else
                {
                    using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                    {
                        using (var key = baseKey.CreateSubKey(setting.KeyPath, true))
                        {
                            key.SetValue(setting.ValueName, value, setting.ValueKind);
                        }
                    }
                }

                System.Threading.Thread.Sleep(100);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用Edge设置失败: {ex.Message}");
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

    public class EdgeSetting
    {
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public bool RequiresAdmin { get; set; }
        public RegistryValueKind ValueKind { get; set; }
        public List<EdgeSetting> AdditionalSettings { get; set; }
    }
}