using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class safe : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<SecuritySetting> securitySettings = new List<SecuritySetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe";

        public safe()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializeSecuritySettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;

            if (!File.Exists(nsudoPath))
            {
                Console.WriteLine($"警告: NSudoLG.exe不存在于路径: {nsudoPath}");
                nsudoPath = "NSudoLG.exe";
                if (!File.Exists(nsudoPath))
                {
                    Console.WriteLine("警告: NSudoLG.exe也不存在于当前目录");
                }
            }

            this.Load += Safe_Load;
        }

        private void InitializeComponentReferences()
        {
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5,
                uiSwitch6, uiSwitch7, uiSwitch8, uiSwitch9, uiSwitch10,
                uiSwitch11, uiSwitch12, uiSwitch13, uiSwitch14, uiSwitch15,
                uiSwitch16, uiSwitch17, uiSwitch18, uiSwitch19, uiSwitch20
            });
        }

        private void InitializeSecuritySettings()
        {
            // 1. 禁用Defender总进程
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Defender,
                EnableValue = "Disable",
                DisableValue = "Enable",
                RequiresAdmin = true
            });

            // 2. 禁用LSA保护(RunAsPPL)
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\System",
                ValueName = "RunAsPPL",
                EnableValue = 0,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<SecuritySetting>
                {
                    new SecuritySetting
                    {
                        Type = SecuritySettingType.Registry,
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SYSTEM\CurrentControlSet\Control\Lsa",
                        ValueName = "RunAsPPL",
                        EnableValue = 0,
                        DisableValue = null,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    },
                    new SecuritySetting
                    {
                        Type = SecuritySettingType.Registry,
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SYSTEM\CurrentControlSet\Control\Lsa",
                        ValueName = "RunAsPPLBoot",
                        EnableValue = 0,
                        DisableValue = null,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 3. 禁用SmartScreen筛选器
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\System",
                ValueName = "EnableSmartScreen",
                EnableValue = 0,
                DisableValue = null,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 4. 禁用Windows安全中心报告
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows Security Health\Platform",
                ValueName = "Registered",
                EnableValue = 0,
                DisableValue = null,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<SecuritySetting>
                {
                    new SecuritySetting
                    {
                        Type = SecuritySettingType.Registry,
                        Hive = RegistryHive.CurrentUser,
                        KeyPath = @"Software\Microsoft\Windows Security Health\State",
                        ValueName = "Disabled",
                        EnableValue = 1,
                        DisableValue = null,
                        RequiresAdmin = false,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 5. 禁用驱动程序阻止列表
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\CI\Config",
                ValueName = "VulnerableDriverBlocklistEnable",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 6. 禁用Edge浏览器SmartScreen
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Edge",
                ValueName = "SmartScreenEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 7. 禁用文件资源管理器SmartScreen
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "SmartScreenEnabled",
                EnableValue = "off",
                DisableValue = "on",
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.String
            });

            // 8. 禁用Microsoft Store应用SmartScreen
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\AppHost",
                ValueName = "EnableWebContentEvaluation",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 9. 禁用攻击面减少规则(ASR)
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR",
                ValueName = "ExploitGuard_ASR_Rules",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 10. 禁用UAC(用户账户控制)
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
                ValueName = "ConsentPromptBehaviorAdmin",
                EnableValue = 0,
                DisableValue = 5,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<SecuritySetting>
                {
                    new SecuritySetting
                    {
                        Type = SecuritySettingType.Registry,
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
                        ValueName = "PromptOnSecureDesktop",
                        EnableValue = 0,
                        DisableValue = 1,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 11. 禁用虚拟化安全(VBS)
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.VBS,
                EnableValue = "off",
                DisableValue = "auto",
                RequiresAdmin = false // 改为false，bcdedit不需要提权
            });

            // 12. 禁用凭证保护(Credential Guard)
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard",
                ValueName = "Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 13. 禁用受控文件夹访问
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access",
                ValueName = "EnableControlledFolderAccess",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 14. 禁用网络保护
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection",
                ValueName = "EnableNetworkProtection",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 15. 禁用AMSI
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\System",
                ValueName = "EnableAmsi",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 16. 禁用代码完整性
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\CI",
                ValueName = "Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 17. 关闭防火墙
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Firewall,
                EnableValue = "off",    // 启用值对应关闭防火墙
                DisableValue = "on",    // 禁用值对应开启防火墙
                RequiresAdmin = true    // 确保需要管理员权限
            });

            // 18. 关闭默认共享
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters",
                ValueName = "AutoShareWks",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                AdditionalSettings = new List<SecuritySetting>
                {
                    new SecuritySetting
                    {
                        Type = SecuritySettingType.Registry,
                        Hive = RegistryHive.LocalMachine,
                        KeyPath = @"SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters",
                        ValueName = "AutoShareServer",
                        EnableValue = 0,
                        DisableValue = 1,
                        RequiresAdmin = true,
                        ValueKind = RegistryValueKind.DWord
                    }
                }
            });

            // 19. 关闭远程协助
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Remote Assistance",
                ValueName = "fAllowToGetHelp",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 20. 启用不安全的来宾登录
            securitySettings.Add(new SecuritySetting
            {
                Type = SecuritySettingType.Registry,
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters",
                ValueName = "AllowInsecureGuestAuth",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });
        }

        private void Safe_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, securitySettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= securitySettings.Count)
                return;

            var sw = switches[index];
            var setting = securitySettings[index];

            try
            {
                bool isEnabled = CheckSecuritySetting(setting);
                SetSwitchState(sw, isEnabled);

                sw.ValueChanged += (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        if (value)
                            ApplySecuritySetting(setting, setting.EnableValue);
                        else
                            ApplySecuritySetting(setting, setting.DisableValue);

                        Console.WriteLine($"安全开关 {index + 1} 设置为: {value}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用安全设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载安全开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckSecuritySetting(SecuritySetting setting)
        {
            try
            {
                bool result = false;
                switch (setting.Type)
                {
                    case SecuritySettingType.Defender:
                        result = CheckDefenderStatus();
                        break;
                    case SecuritySettingType.Firewall:
                        result = CheckFirewallStatus();
                        break;
                    case SecuritySettingType.VBS:
                        result = CheckVBSStatus();
                        break;
                    case SecuritySettingType.Registry:
                        result = CheckRegistrySetting(setting);
                        break;
                    default:
                        result = false;
                        break;
                }

                Console.WriteLine($"检查安全设置 {setting.Type}: {result}");
                return result;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"检查安全设置 {setting.Type} 时出错: {ex.Message}");
                return false;
            }
        }

        private bool CheckDefenderStatus()
        {
            try
            {
                using (var key = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Policies\Microsoft\Windows Defender"))
                {
                    if (key != null)
                    {
                        var disableAntiSpyware = key.GetValue("DisableAntiSpyware");
                        if (disableAntiSpyware != null && Convert.ToInt32(disableAntiSpyware) == 1)
                            return true;
                    }
                }

                using (var key = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Microsoft\Windows Defender\Real-Time Protection"))
                {
                    if (key != null)
                    {
                        var disabled = key.GetValue("DisableRealtimeMonitoring");
                        if (disabled != null && Convert.ToInt32(disabled) == 1)
                            return true;
                    }
                }

                return false;
            }
            catch
            {
                return false;
            }
        }

        private bool CheckFirewallStatus()
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "netsh.exe",
                    Arguments = "advfirewall show allprofiles state",
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardOutput = true,
                    StandardOutputEncoding = Encoding.GetEncoding("gb2312")
                };

                using (Process process = new Process())
                {
                    process.StartInfo = startInfo;
                    process.Start();
                    string output = process.StandardOutput.ReadToEnd();
                    process.WaitForExit();

                    // 更精确的检测逻辑
                    var lines = output.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);

                    bool allProfilesOff = true;

                    foreach (var line in lines)
                    {
                        string lineLower = line.ToLower(); // 转换为小写进行比较

                        if (lineLower.Contains("状态") || lineLower.Contains("state"))
                        {
                            // 检查每个配置文件的狀態
                            if (lineLower.Contains("开启") || lineLower.Contains("启用") ||
                                lineLower.Contains("on") || lineLower.Contains("enable"))
                            {
                                allProfilesOff = false;
                                break;
                            }
                        }
                    }

                    return allProfilesOff;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"检查防火墙状态失败: {ex.Message}");
                return false;
            }
        }

        private bool CheckVBSStatus()
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "bcdedit.exe",
                    Arguments = "/enum",
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    StandardOutputEncoding = Encoding.UTF8
                };

                using (Process process = new Process())
                {
                    process.StartInfo = startInfo;
                    process.Start();
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();
                    process.WaitForExit();

                    Console.WriteLine($"bcdedit输出: {output}");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Console.WriteLine($"bcdedit错误: {error}");
                    }

                    // 更精确的检测逻辑
                    var lines = output.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                    bool foundHypervisorSection = false;

                    foreach (var line in lines)
                    {
                        string lineLower = line.ToLower(); // 转换为小写进行比较

                        // 查找hypervisorlaunchtype行
                        if (lineLower.Contains("hypervisorlaunchtype"))
                        {
                            // 提取值
                            var colonIndex = line.IndexOf(':');
                            if (colonIndex > 0)
                            {
                                string value = line.Substring(colonIndex + 1).Trim();
                                Console.WriteLine($"找到hypervisorlaunchtype值: '{value}'");
                                return value.Equals("Off", StringComparison.OrdinalIgnoreCase);
                            }
                        }

                        // 检查是否在hypervisor部分
                        if (lineLower.Contains("hypervisor") && !lineLower.Contains("hypervisorlaunchtype"))
                        {
                            foundHypervisorSection = true;
                        }

                        // 如果在hypervisor部分且找到"Off"
                        if (foundHypervisorSection && line.Trim().Equals("Off", StringComparison.OrdinalIgnoreCase))
                        {
                            Console.WriteLine("在hypervisor部分找到Off值");
                            return true;
                        }
                    }

                    // 备用检测方法：检查注册表
                    return CheckVBSRegistryStatus();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"检查VBS状态时出错: {ex.Message}");
                return CheckVBSRegistryStatus();
            }
        }

        private bool CheckVBSRegistryStatus()
        {
            try
            {
                // 检查DeviceGuard相关的注册表键值
                using (var key = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\DeviceGuard"))
                {
                    if (key != null)
                    {
                        var enableVBS = key.GetValue("EnableVirtualizationBasedSecurity");
                        var hypervisorEnforcedCI = key.GetValue("HypervisorEnforcedCodeIntegrity");

                        if (enableVBS != null && Convert.ToInt32(enableVBS) == 0 &&
                            hypervisorEnforcedCI != null && Convert.ToInt32(hypervisorEnforcedCI) == 0)
                        {
                            Console.WriteLine("注册表显示VBS已禁用");
                            return true;
                        }
                    }
                }

                // 检查Credential Guard
                using (var key = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard"))
                {
                    if (key != null)
                    {
                        var enabled = key.GetValue("Enabled");
                        if (enabled != null && Convert.ToInt32(enabled) == 0)
                        {
                            Console.WriteLine("注册表显示Credential Guard已禁用");
                            return true;
                        }
                    }
                }

                Console.WriteLine("注册表显示VBS可能已启用");
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"检查VBS注册表状态时出错: {ex.Message}");
                return false;
            }
        }

        private bool CheckRegistrySetting(SecuritySetting setting)
        {
            using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
            {
                using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                {
                    if (key == null) return setting.EnableValue == null;

                    object currentValue = key.GetValue(setting.ValueName, null);
                    if (currentValue == null) return setting.EnableValue == null;

                    return CompareValues(currentValue, setting.EnableValue, setting.ValueKind);
                }
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

        private void ApplySecuritySetting(SecuritySetting setting, object value)
        {
            try
            {
                switch (setting.Type)
                {
                    case SecuritySettingType.Defender:
                        ExecuteDefenderControl(value.ToString());
                        break;
                    case SecuritySettingType.Firewall:
                        ExecuteFirewallCommand(value.ToString(), setting);
                        break;
                    case SecuritySettingType.VBS:
                        ExecuteVBSCommand(value.ToString());
                        break;
                    case SecuritySettingType.Registry:
                        ApplyRegistrySetting(setting, value);
                        break;
                }

                System.Threading.Thread.Sleep(100);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用安全设置失败: {ex.Message}");
            }
        }

        private void ExecuteDefenderControl(string action)
        {
            try
            {
                string defenderControlPath = @".\Bin\Defender_Control.exe";
                if (File.Exists(defenderControlPath))
                {
                    Process.Start(defenderControlPath);
                }
                else
                {
                    Console.WriteLine("Defender_Control.exe 不存在");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行Defender控制失败: {ex.Message}");
            }
        }

        private void ExecuteFirewallCommand(string state, SecuritySetting setting)
        {
            try
            {
                string args = state.ToLower() == "on" ?
                    "advfirewall set allprofiles state on" :
                    "advfirewall set allprofiles state off";

                Console.WriteLine($"执行防火墙命令: netsh {args}");

                if (setting.RequiresAdmin)
                {
                    string nsudoArgs = $"-U:T -P:E -ShowWindowMode:Hide netsh {args}";
                    ExecuteNsudoCommand(nsudoArgs);
                }
                else
                {
                    ProcessStartInfo startInfo = new ProcessStartInfo
                    {
                        FileName = "netsh.exe",
                        Arguments = args,
                        UseShellExecute = false,
                        CreateNoWindow = true,
                        RedirectStandardOutput = true,
                        RedirectStandardError = true
                    };

                    using (Process process = new Process())
                    {
                        process.StartInfo = startInfo;
                        process.Start();

                        string output = process.StandardOutput.ReadToEnd();
                        string error = process.StandardError.ReadToEnd();
                        process.WaitForExit();

                        Console.WriteLine($"netsh输出: {output}");
                        if (!string.IsNullOrEmpty(error))
                        {
                            Console.WriteLine($"netsh错误: {error}");
                        }
                    }
                }

                // 添加额外的防火墙禁用命令确保生效
                if (state.ToLower() == "off")
                {
                    ExecuteAdditionalFirewallCommands();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行防火墙命令失败: {ex.Message}");
            }
        }
        private void ExecuteAdditionalFirewallCommands()
        {
            try
            {
                // 禁用Windows Defender防火墙服务
                string disableServiceArgs = "-U:T -P:E -ShowWindowMode:Hide sc config MpsSvc start= disabled";
                ExecuteNsudoCommand(disableServiceArgs);

                string stopServiceArgs = "-U:T -P:E -ShowWindowMode:Hide sc stop MpsSvc";
                ExecuteNsudoCommand(stopServiceArgs);

                // 禁用防火墙通过组策略
                string registryArgs = "-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\" /v \"EnableFirewall\" /t REG_DWORD /d 0 /f";
                ExecuteNsudoCommand(registryArgs);

                registryArgs = "-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\StandardProfile\" /v \"EnableFirewall\" /t REG_DWORD /d 0 /f";
                ExecuteNsudoCommand(registryArgs);

                registryArgs = "-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PublicProfile\" /v \"EnableFirewall\" /t REG_DWORD /d 0 /f";
                ExecuteNsudoCommand(registryArgs);

                Console.WriteLine("已执行额外的防火墙禁用命令");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行额外防火墙命令失败: {ex.Message}");
            }
        }


        private void ExecuteVBSCommand(string state)
        {
            try
            {
                Console.WriteLine($"设置VBS状态为: {state}");

                // bcdedit命令不需要提权
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "bcdedit.exe",
                    Arguments = $"/set hypervisorlaunchtype {state}",
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    StandardOutputEncoding = Encoding.UTF8
                };

                using (Process process = new Process())
                {
                    process.StartInfo = startInfo;
                    process.Start();
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();
                    process.WaitForExit();

                    Console.WriteLine($"bcdedit输出: {output}");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Console.WriteLine($"bcdedit错误: {error}");
                    }

                    if (process.ExitCode != 0)
                    {
                        Console.WriteLine($"bcdedit退出代码: {process.ExitCode}");
                    }
                }

                // 注册表设置需要提权
                if (state.Equals("off", StringComparison.OrdinalIgnoreCase))
                {
                    Console.WriteLine("禁用VBS相关注册表设置");
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\" /v \"EnableVirtualizationBasedSecurity\" /t REG_DWORD /d 0 /f");
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\" /v \"HypervisorEnforcedCodeIntegrity\" /t REG_DWORD /d 0 /f");

                    // 同时禁用Credential Guard
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\\Scenarios\\CredentialGuard\" /v \"Enabled\" /t REG_DWORD /d 0 /f");
                }
                else
                {
                    Console.WriteLine("启用VBS相关注册表设置");
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\" /v \"EnableVirtualizationBasedSecurity\" /t REG_DWORD /d 1 /f");
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\" /v \"HypervisorEnforcedCodeIntegrity\" /t REG_DWORD /d 1 /f");

                    // 启用Credential Guard
                    ExecuteNsudoCommand($"-U:T -P:E -ShowWindowMode:Hide reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\DeviceGuard\\Scenarios\\CredentialGuard\" /v \"Enabled\" /t REG_DWORD /d 1 /f");
                }

                Console.WriteLine("VBS设置完成");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行VBS命令失败: {ex.Message}");
            }
        }

        private void ApplyRegistrySetting(SecuritySetting setting, object value)
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
                        string additionalValueData = GetValueString(additionalSetting.EnableValue, additionalSetting.ValueKind);
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
                        if (value == null)
                            key.DeleteValue(setting.ValueName, false);
                        else
                            key.SetValue(setting.ValueName, value, setting.ValueKind);
                    }
                }
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

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }
    }

    public class SecuritySetting
    {
        public SecuritySettingType Type { get; set; }
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public bool RequiresAdmin { get; set; }
        public RegistryValueKind ValueKind { get; set; }
        public List<SecuritySetting> AdditionalSettings { get; set; }
    }

    public enum SecuritySettingType
    {
        Defender,
        Firewall,
        VBS,
        Registry
    }
}