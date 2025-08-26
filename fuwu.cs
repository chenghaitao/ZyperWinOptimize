using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class fuwu : UserControl
    {
        private List<UISwitch> serviceSwitches = new List<UISwitch>();
        private List<ServiceSetting> serviceSettings = new List<ServiceSetting>();
        private string nsudoPath = @".\Bin\NSudoLG.exe";

        // 定义服务启动模式常量
        private const string AUTO_MODE = "auto";
        private const string DISABLED_MODE = "disabled";
        private const string DEMAND_MODE = "demand";

        public fuwu()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializeServiceSettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;

            this.Load += fuwu_Load;
        }

        private void InitializeComponentReferences()
        {
            // 添加服务开关控件引用（根据实际控件名称调整）
            serviceSwitches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5,
                uiSwitch6, uiSwitch7, uiSwitch8, uiSwitch9, uiSwitch10,
                uiSwitch11, uiSwitch12, uiSwitch13, uiSwitch14, uiSwitch15,
                uiSwitch16, uiSwitch17, uiSwitch18, uiSwitch19
            });
        }

        private void InitializeServiceSettings()
        {
            // 1. SecurityHealthService (安全健康服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "SecurityHealthService",
                DisplayName = "安全健康服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 2. SysMain (SuperFetch服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "SysMain",
                DisplayName = "SuperFetch服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 3. WSearch (Windows搜索服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "WSearch",
                DisplayName = "Windows搜索服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 4. UsoSvc (Windows更新服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "UsoSvc",
                DisplayName = "Windows更新服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 5. TrkWks (分布式链接跟踪服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "TrkWks",
                DisplayName = "分布式链接跟踪服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 6. WinDefend (Windows Defender服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "WinDefend",
                DisplayName = "Windows Defender服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 7. diagsvc (诊断服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "diagsvc",
                DisplayName = "诊断服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 8. DPS (诊断策略服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "DPS",
                DisplayName = "诊断策略服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 9. WdiServiceHost (诊断服务主机)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "WdiServiceHost",
                DisplayName = "诊断服务主机",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 10. WdiSystemHost (诊断系统主机)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "WdiSystemHost",
                DisplayName = "诊断系统主机",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 11. MapsBroker (地图服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "MapsBroker",
                DisplayName = "地图服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 12. iphlpsvc (IP助手服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "iphlpsvc",
                DisplayName = "IP助手服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 13. diagnosticshub.standardcollector.service (诊断中心收集器)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "diagnosticshub.standardcollector.service",
                DisplayName = "诊断中心收集器",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 14. SmsRouter (SMS路由器服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "SmsRouter",
                DisplayName = "SMS路由器服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 15. PcaSvc (程序兼容性助手)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "PcaSvc",
                DisplayName = "程序兼容性助手",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 16. ShellHWDetection (Shell硬件检测)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "ShellHWDetection",
                DisplayName = "Shell硬件检测",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 17. SgrmBroker (系统防护服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "SgrmBroker",
                DisplayName = "系统防护服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 18. Schedule (任务计划服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "Schedule",
                DisplayName = "任务计划服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });

            // 19. Wecsvc (Windows事件收集服务)
            serviceSettings.Add(new ServiceSetting
            {
                ServiceName = "Wecsvc",
                DisplayName = "Windows事件收集服务",
                AutoValue = AUTO_MODE,
                DisableValue = DISABLED_MODE
            });
        }

        private void fuwu_Load(object sender, EventArgs e)
        {
            LoadAllServiceSwitchStates();
        }

        private void LoadAllServiceSwitchStates()
        {
            for (int i = 0; i < Math.Min(serviceSwitches.Count, serviceSettings.Count); i++)
            {
                LoadServiceSwitchState(i);
            }
        }

        private void LoadServiceSwitchState(int index)
        {
            if (index >= serviceSwitches.Count || index >= serviceSettings.Count)
                return;

            var sw = serviceSwitches[index];
            var setting = serviceSettings[index];

            try
            {
                Console.WriteLine($"正在检查服务: {setting.ServiceName} ({setting.DisplayName})");

                bool isEnabled = CheckServiceSetting(setting);
                Console.WriteLine($"服务 {setting.ServiceName} 状态: {(isEnabled ? "启用" : "禁用")}");

                SetSwitchState(sw, isEnabled);

                // 绑定事件
                sw.ValueChanged += (s, ev) =>
                {
                    bool switchState = sw.Active;
                    try
                    {
                        if (switchState)
                        {
                            // 开关开 → 服务当前是禁用状态 → 要取消优化（启用服务）
                            ApplyServiceSetting(setting, setting.AutoValue);
                        }
                        else
                        {
                            // 开关关 → 服务当前是启用状态 → 要执行优化（禁用服务）
                            ApplyServiceSetting(setting, setting.DisableValue);
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用设置失败: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载服务开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckServiceSetting(ServiceSetting setting)
        {
            try
            {
                // 快速检测 - 直接使用 sc query 并查找 START_TYPE
                string queryArgs = $"query \"{setting.ServiceName}\"";
                string result = ExecuteCommand("sc", queryArgs);

                // 快速判断：如果包含 DISABLED 或 4，就是禁用状态
                bool isDisabled = result.Contains("DISABLED") || result.Contains(" 4 ");

                // 修正逻辑：禁用 → true（开），启用 → false（关）
                // 这样：服务已禁用 → 开关开，服务已启用 → 开关关
                return isDisabled;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"快速检测服务失败 {setting.ServiceName}: {ex.Message}");
                return false; // 默认返回关闭状态
            }
        }

        private string ExecuteCommand(string command, string arguments)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = command,
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
                    process.WaitForExit(1000); // 1秒超时

                    return output;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"执行命令失败: {ex.Message}");
                return string.Empty;
            }
        }
        private void ApplyServiceSetting(ServiceSetting setting, string startMode)
        {
            try
            {
                string action = startMode == AUTO_MODE ? "启用" : "禁用";

                // 使用NSudoLG提权执行服务配置命令
                string configArgs = $"-U:T -P:E -ShowWindowMode:Hide sc config \"{setting.ServiceName}\" start= {startMode}";
                ExecuteNsudoCommand(configArgs);

                // 如果禁用服务，则停止服务；如果启用服务，则启动服务
                if (startMode == DISABLED_MODE)
                {
                    string stopArgs = $"-U:T -P:E -ShowWindowMode:Hide sc stop \"{setting.ServiceName}\"";
                    ExecuteNsudoCommand(stopArgs);
                }
                else
                {
                    string startArgs = $"-U:T -P:E -ShowWindowMode:Hide sc start \"{setting.ServiceName}\"";
                    ExecuteNsudoCommand(startArgs);
                }

                Console.WriteLine($"[√] 已{action}: {setting.ServiceName} {setting.DisplayName}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"应用服务设置失败: {ex.Message}");
                Console.WriteLine($"服务: {setting.ServiceName}, 启动类型: {startMode}");
            }
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
            LoadAllServiceSwitchStates();
        }
    }

    public class ServiceSetting
    {
        public string ServiceName { get; set; }
        public string DisplayName { get; set; }
        public string AutoValue { get; set; }
        public string DisableValue { get; set; }
    }
}