using Microsoft.Win32;
using Sunny.UI;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class explorer : UserControl
    {
        private List<UISwitch> switches = new List<UISwitch>();
        private List<RegistrySetting> registrySettings = new List<RegistrySetting>();
        [DllImport("user32.dll")]
        private static extern IntPtr GetDesktopWindow();

        public explorer()
        {
            InitializeComponent();
            InitializeComponentReferences();
            InitializeRegistrySettings();

            panel1.AutoScroll = true;
            panel2.Parent = panel1;
            vScrollBar1.Visible = false;
            this.Load += Form1_Load;
        }

        private void InitializeComponentReferences()
        {
            // 手动添加所有开关控件引用
            switches.AddRange(new UISwitch[]
            {
                uiSwitch1, uiSwitch2, uiSwitch3, uiSwitch4, uiSwitch5,
                uiSwitch6, uiSwitch7, uiSwitch8, uiSwitch9, uiSwitch10,
                uiSwitch11, uiSwitch12, uiSwitch13, uiSwitch14, uiSwitch15,
                uiSwitch16, uiSwitch17, uiSwitch18, uiSwitch19, uiSwitch20,
                uiSwitch21, uiSwitch22, uiSwitch23, uiSwitch24, uiSwitch25,
                uiSwitch26, uiSwitch27, uiSwitch28, uiSwitch29, uiSwitch30,
                uiSwitch31, uiSwitch32, uiSwitch33, uiSwitch34, uiSwitch35
            });
        }

        private void InitializeRegistrySettings()
        {
            // 1. 隐藏Cortana
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Search",
                ValueName = "SearchboxTaskbarMode",
                EnableValue = 0,
                DisableValue = 1
            });

            // 2. 任务栏合并
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "TaskbarGlomLevel",
                EnableValue = 1,
                DisableValue = 0
            });

            // 3. 资源管理器打开"此电脑"
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "LaunchTo",
                EnableValue = 1,
                DisableValue = 2
            });

            // 4. 卸载无用DLL
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "AlwaysUnloadDLL",
                EnableValue = 1,
                DisableValue = 0
            });

            // 5. 禁止快捷方式跟踪
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Policies\Explorer",
                ValueName = "NoResolveTrack",
                EnableValue = 1,
                DisableValue = 0
            });

            // 6. 优化前台锁
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Control Panel\Desktop",
                ValueName = "ForegroundLockTimeout",
                EnableValue = 0,
                DisableValue = 200000
            });

            // 7. 创建快捷方式不加"快捷方式"字
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "link",
                EnableValue = new byte[] { 0, 0, 0, 0 },
                DisableValue = null,
                ValueKind = RegistryValueKind.Binary
            });

            // 8. 禁止自动播放
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Policies\Explorer",
                ValueName = "NoDriveTypeAutoRun",
                EnableValue = 255,
                DisableValue = 145
            });

            // 9. 文件夹单独进程
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "SeparateProcess",
                EnableValue = 1,
                DisableValue = 0
            });

            // 10. 快速访问不显示常用文件夹
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "ShowFrequent",
                EnableValue = 0,
                DisableValue = 1
            });

            // 11. 快速访问不显示最近文件
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer",
                ValueName = "ShowRecent",
                EnableValue = 0,
                DisableValue = 1
            });

            // 12. 语言栏隐藏
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\CTF\LangBar",
                ValueName = "ShowStatus",
                EnableValue = 3,
                DisableValue = 0
            });

            // 13. 隐藏语言栏帮助
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\CTF\LangBar",
                ValueName = "ExtraIconsOnMinimized",
                EnableValue = 0,
                DisableValue = 1
            });

            // 14. Explorer崩溃自动重启
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.LocalMachine,
                KeyPath = @"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon",
                ValueName = "AutoRestartShell",
                EnableValue = 1,
                DisableValue = 0
            });

            // 15. 显示文件扩展名
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "HideFileExt",
                EnableValue = 0,
                DisableValue = 1
            });

            // 16. 桌面显示"此电脑"
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel",
                ValueName = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}",
                EnableValue = 0,
                DisableValue = 1
            });

            // 17. 桌面显示"回收站"
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel",
                ValueName = "{645FF040-5081-101B-9F08-00AA002F954E}",
                EnableValue = 0,
                DisableValue = 1
            });

            // 18. 删除兼容性右键
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"exefile\shellex\ContextMenuHandlers\Compatibility",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{1d27f844-3a1f-4410-85ac-14651078412d}"
            });

            // 19. 删除Defender右键
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"*\shellex\ContextMenuHandlers\EPP",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{09A47860-11B0-4DA5-AFA5-26D86198A780}"
            });

            // 20. 删除BitLocker右键
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Drive\shell\BitLocker",
                ValueName = null,
                EnableValue = null,
                DisableValue = "BitLocker"
            });

            // 21. 删除便携设备右键
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Drive\shell\PortableDeviceMenu",
                ValueName = null,
                EnableValue = null,
                DisableValue = "PortableDeviceMenu"
            });

            // 22. 删除新建联系人
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @".contact\ShellNew",
                ValueName = null,
                EnableValue = null,
                DisableValue = ""
            });

            // 23. 删除还原先前版本
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}",
                ValueName = null,
                EnableValue = null,
                DisableValue = ""
            });

            // 24. 删除刻录光盘
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}",
                ValueName = null,
                EnableValue = null,
                DisableValue = ""
            });

            // 25. 删除授予访问权限
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Folder\shellex\ContextMenuHandlers\Sharing",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
            });

            // 26. 删除始终脱机可用
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Folder\shellex\ContextMenuHandlers\Offline Files",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}"
            });

            // 27. 删除固定到快速访问
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Folder\shell\pintohome",
                ValueName = null,
                EnableValue = null,
                DisableValue = "固定到快速访问"
            });

            // 28. 删除工作文件夹
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Folder\shellex\ContextMenuHandlers\WorkFolders",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{E50FF753-70F3-4C12-95FB-6586AFEBA48B}"
            });

            // 29. 删除画图3D
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"SystemFileAssociations\.3mf\Shell\3D Edit",
                ValueName = null,
                EnableValue = null,
                DisableValue = "画图3D"
            });

            // 30. 删除包含到库中
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.ClassesRoot,
                KeyPath = @"Folder\shellex\ContextMenuHandlers\Library Location",
                ValueName = null,
                EnableValue = null,
                DisableValue = "{018B4BE5-2F3F-45E6-9B3D-4D4BEE19812D}"
            });

            // 31. 开始菜单不显示常用应用
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "Start_TrackProgs",
                EnableValue = 0,
                DisableValue = 1
            });

            // 32. 开始菜单不显示最近添加
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
                ValueName = "Start_TrackDocs",
                EnableValue = 0,
                DisableValue = 1
            });

            // 33. 记事本自动换行
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Notepad",
                ValueName = "fWrap",
                EnableValue = 1,
                DisableValue = 0
            });

            // 34. 记事本显示状态栏
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Notepad",
                ValueName = "StatusBar",
                EnableValue = 1,
                DisableValue = 0
            });

            // 35. 退出时清空最近文档
            registrySettings.Add(new RegistrySetting
            {
                Hive = RegistryHive.CurrentUser,
                KeyPath = @"Software\Microsoft\Windows\CurrentVersion\Policies\Explorer",
                ValueName = "ClearRecentDocsOnExit",
                EnableValue = 1,
                DisableValue = 0
            });
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            LoadAllSwitchStates();
        }

        private void LoadAllSwitchStates()
        {
            for (int i = 0; i < Math.Min(switches.Count, registrySettings.Count); i++)
            {
                LoadSwitchState(i);
            }
        }

        private void LoadSwitchState(int index)
        {
            if (index >= switches.Count || index >= registrySettings.Count)
                return;

            var sw = switches[index];
            var setting = registrySettings[index];

            try
            {
                bool isEnabled = CheckRegistrySetting(setting);
                SetSwitchState(sw, isEnabled);

                Console.WriteLine($"开关 {index + 1} 检测: 路径={setting.KeyPath}, 值名称={setting.ValueName}, 状态={isEnabled}");

                // 使用异步事件处理
                sw.ValueChanged += async (s, ev) =>
                {
                    bool value = sw.Active;
                    try
                    {
                        Console.WriteLine($"正在设置开关 {index + 1}...");

                        if (value)
                        {
                            Console.WriteLine($"启用: 设置值 {setting.EnableValue}");
                            await ApplyRegistrySettingAsync(setting.Hive, setting.KeyPath, setting.ValueName, setting.EnableValue, index + 1);
                        }
                        else
                        {
                            Console.WriteLine($"禁用: 设置值 {setting.DisableValue}");
                            await ApplyRegistrySettingAsync(setting.Hive, setting.KeyPath, setting.ValueName, setting.DisableValue, index + 1);
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"应用设置失败 {index + 1}: {ex.Message}");
                    }
                };
            }
            catch (Exception ex)
            {
                Console.WriteLine($"加载开关 {index + 1} 状态失败: {ex.Message}");
                SetSwitchState(sw, false);
            }
        }

        private bool CheckRegistrySetting(RegistrySetting setting)
        {
            try
            {
                using (var baseKey = RegistryKey.OpenBaseKey(setting.Hive, RegistryView.Default))
                {
                    // 处理需要删除键/值的设置（右键菜单项）
                    if (setting.EnableValue == null)
                    {
                        // 启用状态 = 键/值不存在
                        using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                        {
                            if (key == null)
                                return true; // 键不存在表示已启用

                            if (setting.ValueName == null)
                            {
                                // 检查整个键是否存在
                                return false; // 键存在表示未启用
                            }
                            else
                            {
                                // 检查特定值是否存在
                                return key.GetValue(setting.ValueName) == null;
                            }
                        }
                    }

                    // 普通设置项的检测
                    using (var key = baseKey.OpenSubKey(setting.KeyPath, false))
                    {
                        if (key == null)
                            return false;

                        object currentValue = key.GetValue(setting.ValueName, null);
                        if (currentValue == null)
                            return false;

                        // 比较值
                        if (setting.EnableValue is int enableInt && currentValue is int currentInt)
                            return enableInt == currentInt;

                        if (setting.EnableValue is string enableString && currentValue is string currentString)
                            return enableString.Equals(currentString, StringComparison.Ordinal);

                        if (setting.EnableValue is byte[] enableBytes && currentValue is byte[] currentBytes)
                            return CompareByteArrays(enableBytes, currentBytes);

                        return false;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private bool CompareByteArrays(byte[] a, byte[] b)
        {
            if (a == null && b == null) return true;
            if (a == null || b == null) return false;
            if (a.Length != b.Length) return false;

            for (int i = 0; i < a.Length; i++)
            {
                if (a[i] != b[i])
                    return false;
            }
            return true;
        }

        private Task ApplyRegistrySettingAsync(RegistryHive hive, string keyPath, string valueName, object value, int optionIndex)
        {
            return Task.Run(() => // 这里缺少 => 和 {
            {
                try
                {
                    // 其他项的原有应用逻辑
                    using (var baseKey = RegistryKey.OpenBaseKey(hive, RegistryView.Default))
                    {
                        // 处理需要删除键/值的设置
                        if (value == null)
                        {
                            try
                            {
                                if (valueName == null)
                                {
                                    // 删除整个键
                                    baseKey.DeleteSubKeyTree(keyPath, false);
                                    Console.WriteLine($"[成功] 已删除注册表键: {keyPath}");
                                }
                                else
                                {
                                    // 删除特定值
                                    using (var key = baseKey.OpenSubKey(keyPath, true))
                                    {
                                        if (key != null)
                                        {
                                            key.DeleteValue(valueName, false);
                                            Console.WriteLine($"[成功] 已删除注册表值: {keyPath}\\{valueName}");
                                        }
                                    }
                                }
                            }
                            catch (ArgumentException)
                            {
                                // 键或值不存在，忽略错误
                                Console.WriteLine($"[信息] 注册表键或值已不存在: {keyPath}\\{valueName}");
                            }
                            return;
                        }

                        // 创建或打开键并设置值
                        using (var key = baseKey.CreateSubKey(keyPath, true))
                        {
                            if (value is int intValue)
                            {
                                key.SetValue(valueName, intValue, RegistryValueKind.DWord);
                                Console.WriteLine($"[成功] 已设置DWORD值: {keyPath}\\{valueName} = {intValue}");
                            }
                            else if (value is string stringValue)
                            {
                                key.SetValue(valueName, stringValue, RegistryValueKind.String);
                                Console.WriteLine($"[成功] 已设置字符串值: {keyPath}\\{valueName} = {stringValue}");
                            }
                            else if (value is byte[] byteValue)
                            {
                                key.SetValue(valueName, byteValue, RegistryValueKind.Binary);
                                Console.WriteLine($"[成功] 已设置二进制值: {keyPath}\\{valueName}");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[错误] 应用注册表设置失败: {ex.Message}");
                }
            }); // 这里缺少结束的括号和分号
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
    }

    public class RegistrySetting
    {
        public RegistryHive Hive { get; set; }
        public string KeyPath { get; set; }
        public string ValueName { get; set; }
        public object EnableValue { get; set; }
        public object DisableValue { get; set; }
        public RegistryValueKind ValueKind { get; set; } = RegistryValueKind.Unknown;
    }
}