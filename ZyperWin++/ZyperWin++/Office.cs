using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class Office : UserControl
    {
        private AntdUI.Select comboBoxVersion;
        private AntdUI.Select comboBoxArchitecture;
        private AntdUI.Select comboBoxType;
        private AntdUI.Button buttonInstall;

        public Office()
        {
            InitializeComponent();
            InitializeUI();
        }

        private void InitializeUI()
        {
            // 初始化版本选择框
            comboBoxVersion = new AntdUI.Select();
            comboBoxVersion.Items.Add(new AntdUI.SelectItem("Office365", "Office365"));
            comboBoxVersion.Items.Add(new AntdUI.SelectItem("Office2024", "Office2024"));
            comboBoxVersion.Items.Add(new AntdUI.SelectItem("Office2021", "Office2021"));
            comboBoxVersion.Items.Add(new AntdUI.SelectItem("Office2019", "Office2019"));
            comboBoxVersion.SelectedIndex = 0;

            // 初始化架构选择框
            comboBoxArchitecture = new AntdUI.Select();
            comboBoxArchitecture.Items.Add(new AntdUI.SelectItem("64位", "64位"));
            comboBoxArchitecture.Items.Add(new AntdUI.SelectItem("32位", "32位"));
            comboBoxArchitecture.SelectedIndex = 0;

            // 初始化类型选择框
            comboBoxType = new AntdUI.Select();
            comboBoxType.Items.Add(new AntdUI.SelectItem("完整版", "完整版"));
            comboBoxType.Items.Add(new AntdUI.SelectItem("常用三件套", "常用三件套"));
            comboBoxType.SelectedIndex = 0;

            // 初始化按钮
            buttonInstall = new AntdUI.Button();
            buttonInstall.Text = "开始安装";
            buttonInstall.Click += ButtonInstall_Click;

            // 设置控件位置和大小（根据需要调整）
            comboBoxVersion.Location = new Point(20, 20);
            comboBoxVersion.Size = new Size(150, 32);

            comboBoxArchitecture.Location = new Point(180, 20);
            comboBoxArchitecture.Size = new Size(100, 32);

            comboBoxType.Location = new Point(290, 20);
            comboBoxType.Size = new Size(120, 32);

            buttonInstall.Location = new Point(420, 20);
            buttonInstall.Size = new Size(100, 32);

            // 添加到控件
            this.Controls.Add(comboBoxVersion);
            this.Controls.Add(comboBoxArchitecture);
            this.Controls.Add(comboBoxType);
            this.Controls.Add(buttonInstall);
        }

        private string GetSelectText(AntdUI.Select selectControl)
        {
            if (selectControl.SelectedIndex >= 0 && selectControl.SelectedIndex < selectControl.Items.Count)
            {
                // 尝试直接获取 Items 集合中的文本
                var item = selectControl.Items[selectControl.SelectedIndex];

                // 尝试不同的属性名
                var textProp = item.GetType().GetProperty("Text");
                if (textProp != null)
                    return textProp.GetValue(item)?.ToString();

                var valueProp = item.GetType().GetProperty("Value");
                if (valueProp != null)
                    return valueProp.GetValue(item)?.ToString();

                var nameProp = item.GetType().GetProperty("Name");
                if (nameProp != null)
                    return nameProp.GetValue(item)?.ToString();

                return item.ToString();
            }
            return selectControl.Text; // 备用方案
        }

        private void ButtonInstall_Click(object sender, EventArgs e)
        {
            buttonInstall.Enabled = false;
            buttonInstall.Text = "执行中...";

            string version = GetSelectText(select1);
            string architecture = GetSelectText(select2);
            string type = GetSelectText(select3);

            // 调试输出，查看实际获取的值
            Console.WriteLine($"Version: {version}, Architecture: {architecture}, Type: {type}");

            if (string.IsNullOrEmpty(version) || string.IsNullOrEmpty(architecture) || string.IsNullOrEmpty(type))
            {
                MessageBox.Show("请确保所有选项都已选择！");
                ButtonInstall.Enabled = true;
                ButtonInstall.Text = "开始安装";
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
                    buttonInstall.Enabled = true;
                    buttonInstall.Text = "开始安装";
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
            var result = MessageBox.Show($"即将安装：{version} ({arch}位)\n类型：{type}\n再检查一遍是否安装此版本？", "都准备好了吗？", MessageBoxButtons.YesNo);
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
            }

            // 恢复按钮状态
            buttonInstall.Enabled = true;
            buttonInstall.Text = "开始安装";
        }
    }
}