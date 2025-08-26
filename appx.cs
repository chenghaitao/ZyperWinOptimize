using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class appx : UserControl
    {
        public appx()
        {
            InitializeComponent();
            this.Load += new System.EventHandler(this.appx_Load);
        }

        private async void appx_Load(object sender, EventArgs e)
        {
            await LoadAppListAsync();
            checkedListBox1.MouseUp += CheckedListBox1_MouseUp;
        }

        private void CheckedListBox1_MouseUp(object sender, MouseEventArgs e)
        {
            // 获取点击的是哪一行
            int index = checkedListBox1.IndexFromPoint(e.Location);
            if (index != ListBox.NoMatches && index >= 0)
            {
                // 切换该项的勾选状态
                bool isChecked = checkedListBox1.GetItemChecked(index);
                checkedListBox1.SetItemChecked(index, !isChecked);
            }
        }

        private async Task LoadAppListAsync()
        {
            try
            {
                // 显示加载中
                checkedListBox1.Invoke((MethodInvoker)delegate
                {
                    checkedListBox1.Items.Clear();
                    checkedListBox1.Items.Add("正在加载应用，请稍候...");
                });

                List<string> packages = new List<string>();

                await Task.Run(() =>
                {
                    try
                    {
                        string psScript = "Get-AppxPackage | Where-Object { !$_.IsFramework -and !$_.NonRemovable } | ForEach-Object { $_.PackageFullName }";

                        using (Process p = new Process())
                        {
                            p.StartInfo.FileName = "powershell.exe";
                            p.StartInfo.Arguments = $"-Command \"{psScript}\"";
                            p.StartInfo.UseShellExecute = false;
                            p.StartInfo.RedirectStandardOutput = true;
                            p.StartInfo.RedirectStandardError = true;
                            p.StartInfo.CreateNoWindow = true;

                            p.Start();

                            string output = p.StandardOutput.ReadToEnd();
                            string error = p.StandardError.ReadToEnd();
                            p.WaitForExit();

                            if (p.ExitCode == 0)
                            {
                                packages = output.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries)
                                                 .Select(s => s.Trim())
                                                 .Where(s => !string.IsNullOrEmpty(s))
                                                 .ToList();
                            }
                            else
                            {
                                throw new Exception("PowerShell 错误: " + error);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        packages.Clear();
                        packages.Add("加载失败: " + ex.Message);
                    }
                });

                // 更新到 UI
                checkedListBox1.Invoke((MethodInvoker)delegate
                {
                    checkedListBox1.Items.Clear();
                    if (packages.Count > 0 && !packages[0].StartsWith("加载失败"))
                    {
                        foreach (string pkg in packages)
                        {
                            checkedListBox1.Items.Add(pkg, false); // 默认不勾选
                        }
                    }
                    else
                    {
                        checkedListBox1.Items.AddRange(packages.ToArray());
                    }
                });

            }
            catch (Exception ex)
            {
                checkedListBox1.Invoke((MethodInvoker)delegate
                {
                    checkedListBox1.Items.Clear();
                    checkedListBox1.Items.Add("异常: " + ex.Message);
                });
            }
        }

        private async void uiButton1_Click(object sender, EventArgs e)
        {
            // 获取所有勾选的应用
            List<string> selectedPackages = new List<string>();
            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                if (checkedListBox1.GetItemChecked(i))
                {
                    string item = checkedListBox1.Items[i].ToString();
                    if (!item.StartsWith("正在加载") && !item.StartsWith("没有") && !item.StartsWith("加载失败"))
                    {
                        selectedPackages.Add(item);
                    }
                }
            }

            if (selectedPackages.Count == 0)
            {
                MessageBox.Show("请至少勾选一个要卸载的应用！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            // 确认卸载
            string msg = "即将卸载以下应用：\n\n" + string.Join("\n", selectedPackages.Take(10))
                       + (selectedPackages.Count > 10 ? $"\n\n（还有 {selectedPackages.Count - 10} 个）" : "");

            DialogResult dr = MessageBox.Show(msg + "\n\n确定要继续吗？", "ZyperWin++", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (dr != DialogResult.Yes) return;

            // 设置进度条
            uiProcessBar1.Value = 0;
            uiProcessBar1.Maximum = selectedPackages.Count;

            // 禁用按钮
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton1.Enabled = false;
            uiButton1.Text = "卸载中...";

            // 异步卸载
            await Task.Run(() =>
            {
                for (int i = 0; i < selectedPackages.Count; i++)
                {
                    string pkg = selectedPackages[i];
                    try
                    {
                        using (Process p = new Process())
                        {
                            p.StartInfo.FileName = "powershell.exe";
                            p.StartInfo.Arguments = $"-Command \"Remove-AppxPackage -Package '{pkg}'\"";
                            p.StartInfo.UseShellExecute = false;
                            p.StartInfo.CreateNoWindow = true;
                            p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                            p.Start();
                            p.WaitForExit(); // 等待卸载完成
                        }
                    }
                    catch { /* 忽略单个失败 */ }

                    // 更新进度（回到 UI 线程）
                    this.Invoke((MethodInvoker)delegate
                    {
                        uiProcessBar1.Value = i + 1;
                    });
                }
            });

            await LoadAppListAsync();  // 刷新列表

            // 完成
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = true;
            }
            uiButton1.Enabled = true;
            uiButton1.Text = "开始卸载";
            MessageBox.Show($"已成功卸载 {selectedPackages.Count} 个应用！", "ZyperWin++", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
