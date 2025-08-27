using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class yinsi : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<PrivacySetting> privacySettings = new List<PrivacySetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe"; // 修正为单反斜杠

        public yinsi()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializePrivacySettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;

            this.Load += Yinsi_Load;
        }

        private void InitializeComponentReferences()
        {
            // 手动添加所有开关控件引用（根据你的实际控件名称）
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5,
                uiSwitch6, uiSwitch7, uiSwitch8, uiSwitch9, uiSwitch10,
                uiSwitch11, uiSwitch12, uiSwitch13, uiSwitch14, uiSwitch15,
                uiSwitch16, uiSwitch17, uiSwitch18, uiSwitch19, uiSwitch20,
                uiSwitch21, uiSwitch22, uiSwitch23, uiSwitch24, uiSwitch25,
                uiSwitch26, uiSwitch27, uiSwitch28, uiSwitch29, uiSwitch30,
                uiSwitch31, uiSwitch32, uiSwitch33, uiSwitch34, uiSwitch35,
                uiSwitch36, uiSwitch37, uiSwitch38, uiSwitch39, uiSwitch40,
                uiSwitch41, uiSwitch42, uiSwitch43, uiSwitch44, uiSwitch45,
                uiSwitch46, uiSwitch47, uiSwitch48, uiSwitch49, uiSwitch50,
                uiSwitch51, uiSwitch52, uiSwitch53
            });
        }

        private void InitializePrivacySettings()
        {
            // 1. 禁用页面预测功能
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "AllowPagePrediction",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 2. 禁用开始屏幕建议
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SubscribedContent-338388Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 3. 禁用活动收集
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SubscribedContent-338388Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 4. 禁用应用启动跟踪
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "Start_TrackProgs",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 5. 禁用广告标识符
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
                ValueName = "Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 6. 禁用应用访问文件系统
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 7. 禁用应用访问文档
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 8. 禁用应用访问日历
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 9. 禁用应用访问联系人
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 10. 禁用应用访问视频
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 11. 禁用网站语言跟踪
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Control Panel\International\User Profile",
                ValueName = "HttpAcceptLanguageOptOut",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = false
            });

            // 12. 禁用Windows欢迎体验
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
                ValueName = "DisableFirstRunAnimate",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 13. 禁用反馈频率
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\DataCollection",
                ValueName = "DoNotShowFeedbackNotifications",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 14. 禁用诊断数据收集
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\DataCollection",
                ValueName = "AllowTelemetry",
                EnableValue = 0,
                DisableValue = 3,
                RequiresAdmin = true
            });

            // 15. 禁用写作习惯跟踪
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Input\Settings",
                ValueName = "Inking&TypingPersonalization",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 16. 禁用设置应用建议
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SubscribedContent-338393Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 17. 禁用Bing搜索结果
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Search",
                ValueName = "BingSearchEnabled",
                EnableValue = 0,  
                DisableValue = 1, 
                RequiresAdmin = false  // 改为不需要管理员权限
            });

            // 18. 禁用通讯录收集
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 19. 禁用键入文本收集
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Input\Settings",
                ValueName = "Inking&TypingPersonalization",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 20. 禁用搜索历史
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\SearchSettings",
                ValueName = "IsDeviceSearchHistoryEnabled",
                EnableValue = 0,  
                DisableValue = 1, 
                RequiresAdmin = false
            });

            // 21. 禁用赞助商应用安装
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\CloudContent",
                ValueName = "DisableThirdPartySuggestions",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 22. 禁用自动连接热点
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local",
                ValueName = "fBlockNonDomain",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 23. 禁用输入数据个性化
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Personalization\Settings",
                ValueName = "RestrictImplicitTextCollection",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = false
            });

            // 24. 禁用键入见解
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Input\Settings",
                ValueName = "EnableTypingInsights",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 25. 禁用预安装应用
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "DisablePreInstalledApps",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = false
            });

            // 26. 禁用.NET遥测
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\DataCollection",
                ValueName = "DisableNetFrameworkTelemetry",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 27. 禁用PowerShell遥测
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\PowerShell",
                ValueName = "EnablePowerShellTelemetry",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 28. 禁用遥测服务 - 这个需要特殊处理，不是简单的注册表操作
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\DiagTrack",
                ValueName = "Start",
                EnableValue = 4, 
                DisableValue = 2, 
                RequiresAdmin = true
            });

            // 29. 禁用错误报告(WER)
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting",
                ValueName = "Disabled",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 30. 禁用语音激活(Cortana)
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\AppPrivacy",
                ValueName = "LetAppsActivateWithVoice",
                EnableValue = 2,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 31. 禁用位置服务
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors",
                ValueName = "DisableLocation",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 32. 禁用搜索数据收集
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\Windows Search",
                ValueName = "AllowCortana",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 33. 禁用定向广告
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
                ValueName = "Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 34. 禁用Wi-Fi感知
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local",
                ValueName = "fBlockNonDomain",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 35. 禁用步骤记录器
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Policies\Microsoft\Windows\ProblemReports",
                ValueName = "DisableProblemReports",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = false
            });

            // 36. 禁用写入调试信息
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter",
                ValueName = "DEFAULT",
                EnableValue = 0,
                DisableValue = 15, 
                RequiresAdmin = true
            });

            // 37. 禁用应用访问账户信息
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 38. 禁用应用访问运动数据
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 39. 禁用应用访问电话
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 40. 禁用应用访问信任设备
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 41. 禁用应用访问同步
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 42. 禁用应用访问诊断信息
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 43. 禁用应用访问通话记录
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 44. 禁用应用访问电子邮件
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 45. 禁用应用访问任务
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 46. 禁用应用访问消息
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage",
                ValueName = "Value",
                EnableValue = "Deny",
                DisableValue = "Allow",
                RequiresAdmin = false
            });

            // 47. 禁用组件堆栈日志
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug",
                ValueName = "Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 48. 禁用更新解压模块日志
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\WindowsUpdate\Logging",
                ValueName = "EnableLog",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false
            });

            // 49. 禁用错误报告日志
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\Windows Error Reporting",
                ValueName = "LoggingDisabled",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = false
            });

            // 50. 禁用将事件写入系统日志
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Windows",
                ValueName = "NoEventLog",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 51. 禁用崩溃时写入调试信息
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\CrashControl",
                ValueName = "CrashDumpEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });

            // 52. 禁用账户登录日志报告
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
                ValueName = "DisableLogonCacheDisplay",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true
            });

            // 53. 禁用WfpDiag.ETL日志
            privacySettings.Add(new PrivacySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\BFE\Diagnostics",
                ValueName = "EnableLog",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = true
            });
        }

        private void Yinsi_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, privacySettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= privacySettings.Count)
                return;

            var sw = switches[index];
            var setting = privacySettings[index];

            try
            {
                bool isEnabled = CheckPrivacySetting(setting);
                SetSwitchState(sw, isEnabled);

                // 绑定事件
                sw.ValueChanged += (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        if (value)
                            ApplyPrivacySetting(setting, setting.EnableValue);
                        else
                            ApplyPrivacySetting(setting, setting.DisableValue);

                        Console.WriteLine($"隐私开关 {index + 1} 设置为: {value}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用隐私设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载隐私开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckPrivacySetting(PrivacySetting setting)
        {
            try
            {
                using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                {
                    using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                    {
                        if (key == null)
                        {
                            // 键不存在，检查是否应该返回true
                            // 对于某些设置，键不存在表示已启用（已禁用功能）
                            return setting.EnableValue == null;
                        }

                        // 检查值是否存在
                        object currentValue = key.GetValue(setting.ValueName, null);
                        if (currentValue == null)
                        {
                            // 值不存在，检查是否应该返回true
                            return setting.EnableValue == null;
                        }

                        // 比较值 - 检查是否等于启用值
                        return CompareValues(currentValue, setting.EnableValue);
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private bool CompareValues(object currentValue, object targetValue)
        {
            if (currentValue == null && targetValue == null) return true;
            if (currentValue == null || targetValue == null) return false;

            // 处理字符串比较（不区分大小写）
            if (targetValue is string targetString && currentValue is string currentString)
            {
                return string.Equals(currentString, targetString, StringComparison.OrdinalIgnoreCase);
            }

            // 处理整数比较
            if (targetValue is int targetInt)
            {
                if (currentValue is int currentInt)
                    return currentInt == targetInt;

                // 尝试转换字符串为整数
                if (currentValue is string currentStr && int.TryParse(currentStr, out int parsedInt))
                    return parsedInt == targetInt;
            }

            // 默认比较
            return currentValue.Equals(targetValue);
        }

        private void ApplyPrivacySetting(PrivacySetting setting, object value)
        {
            try
            {
                if (setting.RequiresAdmin)
                {
                    // 使用NSudoLG提权执行
                    string registryPath = $"{GetRegistryPath(setting.Hive)}\\{setting.KeyPath}";
                    string valueType = GetRegistryValueKind(value);
                    string valueData = GetValueString(value);

                    // 修正NSudo参数格式
                    string args = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{registryPath}\" /v \"{setting.ValueName}\" /t {valueType} /d \"{valueData}\" /f";
                    ExecuteNsudoCommand(args);
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
                                // 删除值
                                key.DeleteValue(setting.ValueName, false);
                            }
                            else if (value is int intValue)
                            {
                                key.SetValue(setting.ValueName, intValue, RegistryValueKind.DWord);
                            }
                            else if (value is string stringValue)
                            {
                                key.SetValue(setting.ValueName, stringValue, RegistryValueKind.String);
                            }
                        }
                    }
                }

                System.Threading.Thread.Sleep(200);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用隐私设置失败: {ex.Message}");
                Console.WriteLine($"设置: {setting.KeyPath}\\{setting.ValueName}, 值: {value}");
            }
        }

        private string GetRegistryPath(RegistryHive hive)
        {
            switch (hive)
            {
                case RegistryHive.ClassesRoot:
                    return "HKEY_CLASSES_ROOT";
                case RegistryHive.CurrentUser:
                    return "HKEY_CURRENT_USER";
                case RegistryHive.LocalMachine:
                    return "HKEY_LOCAL_MACHINE";
                case RegistryHive.Users:
                    return "HKEY_USERS";
                case RegistryHive.CurrentConfig:
                    return "HKEY_CURRENT_CONFIG";
                default:
                    return "HKEY_LOCAL_MACHINE";
            }
        }

        private string GetRegistryValueKind(object value)
        {
            return value is int ? "REG_DWORD" : "REG_SZ";
        }

        private string GetValueString(object value)
        {
            return value?.ToString() ?? "";
        }

        private void ExecuteNsudoCommand(string arguments)
        {
            try
            {
                Console.WriteLine($"执行命令: {nsudoPath} {arguments}");

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

                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();

                    process.WaitForExit(10000); // 10秒超时

                    if (!string.IsNullOrEmpty(output))
                        Console.WriteLine($"输出: {output}");
                    if (!string.IsNullOrEmpty(error))
                        Console.WriteLine($"错误: {error}");

                    Console.WriteLine($"退出代码: {process.ExitCode}");
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

    public class PrivacySetting
    {
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public bool RequiresAdmin { get; set; }
    }
}