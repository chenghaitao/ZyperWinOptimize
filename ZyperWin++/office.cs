using Sunny.UI;
using System;
using System.Diagnostics;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class office : UserControl
    {
        private UIComboBox comboBoxVersion;   // 假设 uiComboBox 类型是 UIComboBox
        private UIComboBox comboBoxArchitecture;
        private UIComboBox comboBoxType;
        private Button buttonInstall;
        public office()
        {
            InitializeComponent();
            InitializeUI(); // 手动初始化控件
        }

        private void InitializeUI()
        {
            // 示例：如果你是手动创建控件
            comboBoxVersion = new UIComboBox();
            comboBoxVersion.Items.Add("Office365");
            comboBoxVersion.Items.Add("Office2024");
            comboBoxVersion.Items.Add("Office2021");
            comboBoxVersion.Items.Add("Office2019");
            comboBoxVersion.SelectedIndex = 0;

            comboBoxArchitecture = new UIComboBox();
            comboBoxArchitecture.Items.Add("64位");
            comboBoxArchitecture.Items.Add("32位");
            comboBoxArchitecture.SelectedIndex = 0;

            comboBoxType = new UIComboBox();
            comboBoxType.Items.Add("完整版");
            comboBoxType.Items.Add("常用三件套");
            comboBoxType.SelectedIndex = 0;

            buttonInstall = new Button();
            buttonInstall.Text = "开始安装";
            buttonInstall.Click += uiButton1_Click;

            // 添加到窗体（略）
        }

        private void uiButton1_Click(object sender, EventArgs e)
        {
            uiButton1.Enabled = false;
            uiButton1.Text = "执行中...";

            // 获取用户选择的版本、架构和类型
            string version = uiComboBox1.SelectedItem?.ToString();
            string architecture = uiComboBox2.SelectedItem?.ToString();
            string type = uiComboBox3.SelectedItem?.ToString();

            if (string.IsNullOrEmpty(version) || string.IsNullOrEmpty(architecture) || string.IsNullOrEmpty(type))
            {
                MessageBox.Show("请确保所有选项都已选择！");
                return;
            }

            // 根据选择映射productCode
            string productCode = "";
            switch (version)
            {
                case "Office365":
                    productCode = "O365ProPlusRetail";
                    break;
                case "Office2024":
                    productCode = "ProPlus2024Retail";
                    break;
                case "Office2021":
                    productCode = "ProPlus2021Retail";
                    break;
                case "Office2019":
                    productCode = "ProPlus2019Retail";
                    break;
                default:
                    MessageBox.Show("未知版本");
                    return;
            }

            // 架构映射
            string arch = architecture == "64位" ? "64" : "32";

            // 类型映射
            string excludeApps = "";
            if (type == "常用三件套")
            {
                excludeApps = "&exclude_apps=" + productCode + ":Access,Bing,Groove,Lync,Outlook,OneNote,Publisher,Teams";
            }

            // 构建最终的模板URL
            string template = $"https://www.coolhub.top/get/?prod_to_add={productCode}_zh-cn{excludeApps}&arch={arch}";

            // 确认对话框
            var result = MessageBox.Show($"即将安装：{version} ({arch})\n类型：{type}\n再检查一遍是否安装此版本？", "都准备好了吗？", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                try
                {
                    ProcessStartInfo psi = new ProcessStartInfo();
                    psi.FileName = "powershell.exe";
                    psi.Arguments = $"-NoExit -Command \"irm '{template}' | iex\"";
                    psi.UseShellExecute = true;
                    psi.CreateNoWindow = false;
                    Process.Start(psi);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("启动 PowerShell 失败：" + ex.Message);
                }
                finally
                {
                    // 恢复按钮状态
                    uiButton1.Enabled = true;
                    uiButton1.Text = "开始安装";
                }
            }
            uiButton1.Enabled = true;
            uiButton1.Text = "开始安装";
        }
    }
}
