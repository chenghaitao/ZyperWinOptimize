using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Sunny.UI;
using Microsoft.Win32;
using System.Diagnostics;

namespace ZyperWin__
{
    public partial class xingneng : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<PerformanceSetting> performanceSettings = new List<PerformanceSetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe"; // NSudoLG.exe路径

        public xingneng()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializePerformanceSettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;

            // 检查NSudoLG.exe是否存在
            if (!System.IO.File.Exists(nsudoPath))
            {
                Console.WriteLine($"警告: NSudoLG.exe不存在于路径: {nsudoPath}");
                // 尝试在当前目录查找
                nsudoPath = "NSudoLG.exe";
                if (!System.IO.File.Exists(nsudoPath))
                {
                    Console.WriteLine("警告: NSudoLG.exe也不存在于当前目录");
                }
            }

            this.Load += Xingneng_Load;
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
                uiSwitch51, uiSwitch52, uiSwitch53, uiSwitch54
            });
        }

        private void InitializePerformanceSettings()
        {
            // 1. 不允许在开始菜单显示建议
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SubscribedContent-338388Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 2. 不要在应用商店中查找关联应用
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SilentInstalledAppsEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 3. 关闭商店应用推广
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "PreInstalledAppsEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 4. 关闭锁屏时的Windows聚焦推广
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "RotatingLockScreenEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 5. 关闭"使用Windows时获取技巧和建议"
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
                ValueName = "SoftLandingEnabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 6. 禁止自动安装推荐的应用程序
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate",
                ValueName = "AutoDownload",
                EnableValue = 2,
                DisableValue = 4,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 7. 关闭游戏录制工具
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"System\GameConfigStore",
                ValueName = "GameDVR_Enabled",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 8. 关闭多嘴的小娜
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Search",
                ValueName = "BingSearchEnabled",
                EnableValue = 0,  // 禁用
                DisableValue = 1, // 启用
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 9. 加快关机速度
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control",
                ValueName = "WaitToKillServiceTimeout",
                EnableValue = "1000",
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.String
            });

            // 10. 缩短关闭服务等待时间
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control",
                ValueName = "ServicesPipeTimeout",
                EnableValue = 2000,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 11. 禁用程序兼容性助手（服务操作，需要特殊处理）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\PcaSvc",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "PcaSvc"
            });

            // 12. 禁用远程修改注册表
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg",
                ValueName = "RemoteRegAccess",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 13. 禁用诊断服务（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\DPS",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "DPS"
            });

            // 14. 禁用SysMain（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\SysMain",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "SysMain"
            });

            // 15. 禁用Windows Search（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\WSearch",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "WSearch"
            });

            // 16. 禁用错误报告
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\Windows Error Reporting",
                ValueName = "Disabled",
                EnableValue = 1,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 17. 禁用客户体验改善计划
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\SQMClient\Windows",
                ValueName = "CEIPEnable",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 18. 禁用NTFS链接跟踪服务（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\TrkWks",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "TrkWks"
            });

            // 19. 禁止自动维护计划
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance",
                ValueName = "MaintenanceDisabled",
                EnableValue = 1,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 20. 启用大系统缓存以提高性能
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management",
                ValueName = "LargeSystemCache",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 21. 禁止系统内核与驱动程序分页到硬盘
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management",
                ValueName = "DisablePagingExecutive",
                EnableValue = 1,
                DisableValue = 0,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 22. 将文件管理系统缓存增加至256MB
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management",
                ValueName = "IoPageLockLimit",
                EnableValue = 4194304,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 23. 将Windows预读调整为关闭预读
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters",
                ValueName = "EnablePrefetcher",
                EnableValue = 0,
                DisableValue = 3,
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 24. 禁用处理器的幽灵和熔断补丁
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management",
                ValueName = "FeatureSettingsOverride",
                EnableValue = 3,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 25. VHD启动时节省磁盘空间
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\FsDepends\Parameters",
                ValueName = "VirtualDiskExpandOnMount",
                EnableValue = 4,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 26. 关闭系统自动调试功能
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug",
                ValueName = "Auto",
                EnableValue = 0,
                DisableValue = 1,
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 27. 将磁盘错误检查等待时间缩短到五秒
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control",
                ValueName = "AutoChkTimeOut",
                EnableValue = 5,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 28. 设备安装禁止创建系统还原点
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings",
                ValueName = "DisableSystemRestore",
                EnableValue = 1,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 29. 弹出USB磁盘后彻底断开电源
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\USBSTOR",
                ValueName = "DisableOnSoftRemove",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 30. 关闭快速启动
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Power",
                ValueName = "HiberbootEnabled",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 31. 关闭休眠（需要调用powercfg命令，特殊处理）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine, // 改为LocalMachine
                KeyPath = "",
                ValueName = "",
                EnableValue = "off",
                DisableValue = "on",
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.Unknown,
                IsPowerCfgCommand = true
            });

            // 32. 根据语言设置隐藏字体
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions",
                ValueName = "MitigationOptions_FontBocking",
                EnableValue = "10000000000000000000000000000000",
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.String
            });

            // 33. 微软拼音输入法关闭云计算
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\InputMethod\Settings\CHS",
                ValueName = "CloudCandidate",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 34. 禁用内容传递优化服务
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config",
                ValueName = "DownloadMode",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 35. 禁用功能更新安全措施
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\WindowsUpdate\UX",
                ValueName = "IsConvergedUpdateStackEnabled",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 36. 禁用蓝屏后自动重启
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\CrashControl",
                ValueName = "AutoReboot",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 37. 禁用Installer detection
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
                ValueName = "EnableInstallerDetection",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 38. 禁用上下文菜单显示延迟
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Control Panel\Desktop",
                ValueName = "MenuShowDelay",
                EnableValue = "0",      // 优化：无延迟
                DisableValue = "400",   // 默认：400ms延迟
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.String
            });

            // 39. 禁用保留空间（需要调用DISM命令，特殊处理）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine, // 改为LocalMachine
                KeyPath = "",
                ValueName = "",
                EnableValue = "Disabled",
                DisableValue = "Enabled",
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.Unknown,
                IsDismCommand = true
            });

            // 40. 启用硬件加速GPU计划
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\GraphicsDrivers",
                ValueName = "HwSchMode",
                EnableValue = 2,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 41. 优化处理器性能和内存设置（多个值，需要特殊处理）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\PriorityControl",
                ValueName = "MultipleValues",
                EnableValue = new Dictionary<string, object>
                {
                    { "Win32PrioritySeparation", 38 },
                    { "IRQ8Priority", 1 },
                    { "IRQ16Priority", 2 }
                },
                DisableValue = new Dictionary<string, object>
                {
                    { "Win32PrioritySeparation", null },
                    { "IRQ8Priority", null },
                    { "IRQ16Priority", null }
                },
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                HasMultipleValues = true
            });

            // 42. 降低Cortana性能减少CPU占用
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\Windows\Windows Search",
                ValueName = "AllowCortana",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 43. 关闭Exploit Protection
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Kernel",
                ValueName = "MitigationOptions",
                EnableValue = new byte[] { 0x22, 0x22, 0x22, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.Binary
            });

            // 44. 关闭广告ID（多个值，需要特殊处理）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
                ValueName = "Enabled",
                EnableValue = 0,        // 优化：禁用广告ID
                DisableValue = 1,       // 默认：启用广告ID
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 45. 关闭应用启动跟踪
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "Start_TrackProgs",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 46. 去除搜索页面信息流和热搜
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Policies\Microsoft\Windows\Explorer",
                ValueName = "DisableSearchBoxSuggestions",
                EnableValue = 1,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 47. 关闭TSX漏洞补丁
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control\Session Manager\Kernel",
                ValueName = "DisableTsx",
                EnableValue = 1,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 48. 优化进程数量
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Control",
                ValueName = "SvcHostSplitThresholdInKB",
                EnableValue = "ffffffff",
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.String
            });

            // 49. 关闭诊断策略服务（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\DPS",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "DPS"
            });

            // 50. 关闭程序兼容性助手（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\PcaSvc",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = 2, // 自动
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "PcaSvc"
            });

            // 51. 关闭微软客户体验改进计划
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Policies\Microsoft\SQMClient\Windows",
                ValueName = "CEIPEnable",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord
            });

            // 52. 禁用交付优化
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization",
                ValueName = "SystemSettingsDownloadMode",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });

            // 53. 禁用高精度事件定时器(HPET)（服务操作）
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SYSTEM\CurrentControlSet\Services\hpet",
                ValueName = "Start",
                EnableValue = 4, // 禁用
                DisableValue = null, // 删除值
                RequiresAdmin = true,
                ValueKind = RegistryValueKind.DWord,
                IsService = true,
                ServiceName = "hpet"
            });

            // 54. 禁用Game Bar
            performanceSettings.Add(new PerformanceSetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\GameDVR",
                ValueName = "AppCaptureEnabled",
                EnableValue = 0,
                DisableValue = null, // 删除值
                RequiresAdmin = false,
                ValueKind = RegistryValueKind.DWord
            });
        }

        private void Xingneng_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, performanceSettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= performanceSettings.Count)
                return;

            var sw = switches[index];
            var setting = performanceSettings[index];

            try
            {
                bool isEnabled = CheckPerformanceSetting(setting);
                SetSwitchState(sw, isEnabled);

                // 绑定事件
                sw.ValueChanged += (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        if (value)
                            ApplyPerformanceSetting(setting, setting.EnableValue);
                        else
                            ApplyPerformanceSetting(setting, setting.DisableValue);

                        Console.WriteLine($"性能开关 {index + 1} 设置为: {value}");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用性能设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载性能开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckPowerCfgStatus(PerformanceSetting setting)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "powercfg.exe",
                    Arguments = "/a",
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

                    if (setting.IsPowerCfgCommand && setting.EnableValue.ToString() == "off")
                    {
                        // 检测休眠是否已关闭
                        return output.Contains("休眠不可用") || output.Contains("休眠不可用") ||
                               output.Contains("Hibernation has not been enabled");
                    }
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        private bool CheckDismStatus(PerformanceSetting setting)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "DISM.exe",
                    Arguments = "/Online /Get-ReservedStorageState",
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

                    if (setting.IsDismCommand && setting.EnableValue.ToString() == "Disabled")
                    {
                        // 检测保留空间是否已禁用
                        return output.Contains("已禁用") || output.Contains("Disabled") ||
                               output.Contains("保留存储状态: 已禁用");
                    }
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        private bool CheckPerformanceSetting(PerformanceSetting setting)
        {
            try
            {
                // 特殊命令处理
                if (setting.IsPowerCfgCommand)
                {
                    return CheckPowerCfgStatus(setting);
                }

                if (setting.IsDismCommand)
                {
                    return CheckDismStatus(setting);
                }

                // 服务操作检测
                if (setting.IsService)
                {
                    return CheckServiceStatus(setting.ServiceName, (int)setting.EnableValue);
                }

                // 多键值检测
                if (setting.HasMultipleKeys)
                {
                    return CheckMultipleKeysSetting(setting);
                }

                // 多值检测
                if (setting.HasMultipleValues)
                {
                    return CheckMultipleValuesSetting(setting);
                }

                using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                {
                    using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                    {
                        if (key == null)
                        {
                            // 键不存在时的处理逻辑
                            if (setting.EnableValue == null)
                                return true; // 键不存在且期望值为null，表示已优化
                            else
                                return false; // 键不存在但期望值不为null，表示未优化
                        }

                        // 检查值是否存在
                        object currentValue = key.GetValue(setting.ValueName, null);
                        if (currentValue == null)
                        {
                            // 值不存在时的处理逻辑
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
                    return currentValue.ToString() == expectedValue.ToString();
                case RegistryValueKind.Binary:
                    var currentBytes = currentValue as byte[];
                    var expectedBytes = expectedValue as byte[];
                    return currentBytes != null && expectedBytes != null && currentBytes.SequenceEqual(expectedBytes);
                default:
                    return false;
            }
        }

        private bool CheckServiceStatus(string serviceName, int expectedStatus)
        {
            try
            {
                // 使用sc命令查询服务状态，更可靠
                using (Process process = new Process())
                {
                    process.StartInfo.FileName = "sc";
                    process.StartInfo.Arguments = $"query \"{serviceName}\"";
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.CreateNoWindow = true;
                    process.Start();

                    string output = process.StandardOutput.ReadToEnd();
                    process.WaitForExit();

                    // 检查服务是否存在
                    if (output.Contains("1060") || output.Contains("指定的服务未安装"))
                        return false;

                    // 使用注册表验证启动类型
                    using (var baseKey = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Default))
                    {
                        using (var key = baseKey.OpenSubKey($@"SYSTEM\CurrentControlSet\Services\{serviceName}", false))
                        {
                            if (key == null) return false;
                            var currentStatus = key.GetValue("Start", -1);
                            return currentStatus != null && Convert.ToInt32(currentStatus) == expectedStatus;
                        }
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private bool CheckMultipleKeysSetting(PerformanceSetting setting)
        {
            // 简化处理，只检查第一个键值
            var values = setting.EnableValue as Dictionary<string, object>;
            if (values == null || values.Count == 0) return false;

            var firstKey = values.Keys.First();
            var keyParts = firstKey.Split('\\');
            var actualKeyPath = string.Join("\\", keyParts.Take(keyParts.Length - 1));
            var valueName = keyParts.Last();

            using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
            {
                using (var key = baseKey.OpenSubKey(actualKeyPath, false))
                {
                    if (key == null) return false;
                    var currentValue = key.GetValue(valueName, null);
                    return currentValue != null && Convert.ToInt32(currentValue) == Convert.ToInt32(values[firstKey]);
                }
            }
        }

        private bool CheckMultipleValuesSetting(PerformanceSetting setting)
        {
            // 简化处理，只检查第一个值
            var values = setting.EnableValue as Dictionary<string, object>;
            if (values == null || values.Count == 0) return false;

            var firstValue = values.First();
            using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
            {
                using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                {
                    if (key == null) return false;
                    var currentValue = key.GetValue(firstValue.Key, null);
                    return currentValue != null && Convert.ToInt32(currentValue) == Convert.ToInt32(firstValue.Value);
                }
            }
        }

        private void ApplyPerformanceSetting(PerformanceSetting setting, object value)
        {
            try
            {
                // 服务操作处理
                if (setting.IsService)
                {
                    ConfigureService(setting.ServiceName, Convert.ToInt32(value));
                    return;
                }

                if (setting.RequiresAdmin)
                {
                    // 使用NSudoLG提权执行
                    string registryPath = $"{GetRegistryPath(setting.Hive)}\\{setting.KeyPath}";
                    string valueType = GetRegistryValueKind(setting.ValueKind);
                    string valueData = GetValueString(value, setting.ValueKind);

                    // 修正NSudo参数格式
                    string args;
                    if (value == null)
                    {
                        // 删除值
                        args = $"-U:T -P:E -ShowWindowMode:Hide reg delete \"{registryPath}\" /v \"{setting.ValueName}\" /f";
                    }
                    else
                    {
                        // 设置值
                        args = $"-U:T -P:E -ShowWindowMode:Hide reg add \"{registryPath}\" /v \"{setting.ValueName}\" /t {valueType} /d \"{valueData}\" /f";
                    }

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
                                try
                                {
                                    key.DeleteValue(setting.ValueName, false);
                                }
                                catch (ArgumentException)
                                {
                                    // 值不存在，忽略
                                }
                            }
                            else
                            {
                                key.SetValue(setting.ValueName, value, setting.ValueKind);
                            }
                        }
                    }
                }

                System.Threading.Thread.Sleep(200);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用性能设置失败: {ex.Message}");
                Console.WriteLine($"路径: {setting.KeyPath}\\{setting.ValueName}");
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

        private string GetRegistryValueKind(RegistryValueKind valueKind)
        {
            switch (valueKind)
            {
                case RegistryValueKind.DWord:
                    return "REG_DWORD";
                case RegistryValueKind.String:
                    return "REG_SZ";
                case RegistryValueKind.Binary:
                    return "REG_BINARY";
                default:
                    return "REG_SZ";
            }
        }

        private string GetValueString(object value, RegistryValueKind valueKind)
        {
            if (value == null) return "";

            switch (valueKind)
            {
                case RegistryValueKind.Binary:
                    var bytes = value as byte[];
                    return bytes != null ? BitConverter.ToString(bytes).Replace("-", "") : "";
                default:
                    return value.ToString();
            }
        }

        private void ExecuteNsudoCommand(string arguments)
        {
            try
            {
                Console.WriteLine($"执行NSudo命令: {nsudoPath} {arguments}");

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

                    process.WaitForExit();

                    Console.WriteLine($"NSudo输出: {output}");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Console.WriteLine($"NSudo错误: {error}");
                    }
                    Console.WriteLine($"NSudo退出代码: {process.ExitCode}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行NSudo命令失败: {ex.Message}");
            }
        }

        private void ExecutePowerCfgCommand(string argument)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "powercfg.exe",
                    Arguments = $"/h {argument}",
                    UseShellExecute = false,
                    CreateNoWindow = true
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
                Console.WriteLine($"执行powercfg命令失败: {ex.Message}");
            }
        }

        private void ExecuteDismCommand(string argument)
        {
            try
            {
                string args = $"/Online /Set-ReservedStorageState /State:{argument}";
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = "DISM.exe",
                    Arguments = args,
                    UseShellExecute = false,
                    CreateNoWindow = true
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
                Console.WriteLine($"执行DISM命令失败: {ex.Message}");
            }
        }

        private void ConfigureService(string serviceName, int startType)
        {
            try
            {
                string startTypeStr;
                switch (startType)
                {
                    case 2: startTypeStr = "auto"; break;
                    case 3: startTypeStr = "demand"; break;
                    case 4: startTypeStr = "disabled"; break;
                    default: startTypeStr = "demand"; break;
                }

                // 配置服务启动类型
                string configArgs = $"-U:T -P:E -ShowWindowMode:Hide sc config \"{serviceName}\" start= {startTypeStr}";
                ExecuteNsudoCommand(configArgs);

                // 处理服务状态
                if (startType == 4) // 禁用时停止服务
                {
                    string stopArgs = $"-U:T -P:E -ShowWindowMode:Hide sc stop \"{serviceName}\"";
                    ExecuteNsudoCommand(stopArgs);
                }
                else if (startType == 2) // 自动时启动服务
                {
                    string startArgs = $"-U:T -P:E -ShowWindowMode:Hide sc start \"{serviceName}\"";
                    ExecuteNsudoCommand(startArgs);
                }

                System.Threading.Thread.Sleep(500); // 给服务操作一些时间
            }
            catch (Exception ex)
            {
                Console.WriteLine($"配置服务 {serviceName} 失败: {ex.Message}");
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

    public class PerformanceSetting
    {
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public bool RequiresAdmin { get; set; }
        public RegistryValueKind ValueKind { get; set; }
        public bool IsService { get; set; }
        public string ServiceName { get; set; }
        public bool IsPowerCfgCommand { get; set; }
        public bool IsDismCommand { get; set; }
        public bool HasMultipleValues { get; set; }
        public bool HasMultipleKeys { get; set; }
    }
}