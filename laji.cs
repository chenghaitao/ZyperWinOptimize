using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace ZyperWin__
{
    public partial class laji : UserControl
    {
        private CheckBox[] group1;
        private CheckBox[] group2;
        private CheckBox[] group3;
        private CheckBox[] group4;
        public laji()
        {
            InitializeComponent();
            InitializeGroups();
            SetupEventHandlers();

            // 直接使用Panel的自带滚动功能
            panel1.AutoScroll = true;
            panel2.Parent = panel1;

            // 隐藏自定义滚动条
            vScrollBar1.Visible = false;
        }
        private void InitializeGroups()
        {
            group1 = new CheckBox[] { checkBox1, checkBox2, checkBox3, checkBox4, checkBox5, checkBox6, checkBox7, checkBox8 };
            group2 = new CheckBox[] { checkBox9, checkBox10 };
            group3 = new CheckBox[] { checkBox11, checkBox12, checkBox13, checkBox14 };
            group4 = new CheckBox[] { checkBox15, checkBox16, checkBox17, checkBox18, checkBox19, checkBox20, checkBox21 };
        }

        // 绑定事件
        private void SetupEventHandlers()
        {
            // All1 控制 group1
            All1.CheckedChanged += All1_CheckedChanged;

            All2.CheckedChanged += All2_CheckedChanged;
            All3.CheckedChanged += All3_CheckedChanged;
            All4.CheckedChanged += All4_CheckedChanged;

            // 为每组小 CheckBox 添加事件
            AddReverseHandler(group1, All1);
            AddReverseHandler(group2, All2);
            AddReverseHandler(group3, All3);
            AddReverseHandler(group4, All4);
        }

        // All1 事件：控制子项
        private void All1_CheckedChanged(object sender, EventArgs e)
        {
            SetGroupCheckState(group1, All1.Checked);
        }
        private void All2_CheckedChanged(object sender, EventArgs e)
        {
            SetGroupCheckState(group2, All2.Checked);
        }
        private void All3_CheckedChanged(object sender, EventArgs e)
        {
            SetGroupCheckState(group3, All3.Checked);
        }
        private void All4_CheckedChanged(object sender, EventArgs e)
        {
            SetGroupCheckState(group4, All4.Checked);
        }

        // 设置子项状态（避免触发事件循环）
        private void SetGroupCheckState(CheckBox[] group, bool isChecked)
        {
            foreach (CheckBox cb in group)
            {
                cb.CheckedChanged -= SmallCheckBox_CheckedChanged; // 移除事件
                cb.Checked = isChecked;
                cb.CheckedChanged += SmallCheckBox_CheckedChanged; // 重新绑定
            }
        }

        // 为每组添加反向监听
        private void AddReverseHandler(CheckBox[] group, CheckBox allCheckBox)
        {
            foreach (CheckBox cb in group)
            {
                cb.CheckedChanged += SmallCheckBox_CheckedChanged;
            }
            // 初始状态同步
            UpdateAllState(group, allCheckBox);
        }

        // 小 CheckBox 变化时，更新 All 状态
        private void SmallCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (group1.Contains((CheckBox)sender)) UpdateAllState(group1, All1);
            else if (group2.Contains((CheckBox)sender)) UpdateAllState(group2, All2);
            else if (group3.Contains((CheckBox)sender)) UpdateAllState(group3, All3);
            else if (group4.Contains((CheckBox)sender)) UpdateAllState(group4, All4);
        }

        // 更新 All CheckBox 状态：只有全选才勾上
        private void UpdateAllState(CheckBox[] group, CheckBox allCheckBox)
        {
            bool allChecked = true;
            for (int i = 0; i < group.Length; i++)
            {
                if (!group[i].Checked)
                {
                    allChecked = false;
                    break;
                }
            }

            // 关键：防止触发 All 的 CheckedChanged 事件
            allCheckBox.CheckedChanged -= All1_CheckedChanged; // 根据组替换
            if (allCheckBox == All1) allCheckBox.CheckedChanged -= All1_CheckedChanged;
            if (allCheckBox == All2) allCheckBox.CheckedChanged -= All2_CheckedChanged;
            if (allCheckBox == All3) allCheckBox.CheckedChanged -= All3_CheckedChanged;
            if (allCheckBox == All4) allCheckBox.CheckedChanged -= All4_CheckedChanged;

            allCheckBox.Checked = allChecked;

            // 重新绑定
            if (allCheckBox == All1) allCheckBox.CheckedChanged += All1_CheckedChanged;
            if (allCheckBox == All2) allCheckBox.CheckedChanged += All2_CheckedChanged;
            if (allCheckBox == All3) allCheckBox.CheckedChanged += All3_CheckedChanged;
            if (allCheckBox == All4) allCheckBox.CheckedChanged += All4_CheckedChanged;
        }


        private async void uiButton1_Click(object sender, EventArgs e)
        {
            // 定义所有任务
            var tasks = new[]
            {
        (checkBox: checkBox1,  cmd: "del /f /s /q \"%LocalAppData%\\Microsoft\\Terminal Server Client\\Cache\\*\" >nul 2>&1"),
        (checkBox: checkBox2,  cmd: "del /f /s /q \"%SystemRoot%\\SoftwareDistribution\\Download\\*\" >nul 2>&1"),
        (checkBox: checkBox3,  cmd: "del /f /s /q \"%LocalAppData%\\Microsoft\\Windows\\INetCache\\*\" >nul 2>&1"),
        (checkBox: checkBox4,  cmd: "del /f /s /q \"%LocalAppData%\\Microsoft\\Windows\\INetCookies\\*\" >nul 2>&1"),
        (checkBox: checkBox5,  cmd: "del /f /s /q \"%LocalAppData%\\Microsoft\\Windows\\Explorer\\thumbcache_*.db\" >nul 2>&1"),
        (checkBox: checkBox6,  cmd: "del /f /s /q \"%LocalAppData%\\Local\\D3DSCache\\*\" >nul 2>&1"),
        (checkBox: checkBox7,  cmd: "rd /s /q \"%WinDir%\\assembly\\NativeImages_v4.0.30319_32\" >nul 2>&1 & rd /s /q \"%WinDir%\\assembly\\NativeImages_v4.0.30319_64\" >nul 2>&1"),
        (checkBox: checkBox8,  cmd: "del /f /s /q \"%SystemRoot%\\SoftwareDistribution\\DeliveryOptimization\\*\" >nul 2>&1"),
        (checkBox: checkBox9,  cmd: "dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1"),
        (checkBox: checkBox10, cmd: "powershell -Command \"Get-AppxPackage -AllUsers | Where-Object {$_.Status -eq 'Error'} | Remove-AppxPackage -ErrorAction SilentlyContinue\" >nul"),
        (checkBox: checkBox11, cmd: "del /f /s /q \"%SystemRoot%\\Logs\\*\" >nul 2>&1"),
        (checkBox: checkBox12, cmd: "del /f /s /q \"%ProgramData%\\Microsoft\\Windows\\WER\\ReportQueue\\*\" >nul 2>&1"),
        (checkBox: checkBox13, cmd: "del /f /s /q \"%ProgramData%\\Microsoft\\Diagnosis\\*\" >nul 2>&1"),
        (checkBox: checkBox14, cmd: "del /f /s /q \"%SystemRoot%\\Minidump\\*.dmp\" >nul 2>&1 & del /f /q \"%SystemRoot%\\memory.dmp\" >nul 2>&1"),
        (checkBox: checkBox15, cmd: "del /f /s /q \"%ProgramData%\\Microsoft\\Windows Defender\\Scans\\*\" >nul 2>&1"),
        (checkBox: checkBox16, cmd: "del /f /s /q \"%SystemRoot%\\WinSxS\\Temp\\*\" >nul 2>&1"),
        (checkBox: checkBox17, cmd: "del /f /s /q \"%SystemRoot%\\Temp\\*\" >nul 2>&1"),
        (checkBox: checkBox18, cmd: "del /f /s /q \"%SystemDrive%\\*.dmp\" >nul 2>&1"),
        (checkBox: checkBox19, cmd: "rd /s /q \"%SystemDrive%\\$Recycle.bin\" >nul 2>&1"),
        (checkBox: checkBox20, cmd: "del /f /s /q \"%SystemDrive%\\Windows\\Temp\\*\" >nul 2>&1 & del /f /s /q \"%SystemRoot%\\Temp\\*\" >nul 2>&1 & del /f /s /q \"%TEMP%\\*\" >nul 2>&1"),
        (checkBox: checkBox21, cmd: "del /f /s /q \"%SystemRoot%\\Prefetch\\*\" >nul 2>&1")
    };

            // 筛选被勾选的任务
            var selectedTasks = new List<(CheckBox checkBox, string cmd)>();
            foreach (var task in tasks)
            {
                if (task.checkBox.Checked)
                {
                    selectedTasks.Add(task);
                }
            }

            if (selectedTasks.Count == 0)
            {
                MessageBox.Show("请至少选择一个要清理的项目！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            // ✅ 正确设置 SunnyUI 进度条：只设置 Maximum 和 Value
            uiProcessBar1.Value = 0;
            uiProcessBar1.Maximum = selectedTasks.Count;

            // 禁用按钮
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton1.Enabled = false;
            uiButton1.Text = "清理中...";

            // 异步执行清理任务
            await Task.Run(() =>
            {
                for (int i = 0; i < selectedTasks.Count; i++)
                {
                    // 执行命令
                    ExecuteCommand(selectedTasks[i].cmd);

                    // 更新进度条（回到 UI 线程）
                    this.Invoke(new Action(() =>
                    {
                        uiProcessBar1.Value = i + 1;  // 每完成一项 +1
                    }));
                }
            });

            // 恢复按钮
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = true;
            }
            uiButton1.Enabled = true;
            uiButton1.Text = "开始清理";
            MessageBox.Show($"共清理 {selectedTasks.Count} 个项目，完成！", "ZyperWin++", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        private void ExecuteCommand(string command)
        {
            try
            {
                using (var p = new System.Diagnostics.Process())
                {
                    p.StartInfo.FileName = "cmd.exe";
                    p.StartInfo.Arguments = "/C " + command;
                    p.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                    p.StartInfo.CreateNoWindow = true;
                    p.StartInfo.UseShellExecute = false;
                    p.Start();
                    p.WaitForExit();
                }
            }
            catch { /* 静默忽略 */ }
        }
    }
}
