using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class recover : UserControl
    {
        public recover()
        {
            InitializeComponent();
        }

        [DllImport("user32.dll")]
        private static extern IntPtr GetDesktopWindow();

        private bool ExecuteCmdHidden(string commands)
        {
            try
            {
                using (Process p = new Process())
                {
                    p.StartInfo.FileName = "cmd.exe";
                    p.StartInfo.Arguments = "/c " + commands;
                    p.StartInfo.UseShellExecute = false;
                    p.StartInfo.CreateNoWindow = true;
                    p.StartInfo.RedirectStandardOutput = true;
                    p.StartInfo.RedirectStandardError = true;
                    p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;

                    p.Start();
                    string output = p.StandardOutput.ReadToEnd();
                    string error = p.StandardError.ReadToEnd();
                    p.WaitForExit();

                    if (p.ExitCode != 0)
                    {
                        throw new Exception($"CMD 退出码: {p.ExitCode}\n输出: {output}\n错误: {error}");
                    }

                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("CMD 执行失败: " + ex.Message);
            }
        }

        private async void uiButton1_Click(object sender, EventArgs e)
        {
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton1.Enabled = false;
            uiButton1.Text = "还原中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他还原";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他还原";
            uiButton4.Enabled = false;
            uiButton4.Text = "正在其他还原";
            uiButton5.Enabled = false;
            uiButton5.Text = "正在其他还原";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                // 执行批处理优化
                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "4.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到还原批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统优化已还原完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}");
            }
            finally
            {
                if (MainWindow.SharedTreeView != null)
                {
                    MainWindow.SharedTreeView.Enabled = true;
                }
                uiButton1.Text = "基本优化";
                uiButton1.Enabled = true;
                uiButton2.Text = "深度优化";
                uiButton2.Enabled = true;
                uiButton3.Text = "极限优化";
                uiButton3.Enabled = true;
                uiButton4.Text = "系统更新";
                uiButton4.Enabled = true;
                uiButton5.Text = "Defender";
                uiButton5.Enabled = true;
                uiProcessBar1.Value = 0;
            }
        }

        private async void uiButton2_Click(object sender, EventArgs e)
        {
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton2.Enabled = false;
            uiButton2.Text = "还原中...";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他还原";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他还原";
            uiButton4.Enabled = false;
            uiButton4.Text = "正在其他还原";
            uiButton5.Enabled = false;
            uiButton5.Text = "正在其他还原";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                // 执行批处理优化
                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "5.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到还原批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统优化已还原完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}");
            }
            finally
            {
                if (MainWindow.SharedTreeView != null)
                {
                    MainWindow.SharedTreeView.Enabled = true;
                }
                uiButton1.Text = "基本优化";
                uiButton1.Enabled = true;
                uiButton2.Text = "深度优化";
                uiButton2.Enabled = true;
                uiButton3.Text = "极限优化";
                uiButton3.Enabled = true;
                uiButton4.Text = "系统更新";
                uiButton4.Enabled = true;
                uiButton5.Text = "Defender";
                uiButton5.Enabled = true;
                uiProcessBar1.Value = 0;
            }
        }

        private async void uiButton3_Click(object sender, EventArgs e)
        {
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton3.Enabled = false;
            uiButton3.Text = "还原中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他还原";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他还原";
            uiButton4.Enabled = false;
            uiButton4.Text = "正在其他还原";
            uiButton5.Enabled = false;
            uiButton5.Text = "正在其他还原";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                // 执行批处理优化
                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "6.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到还原批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统优化已还原完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}");
            }
            finally
            {
                if (MainWindow.SharedTreeView != null)
                {
                    MainWindow.SharedTreeView.Enabled = true;
                }
                uiButton1.Text = "基本优化";
                uiButton1.Enabled = true;
                uiButton2.Text = "深度优化";
                uiButton2.Enabled = true;
                uiButton3.Text = "极限优化";
                uiButton3.Enabled = true;
                uiButton4.Text = "系统更新";
                uiButton4.Enabled = true;
                uiButton5.Text = "Defender";
                uiButton5.Enabled = true;
                uiProcessBar1.Value = 0;
            }
        }

        private async void uiButton4_Click(object sender, EventArgs e)
        {
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton4.Enabled = false;
            uiButton4.Text = "还原中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他还原";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他还原";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他还原";
            uiButton5.Enabled = false;
            uiButton5.Text = "正在其他还原";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                // 执行批处理优化
                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "7.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到还原批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统优化已还原完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}");
            }
            finally
            {
                if (MainWindow.SharedTreeView != null)
                {
                    MainWindow.SharedTreeView.Enabled = true;
                }
                uiButton1.Text = "基本优化";
                uiButton1.Enabled = true;
                uiButton2.Text = "深度优化";
                uiButton2.Enabled = true;
                uiButton3.Text = "极限优化";
                uiButton3.Enabled = true;
                uiButton4.Text = "系统更新";
                uiButton4.Enabled = true;
                uiButton5.Text = "Defender";
                uiButton5.Enabled = true;
                uiProcessBar1.Value = 0;
            }
        }

        private async void uiButton5_Click(object sender, EventArgs e)
        {
            if (MainWindow.SharedTreeView != null)
            {
                MainWindow.SharedTreeView.Enabled = false;
            }
            uiButton5.Enabled = false;
            uiButton5.Text = "还原中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他还原";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他还原";
            uiButton4.Enabled = false;
            uiButton4.Text = "正在其他还原";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他还原";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                // 执行批处理优化
                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "8.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到还原批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统优化已还原完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}");
            }
            finally
            {
                if (MainWindow.SharedTreeView != null)
                {
                    MainWindow.SharedTreeView.Enabled = true;
                }
                uiButton1.Text = "基本优化";
                uiButton1.Enabled = true;
                uiButton2.Text = "深度优化";
                uiButton2.Enabled = true;
                uiButton3.Text = "极限优化";
                uiButton3.Enabled = true;
                uiButton4.Text = "系统更新";
                uiButton4.Enabled = true;
                uiButton5.Text = "Defender";
                uiButton5.Enabled = true;
                uiProcessBar1.Value = 0;
            }
        }

        private void RestartExplorerSafely()
        {
            try
            {
                // 获取当前桌面窗口句柄
                IntPtr desktopHandle = GetDesktopWindow();

                // 结束explorer进程
                foreach (Process process in Process.GetProcessesByName("explorer"))
                {
                    try
                    {
                        process.Kill();
                        process.WaitForExit(5000);
                    }
                    catch
                    {
                        // 忽略无法终止的进程
                    }
                }

                // 等待一段时间确保进程完全结束
                System.Threading.Thread.Sleep(2000);

                // 启动新的explorer进程
                ProcessStartInfo startInfo = new ProcessStartInfo("explorer.exe");

            }
            catch (Exception ex)
            {
                throw new Exception("重启资源管理器失败: " + ex.Message);
            }
        }
    }
}
