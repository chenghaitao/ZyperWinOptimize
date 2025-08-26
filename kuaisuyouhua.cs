using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class kuaisuyouhua : UserControl
    {
        public kuaisuyouhua()
        {
            InitializeComponent();
        }

        // 添加User32 DLL导入
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
            uiButton1.Text = "优化中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他优化";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他优化";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 10;
                await Task.Delay(100);

                bool isRunning = await Task.Run(() => IsDefenderRunning());
                uiProcessBar1.Value = 30;

                if (isRunning)
                {
                    DialogResult result = MessageBox.Show("检测到Windows Defender正在运行，这可能会影响优化效果。\n\n是否要尝试关闭Defender？",
                                                        "Defender检测",
                                                        MessageBoxButtons.YesNo,
                                                        MessageBoxIcon.Warning);

                    if (result == DialogResult.Yes)
                    {
                        string exePath = Path.Combine(Application.StartupPath, ".\\Bin\\Defender_Control.exe");
                        if (File.Exists(exePath))
                        {
                            try
                            {
                                ProcessStartInfo psi = new ProcessStartInfo(exePath);
                                psi.UseShellExecute = true;

                                var proc = Process.Start(psi);
                                if (proc != null)
                                {
                                    await Task.Run(() => proc.WaitForExit());

                                    // 再次检查Defender状态
                                    isRunning = await Task.Run(() => IsDefenderRunning());
                                    if (isRunning)
                                    {
                                        DialogResult continueResult = MessageBox.Show("Defender 仍在运行，是否继续优化？",
                                                                                    "Defender仍在运行",
                                                                                    MessageBoxButtons.YesNo,
                                                                                    MessageBoxIcon.Question);
                                        if (continueResult == DialogResult.No)
                                        {
                                            return;
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show($"无法启动 Defender 控制工具: {ex.Message}\n\n将继续进行优化但效果可能受限。");
                            }
                        }
                        else
                        {
                            MessageBox.Show("未找到 Defender_Control.exe，将继续进行优化但效果可能受限。");
                        }
                    }
                }

                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "1.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到优化批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统已快速优化完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}", "ZyperWin++");
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
            uiButton2.Text = "优化中...";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他优化";
            uiButton3.Enabled = false;
            uiButton3.Text = "正在其他优化";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 10;
                await Task.Delay(100);

                bool isRunning = await Task.Run(() => IsDefenderRunning());
                uiProcessBar1.Value = 30;

                if (isRunning)
                {
                    DialogResult result = MessageBox.Show("检测到Windows Defender正在运行，这可能会影响优化效果。\n\n是否要尝试关闭Defender？",
                                                        "Defender检测",
                                                        MessageBoxButtons.YesNo,
                                                        MessageBoxIcon.Warning);

                    if (result == DialogResult.Yes)
                    {
                        string exePath = Path.Combine(Application.StartupPath, ".\\Bin\\Defender_Control.exe");
                        if (File.Exists(exePath))
                        {
                            try
                            {
                                ProcessStartInfo psi = new ProcessStartInfo(exePath);
                                psi.UseShellExecute = true;

                                var proc = Process.Start(psi);
                                if (proc != null)
                                {
                                    await Task.Run(() => proc.WaitForExit());

                                    // 再次检查Defender状态
                                    isRunning = await Task.Run(() => IsDefenderRunning());
                                    if (isRunning)
                                    {
                                        DialogResult continueResult = MessageBox.Show("Defender 仍在运行，是否继续优化？",
                                                                                    "Defender仍在运行",
                                                                                    MessageBoxButtons.YesNo,
                                                                                    MessageBoxIcon.Question);
                                        if (continueResult == DialogResult.No)
                                        {
                                            return;
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show($"无法启动 Defender 控制工具: {ex.Message}\n\n将继续进行优化但效果可能受限。");
                            }
                        }
                        else
                        {
                            MessageBox.Show("未找到 Defender_Control.exe，将继续进行优化但效果可能受限。");
                        }
                    }
                }

                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "2.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到优化批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统已快速优化完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}", "ZyperWin++");
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
            uiButton3.Text = "优化中...";
            uiButton2.Enabled = false;
            uiButton2.Text = "正在其他优化";
            uiButton1.Enabled = false;
            uiButton1.Text = "正在其他优化";
            uiProcessBar1.Value = 0;

            try
            {
                uiProcessBar1.Value = 10;
                await Task.Delay(100);

                bool isRunning = await Task.Run(() => IsDefenderRunning());
                uiProcessBar1.Value = 30;

                if (isRunning)
                {
                    DialogResult result = MessageBox.Show("检测到Windows Defender正在运行，这可能会影响优化效果。\n\n是否要尝试关闭Defender？",
                                                        "Defender检测",
                                                        MessageBoxButtons.YesNo,
                                                        MessageBoxIcon.Warning);

                    if (result == DialogResult.Yes)
                    {
                        string exePath = Path.Combine(Application.StartupPath, ".\\Bin\\Defender_Control.exe");
                        if (File.Exists(exePath))
                        {
                            try
                            {
                                ProcessStartInfo psi = new ProcessStartInfo(exePath);
                                psi.UseShellExecute = true;

                                var proc = Process.Start(psi);
                                if (proc != null)
                                {
                                    await Task.Run(() => proc.WaitForExit());

                                    // 再次检查Defender状态
                                    isRunning = await Task.Run(() => IsDefenderRunning());
                                    if (isRunning)
                                    {
                                        DialogResult continueResult = MessageBox.Show("Defender 仍在运行，是否继续优化？",
                                                                                    "Defender仍在运行",
                                                                                    MessageBoxButtons.YesNo,
                                                                                    MessageBoxIcon.Question);
                                        if (continueResult == DialogResult.No)
                                        {
                                            return;
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show($"无法启动 Defender 控制工具: {ex.Message}\n\n将继续进行优化但效果可能受限。");
                            }
                        }
                        else
                        {
                            MessageBox.Show("未找到 Defender_Control.exe，将继续进行优化但效果可能受限。");
                        }
                    }
                }

                uiProcessBar1.Value = 20;
                await Task.Delay(100);

                string batFilePath = Path.Combine(Application.StartupPath, "Bin", "3.bat");

                if (File.Exists(batFilePath))
                {
                    await Task.Run(() => ExecuteCmdHidden($"\"{batFilePath}\""));
                }
                else
                {
                    MessageBox.Show($"未找到优化批处理文件：\n{batFilePath}");
                    return;
                }

                uiProcessBar1.Value = 80;
                await Task.Delay(100);

                // 重启资源管理器
                await Task.Run(() => RestartExplorerSafely());

                uiProcessBar1.Value = 100;
                MessageBox.Show("系统已快速优化完成，建议重启以生效。", "ZyperWin++");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"执行失败：\n{ex.Message}", "ZyperWin++");
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


        private bool IsDefenderRunning()
        {
            try
            {
                using (var p = new Process())
                {
                    p.StartInfo = new ProcessStartInfo("sc", "query WinDefend")
                    {
                        UseShellExecute = false,
                        RedirectStandardOutput = true,
                        CreateNoWindow = true
                    };
                    p.Start();
                    string output = p.StandardOutput.ReadToEnd();
                    p.WaitForExit();

                    return output.Contains("RUNNING") && !output.Contains("STOPPED");
                }
            }
            catch
            {
                return false;
            }
        }
    }
}