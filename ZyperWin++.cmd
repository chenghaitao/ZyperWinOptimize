@echo off

title ZyperWin++ v1.0

:: 设置默认控制台背景和前景色
color 1f
set ConsoleBackColor=Blue
set ConsoleForeColor=White

if not "%cd%"=="%cd: =%" (
	echo.=========================================================
	echo.当前目录在其路径中包含空格。
	echo.请将目录移动或重命名为不包含空格的目录。
	echo.
	echo.=========================================================
	echo.
	pause>nul|set /p=请按任意键继续执行……
	color 00
	endlocal
	exit
)

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 最终用户许可协议
::-------------------------------------------------------------------------------------------
cls

echo.===============================================================================
echo.####################### ZyperWin++ - 最终用户许可协议 ########################
echo.===============================================================================
echo.
echo.
echo.  ZyperWin++是一个轻便的Windows优化工具，适用于Win7-Win11最新版的优化，
echo.  包括性能优化、服务项优化、垃圾清理等操作，还支持系统激活和Office快速安装。
echo.
echo.  ZyperWin++已开源（https://github.com/ZyperWave/ZyperWinOptimize）
echo.  没有病毒，请放心使用！
echo.
echo.  此ZyperWin++“按原样”提供，并且不作任何明示或暗示性的保证。在任何情况之下，
echo.  作者均不会对因为使用此脚本工具而导致可能的任何破坏承担责任。
echo.
echo.
echo.  系统优化前请记得创建系统还原点，若出现问题可以退回！
echo.
echo.
echo.  若出现问题，请及时反馈（反馈群：312820776），也感谢您的使用！
echo.
echo.
echo.
echo.===============================================================================
choice /C:AR /N /M "########################[ 按‘A’同意 / 按‘R’拒绝 ]#########################"
if errorlevel 2 (
	reg delete "HKCU\Console\%%SystemRoot%%_system32_cmd.exe" /f >nul

	color 00
	endlocal

	exit
)



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 主菜单
::-------------------------------------------------------------------------------------------
:MainMenu

cls
echo.===============================================================================
echo.                          ZyperWin++ - 主  菜  单
echo.===============================================================================
echo.
echo.
echo.                           [1]   快 速 优 化
echo.
echo.
echo.                           [2]   自定义优化
echo.
echo.
echo.                           [3]   Office 安装（64位）
echo.
echo.
echo.                           [4]   系 统 激 活
echo.                             
echo.                             
echo.                           [5]   关 于 软 件
echo.                             
echo.
echo.                           [X]   退      出
echo.
echo.===============================================================================
choice /C:12345X /N /M "请输入你的选项 ："
if errorlevel 6 goto :Quit
if errorlevel 5 goto :about
if errorlevel 4 goto :System_activation
if errorlevel 3 goto :Office_install
if errorlevel 2 goto :custom_optimize
if errorlevel 1 goto :quick_optimize
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 快速优化
::-------------------------------------------------------------------------------------------
:quick_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 快速优化
echo.===============================================================================
echo.
echo.  正在执行全面系统优化...
echo.
echo.  注意：此过程可能此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
echo.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏任务栏Cortana
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用任务栏窗口合并
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器打开时显示"此电脑"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用从内存卸载无用DLL
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用跟踪损坏的快捷方式
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
echo [√] 已优化Windows文件列表刷新策略
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
echo [√] 创建快捷方式时不添加"快捷方式"字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
echo [√] 已禁用自动播放
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
echo [√] 已在单独进程中打开文件夹窗口
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示常用文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示最近使用文件
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
echo [√] 语言栏已隐藏到任务栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏语言栏上的帮助按钮
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器崩溃时将自动重启
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
echo [√] 已显示已知文件类型的扩展名
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"回收站"
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单
reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
echo [√] 已禁用新建的"联系人"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
echo [√] 已禁用磁盘的"刻录到光盘"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
echo [√] 已禁用"授予访问权限"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
echo [√] 已禁用文件夹的"固定到快速访问"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
echo [√] 已禁用"工作文件夹"右键菜单
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
echo [√] 已禁用文件的"画图3D"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
echo [√] 已禁用文件夹的"包含到库中"右键菜单
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最常用的应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最近添加的应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用自动换行
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用状态栏显示
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用退出系统时清除最近打开的文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 不允许在开始菜单显示建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 不要在应用商店中查找关联应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭商店应用推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭锁屏时的Windows聚焦推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭"使用Windows时获取技巧和建议"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 禁止自动安装推荐的应用程序
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭游戏录制工具
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭多嘴的小娜
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
echo [√] 加快关机速度
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
echo [√] 缩短关闭服务等待时间
sc config "PcaSvc" start= disabled >nul
sc stop "PcaSvc" >nul
echo [√] 禁用程序兼容性助手
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用远程修改注册表
sc config "DPS" start= disabled >nul
sc stop "DPS" >nul
echo [√] 禁用诊断服务
sc config "SysMain" start= disabled >nul
sc stop "SysMain" >nul
echo [√] 禁用SysMain
sc config "WSearch" start= disabled >nul
sc stop "WSearch" >nul
echo [√] 禁用Windows Search
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 禁用错误报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用客户体验改善计划
sc config "TrkWks" start= disabled >nul
sc stop "TrkWks" >nul
echo [√] 禁用NTFS链接跟踪服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止自动维护计划
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "RefsDisableUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 不要自动升级ReFS文件系统版本
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f >nul
echo [√] 突破260个字符的路径长度限制
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止NTFS更新文件访问时间
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsAllowExtendedCharacterIn8dot3Name" /t REG_DWORD /d 1 /f >nul
echo [√] 允许NTFS在短文件名中使用扩展字符集
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f >nul
echo [√] 将NTFS主文件表的保留空间设置为200MB
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] NTFS分区损坏时允许生成错误检查
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "NoVolumeTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 禁用NTFS卷快照提示
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
echo [√] 启用大系统缓存以提高性能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止系统内核与驱动程序分页到硬盘
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
echo [√] 将文件管理系统缓存增加至256MB
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭Windows预读功能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul
echo [√] 禁用处理器的幽灵和熔断补丁以提高性能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
echo [√] VHD启动时节省磁盘空间
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭系统自动调试功能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
echo [√] 将磁盘错误检查等待时间缩短到五秒
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
echo [√] 设备安装禁止创建系统还原点
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
echo [√] 弹出USB磁盘后彻底断开电源
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭快速启动
powercfg /hibernate off
echo [√] 关闭休眠
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
echo [√] 根据语言设置隐藏字体
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
echo [√] 微软拼音输入法关闭云计算
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止Win10/11进行大版本更新
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] Windows更新不包括恶意软件删除工具
sc config "wuauserv" start= disabled >nul
sc stop "wuauserv" >nul
echo [√] 禁用Windows更新
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用内容传递优化服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用功能更新安全措施
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用蓝屏后自动重启
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用Installer detection
sc config "ATMFD" start= disabled >nul
sc stop "ATMFD" >nul
echo [√] 禁用Adobe Type Manager字体驱动
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用保留空间
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
echo [√] 启用硬件加速GPU计划
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d 2 /f >nul
echo [√] 优化处理器性能和内存设置
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 降低Cortana性能，减少CPU占用
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /t REG_BINARY /d 22222200000200000002000000000000 /f >nul
echo [√] 关闭Exploit Protection
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
echo [√] 关闭广告ID
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭应用启动跟踪
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 去除搜索页面信息流和热搜
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /t REG_SZ /d "7152" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2024-01-01T10:00:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2024-01-01T10:00:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2024-01-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
echo [√] 停止更新到2999年
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /t REG_DWORD /d 1 /f >nul
echo [√] 关闭TSX漏洞补丁
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_SZ /d "ffffffff" /f >nul
echo [√] 优化进程数量
sc config "DPS" start= disabled >nul
sc stop "DPS" >nul
echo [√] 关闭诊断策略服务
sc config "PcaSvc" start= disabled >nul
sc stop "PcaSvc" >nul
echo [√] 关闭程序兼容性助手
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭微软客户体验改进计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用交付优化
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /t REG_DWORD /d 4 /f >nul
echo [√] 禁用高精度事件定时器(HPET)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用Game Bar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 禁用自动更新商店应用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用自动更新地图
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 1 /f >nul
echo [√] 加速Windows启动
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
echo [√] 禁用上下文菜单显示延迟
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用"首次运行"欢迎页面
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Adobe Flash即点即用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止Edge关闭后继续运行后台应用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" /t REG_DWORD /d 2 /f >nul
echo [√] 已阻止必应搜索结果中的所有广告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用新选项卡页面上的微软资讯内容
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d 1 /f >nul
echo [√] 已隐藏新标签页中的默认热门网站
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏Edge浏览器边栏
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Smartscreen筛选器
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止发送任何诊断数据
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用标签页性能检测器
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭停止支持旧系统的通知
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Edge自启动
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" /t REG_DWORD /d 2 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用效率模式
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭"由你的组织管理"提示
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
echo [√] 已将UAC调整为从不通知
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f >nul
echo [√] 已启用内置管理员账户的管理审批模式
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d 1 /f >nul
echo [√] 仅提升安全路径下的UIAccess程序
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul
echo [√] 允许UIAccess在非安全桌面上提升
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭SmartScreen应用筛选器
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "LowRiskFileTypes" /t REG_SZ /d ".exe;.bat;.cmd" /f >nul
echo [√] 已关闭打开程序的安全警告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
sc config WinDefend start= disabled >nul
sc stop WinDefend >nul
echo [√] 已禁用Windows Defender
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭默认共享
netsh advfirewall set allprofiles state off >nul
echo [√] 已关闭防火墙
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymous" /t REG_DWORD /d 1 /f >nul
echo [√] 不允许SAM账户的匿名枚举
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用不安全的来宾登录
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭远程协助
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Security Center" /v "Notifications_Disable" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用安全中心所有通知
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Defender篡改保护
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] UAC管理员不提示直接提升
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用安全桌面提示
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
echo [√] 已禁用SmartScreen在线服务
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul
bcdedit /set hypervisorlaunchtype off >nul 2>&1
echo [√] 已禁用基于虚拟化的安全性(VBS)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭WD应用程序控制(WDAC)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用烦人的安全通知
sc config wscsvc start= disabled >nul
sc stop wscsvc >nul
echo [√] 已禁用安全中心服务
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用内存完整性(VBS)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnablePlatformSecurity" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Windows平台二进制表
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用AMSI
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用代码完整性
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul
echo [√] 已完全禁用UAC
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用页面预测功能
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始屏幕建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用活动收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用应用启动跟踪
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用广告标识符
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文件系统
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问日历
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问联系人
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问视频
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用网站语言跟踪
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows欢迎体验
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用反馈频率
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用诊断数据收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写作习惯跟踪
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用设置应用建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Bing搜索结果
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用通讯录收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入文本收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索历史
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用赞助商应用安装
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用自动连接热点
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用输入数据个性化
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入见解
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用预安装应用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用.NET遥测
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用PowerShell遥测
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
echo [√] 已禁用遥测服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告(WER)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用语音激活(Cortana)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用位置服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索数据收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用定向广告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Wi-Fi感知
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用步骤记录器
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用活动订阅源
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问账户信息
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问运动数据
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电话
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问信任设备
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问同步
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问诊断信息
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问通话记录
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电子邮件
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问任务
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问消息
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用组件堆栈日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用更新解压模块日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "BackupRegistry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用组件堆栈文件备份
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用崩溃时写入调试信息
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用账户登录日志报告
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用WfpDiag.ETL日志
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写入调试信息
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用将事件写入系统日志
:: 服务优化 - 禁用不必要的服务
echo.
echo 正在禁用并停止非必要服务...
echo.
:: 诊断跟踪服务
sc config DiagTrack start= disabled >nul
sc stop DiagTrack >nul 2>&1
echo [√] 已禁用: DiagTrack (诊断跟踪服务)
:: SuperFetch服务
sc config SysMain start= disabled >nul
sc stop SysMain >nul 2>&1
echo [√] 已禁用: SysMain (SuperFetch服务)
:: Windows搜索服务
sc config WSearch start= disabled >nul
sc stop WSearch >nul 2>&1
echo [√] 已禁用: WSearch (Windows搜索服务)
:: Windows更新服务
sc config UsoSvc start= disabled >nul
sc stop UsoSvc >nul 2>&1
echo [√] 已禁用: UsoSvc (Windows更新服务)
:: 分布式链接跟踪服务
sc config TrkWks start= disabled >nul
sc stop TrkWks >nul 2>&1
echo [√] 已禁用: TrkWks (分布式链接跟踪服务)
:: Windows Defender服务
sc config WinDefend start= disabled >nul
sc stop WinDefend >nul 2>&1
echo [√] 已禁用: WinDefend (Windows Defender服务)
:: 诊断服务
sc config diagsvc start= disabled >nul
sc stop diagsvc >nul 2>&1
echo [√] 已禁用: diagsvc (诊断服务)
:: 诊断策略服务
sc config DPS start= disabled >nul
sc stop DPS >nul 2>&1
echo [√] 已禁用: DPS (诊断策略服务)
:: 诊断服务主机
sc config WdiServiceHost start= disabled >nul
sc stop WdiServiceHost >nul 2>&1
echo [√] 已禁用: WdiServiceHost (诊断服务主机)
:: 诊断系统主机
sc config WdiSystemHost start= disabled >nul
sc stop WdiSystemHost >nul 2>&1
echo [√] 已禁用: WdiSystemHost (诊断系统主机)
:: 地图服务
sc config MapsBroker start= demand >nul
echo [√] 已设置手动: MapsBroker (地图服务)
:: IP助手服务
sc config iphlpsvc start= disabled >nul
sc stop iphlpsvc >nul 2>&1
echo [√] 已禁用: iphlpsvc (IP助手服务)
:: 诊断中心收集器服务
sc config diagnosticshub.standardcollector.service start= disabled >nul
sc stop diagnosticshub.standardcollector.service >nul 2>&1
echo [√] 已禁用: diagnosticshub.standardcollector.service (诊断中心收集器)
:: SMS路由器服务
sc config SmsRouter start= disabled >nul
sc stop SmsRouter >nul 2>&1
echo [√] 已禁用: SmsRouter (SMS路由器服务)
:: 程序兼容性助手服务
sc config PcaSvc start= disabled >nul
sc stop PcaSvc >nul 2>&1
echo [√] 已禁用: PcaSvc (程序兼容性助手)
:: Shell硬件检测服务
sc config ShellHWDetection start= demand >nul
echo [√] 已设置手动: ShellHWDetection (Shell硬件检测)
:: 系统防护服务
sc config SgrmBroker start= disabled >nul
sc stop SgrmBroker >nul 2>&1
echo [√] 已禁用: SgrmBroker (系统防护服务)
:: 任务计划服务
sc config Schedule start= demand >nul
echo [√] 已设置手动: Schedule (任务计划服务)
:: Windows事件收集服务
sc config Wecsvc start= disabled >nul
sc stop Wecsvc >nul 2>&1
echo [√] 已禁用: Wecsvc (Windows事件收集服务)
:: 安全健康服务
sc config SecurityHealthService start= disabled >nul
sc stop SecurityHealthService >nul 2>&1
echo [√] 已禁用: SecurityHealthService (安全健康服务)
echo.
echo 服务项优化已完成!
echo.
:: 系统清理 - 删除临时文件和缓存
echo 正在清理临时文件和缓存...
echo.
:: 临时文件
del /f /s /q "%SystemDrive%\Windows\Temp\*" >nul 2>&1
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
del /f /s /q "%TEMP%\*" >nul 2>&1
echo [√] 清理: 临时文件
:: 缩略图缓存
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo [√] 清理: 缩略图缓存
:: Windows Defender文件
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\*" >nul 2>&1
echo [√] 清理: Windows Defender临时文件
:: DirectX着色器缓存
del /f /s /q "%LocalAppData%\Local\D3DSCache\*" >nul 2>&1
echo [√] 清理: DirectX着色器缓存
:: 传递优化文件
del /f /s /q "%SystemRoot%\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1
echo [√] 清理: 传递优化文件
:: 诊断数据
del /f /s /q "%ProgramData%\Microsoft\Diagnosis\*" >nul 2>&1
echo [√] 清理: 诊断数据查看器数据库文件
:: 系统错误文件
del /f /s /q "%SystemRoot%\Minidump\*.dmp" >nul 2>&1
del /f /q "%SystemRoot%\memory.dmp" >nul 2>&1
echo [√] 清理: 系统错误文件
:: Windows报告
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportQueue\*" >nul 2>&1
echo [√] 清理: Windows报告文件
:: Windows下载缓存
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
echo [√] 清理: Windows更新缓存
:: Terminal Server缓存
del /f /s /q "%LocalAppData%\Microsoft\Terminal Server Client\Cache\*" >nul 2>&1
echo [√] 清理: Terminal Server Client缓存
:: Windows预读取文件
del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1
echo [√] 清理: Windows预读取文件
:: WinINet缓存
del /f /s /q "%LocalAppData%\Microsoft\Windows\INetCache\*" >nul 2>&1
echo [√] 清理: WinINet网页缓存
:: WinINet Cookies
del /f /s /q "%LocalAppData%\Microsoft\Windows\INetCookies\*" >nul 2>&1
echo [√] 清理: WinINet Cookies
:: Winsxs临时文件
del /f /s /q "%SystemRoot%\WinSxS\Temp\*" >nul 2>&1
echo [√] 清理: Winsxs临时文件
:: Windows日志
del /f /s /q "%SystemRoot%\Logs\*" >nul 2>&1
echo [√] 清理: Windows日志文件
:: 日常临时文件
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
echo [√] 清理: Windows日常临时文件
:: 崩溃dmp文件
del /f /s /q "%SystemDrive%\*.dmp" >nul 2>&1
echo [√] 清理: 系统崩溃dmp文件
:: 回收站
rd /s /q "%SystemDrive%\$Recycle.bin" >nul 2>&1
echo [√] 清理: 回收站
:: 清理损坏的Appx
echo [√] 清理: 损坏的Appx应用
powershell -Command "Get-AppxPackage -AllUsers | Where-Object {$_.Status -eq 'Error'} | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul
:: 清理.NET程序集缓存
echo [√] 清理: .NET程序集缓存
rd /s /q "%WinDir%\assembly\NativeImages_v4.0.30319_32" >nul 2>&1
rd /s /q "%WinDir%\assembly\NativeImages_v4.0.30319_64" >nul 2>&1

echo.
echo ========================================
echo 快速优化已完成! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 自定义优化
::-------------------------------------------------------------------------------------------
:custom_optimize

cls
echo.===============================================================================
echo.                           ZyperWin++ - 自定义优化
echo.===============================================================================
echo.
echo.  [1]   外观/资源管理器（管理员运行“ZyperWin++”优化有效，运行“Start”无效）
echo.
echo.  [2]   性能优化设置
echo.
echo.  [3]   Edge优化设置
echo.
echo.  [4]   安全设置
echo.
echo.  [5]   隐私设置
echo.
echo.  [6]   日志设置
echo.
echo.  [7]   服务项优化
echo.
echo.  [8]   垃圾清理（需要在系统还原点创建前清理，无此需求可忽略）
echo.
echo.  [X]   返回
echo.
echo.===============================================================================
echo.
choice /C:12345678X /N /M "请输入你的选项 ："
if errorlevel 9 goto :MainMenu
if errorlevel 8 goto :laji
if errorlevel 7 goto :fuwuxiang
if errorlevel 6 goto :rizhi
if errorlevel 5 goto :yinsi
if errorlevel 4 goto :anquan
if errorlevel 3 goto :Edge
if errorlevel 2 goto :xingneng
if errorlevel 1 goto :waiguan
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 外观/资源管理器
::-------------------------------------------------------------------------------------------
:waiguan

cls
echo.===============================================================================
echo.                    ZyperWin++ - 外观/资源管理器
echo.===============================================================================
echo 请选择要应用的优化项（可多选，用空格分隔）：
echo.
echo   [ 1] 隐藏任务栏Cortana
echo   [ 2] 任务栏窗口合并
echo   [ 3] 资源管理器打开显示"此电脑"
echo   [ 4] 总是从内存卸载无用DLL
echo   [ 5] 禁止跟踪损坏的快捷方式
echo   [ 6] 优化文件列表刷新策略
echo   [ 7] 创建快捷方式不添加"快捷方式"字样
echo   [ 8] 禁止自动播放
echo   [ 9] 在单独进程中打开文件夹
echo   [10] 快速访问不显示常用文件夹
echo   [11] 快速访问不显示最近使用文件
echo   [12] 语言栏隐藏到任务栏
echo   [13] 隐藏语言栏帮助按钮
echo   [14] 资源管理器崩溃自动重启
echo   [15] 显示文件扩展名
echo   [16] 桌面显示"此电脑"
echo   [17] 桌面显示"回收站"
echo   [18] 禁用兼容性疑难解答右键菜单
echo   [19] 禁用Windows Defender扫描右键菜单
echo   [20] 禁用Bitlocker右键菜单
echo   [21] 禁用"作为便携设备打开"右键菜单
echo   [22] 禁用新建联系人右键菜单
echo   [23] 禁用"还原先前版本"右键菜单
echo   [24] 禁用"刻录到光盘"右键菜单
echo   [25] 禁用"授予访问权限"右键菜单
echo   [26] 禁用"始终脱机可用"右键菜单
echo   [27] 禁用"固定到快速访问"右键菜单
echo   [28] 禁用工作文件夹右键菜单
echo   [29] 禁用画图3D右键菜单
echo   [30] 禁用"包含到库中"右键菜单
echo   [31] 禁用开始菜单常用应用
echo   [32] 禁用开始菜单最近添加应用
echo   [33] 记事本启用自动换行
echo   [34] 记事本显示状态栏
echo   [35] 退出时清除最近打开文档
echo.
echo   [A] 应用所有优化
echo   [R] 重启资源管理器（仅运行ZyperWin++有效，运行Start无法回到桌面）
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize
if /i "%choices%"=="R" goto RESTART_EXPLORER

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :HIDE_CORTANA
    if %%c EQU 2 call :TASKBAR_COMBINE
    if %%c EQU 3 call :EXPLORER_THISPC
    if %%c EQU 4 call :UNLOAD_DLLS
    if %%c EQU 5 call :DISABLE_BROKEN_SHORTCUTS
    if %%c EQU 6 call :OPTIMIZE_REFRESH
    if %%c EQU 7 call :NO_SHORTCUT_SUFFIX
    if %%c EQU 8 call :DISABLE_AUTOPLAY
    if %%c EQU 9 call :SEPARATE_PROCESS
    if %%c EQU 10 call :HIDE_FREQUENT_FOLDERS
    if %%c EQU 11 call :HIDE_RECENT_FILES
    if %%c EQU 12 call :HIDE_LANGBAR
    if %%c EQU 13 call :HIDE_LANGBAR_HELP
    if %%c EQU 14 call :EXPLORER_AUTO_RESTART
    if %%c EQU 15 call :SHOW_FILE_EXTENSIONS
    if %%c EQU 16 call :DESKTOP_THISPC
    if %%c EQU 17 call :DESKTOP_RECYCLE
    if %%c EQU 18 call :DISABLE_COMPAT_MENU
    if %%c EQU 19 call :DISABLE_DEFENDER_SCAN
    if %%c EQU 20 call :DISABLE_BITLOCKER
    if %%c EQU 21 call :DISABLE_PORTABLE_OPEN
    if %%c EQU 22 call :DISABLE_NEW_CONTACT
    if %%c EQU 23 call :DISABLE_PREVIOUS_VERSIONS
    if %%c EQU 24 call :DISABLE_BURN_DISC
    if %%c EQU 25 call :DISABLE_SHARE_MENU
    if %%c EQU 26 call :DISABLE_OFFLINE_ACCESS
    if %%c EQU 27 call :DISABLE_PIN_TO_QUICK
    if %%c EQU 28 call :DISABLE_WORK_FOLDERS
    if %%c EQU 29 call :DISABLE_PAINT3D_MENU
    if %%c EQU 30 call :DISABLE_INCLUDE_LIBRARY
    if %%c EQU 31 call :DISABLE_START_APPS
    if %%c EQU 32 call :DISABLE_RECENT_APPS
    if %%c EQU 33 call :NOTEPAD_WORDWRAP
    if %%c EQU 34 call :NOTEPAD_STATUSBAR
    if %%c EQU 35 call :CLEAR_RECENT_DOCS
)

echo.
pause
goto custom_optimize

:RESTART_EXPLORER
echo.
echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启
echo.
pause
goto custom_optimize

:: 下面是各个优化函数的实现
:HIDE_CORTANA
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏任务栏Cortana
goto :EOF

:TASKBAR_COMBINE
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用任务栏窗口合并
goto :EOF

:EXPLORER_THISPC
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器打开时显示"此电脑"
goto :EOF

:UNLOAD_DLLS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用从内存卸载无用DLL
goto :EOF

:DISABLE_BROKEN_SHORTCUTS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用跟踪损坏的快捷方式
goto :EOF

:OPTIMIZE_REFRESH
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
echo [√] 已优化Windows文件列表刷新策略
goto :EOF

:NO_SHORTCUT_SUFFIX
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
echo [√] 创建快捷方式时不添加"快捷方式"字样
goto :EOF

:DISABLE_AUTOPLAY
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
echo [√] 已禁用自动播放
goto :EOF

:SEPARATE_PROCESS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
echo [√] 已在单独进程中打开文件夹窗口
goto :EOF

:HIDE_FREQUENT_FOLDERS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示常用文件夹
goto :EOF

:HIDE_RECENT_FILES
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示最近使用文件
goto :EOF

:HIDE_LANGBAR
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
echo [√] 语言栏已隐藏到任务栏
goto :EOF

:HIDE_LANGBAR_HELP
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏语言栏上的帮助按钮
goto :EOF

:EXPLORER_AUTO_RESTART
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器崩溃时将自动重启
goto :EOF

:SHOW_FILE_EXTENSIONS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
echo [√] 已显示已知文件类型的扩展名
goto :EOF

:DESKTOP_THISPC
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"此电脑"
goto :EOF

:DESKTOP_RECYCLE
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"回收站"
goto :EOF

:: 以下为右键菜单禁用函数
:DISABLE_COMPAT_MENU
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单
goto :EOF

:DISABLE_DEFENDER_SCAN
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单
goto :EOF

:DISABLE_BITLOCKER
reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单
goto :EOF

:DISABLE_PORTABLE_OPEN
reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单
goto :EOF

:DISABLE_NEW_CONTACT
reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
echo [√] 已禁用新建的"联系人"右键菜单
goto :EOF

:DISABLE_PREVIOUS_VERSIONS
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单
goto :EOF

:DISABLE_BURN_DISC
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
echo [√] 已禁用磁盘的"刻录到光盘"右键菜单
goto :EOF

:DISABLE_SHARE_MENU
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
echo [√] 已禁用"授予访问权限"右键菜单
goto :EOF

:DISABLE_OFFLINE_ACCESS
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单
goto :EOF

:DISABLE_PIN_TO_QUICK
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
echo [√] 已禁用文件夹的"固定到快速访问"右键菜单
goto :EOF

:DISABLE_WORK_FOLDERS
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
echo [√] 已禁用"工作文件夹"右键菜单
goto :EOF

:DISABLE_PAINT3D_MENU
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
echo [√] 已禁用文件的"画图3D"右键菜单
goto :EOF

:DISABLE_INCLUDE_LIBRARY
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
echo [√] 已禁用文件夹的"包含到库中"右键菜单
goto :EOF

:: 开始菜单优化
:DISABLE_START_APPS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最常用的应用
goto :EOF

:DISABLE_RECENT_APPS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最近添加的应用
goto :EOF

:: 记事本设置
:NOTEPAD_WORDWRAP
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用自动换行
goto :EOF

:NOTEPAD_STATUSBAR
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用状态栏显示
goto :EOF

:CLEAR_RECENT_DOCS
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用退出系统时清除最近打开的文档
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 性能优化设置
::-------------------------------------------------------------------------------------------
:xingneng

cls
echo.===============================================================================
echo.                    ZyperWin++ - 性能优化设置
echo.===============================================================================
echo.
echo 请选择要应用的优化项（可多选，用空格分隔）：
echo.
echo   [ 1] 不允许在开始菜单显示建议
echo   [ 2] 不要在应用商店中查找关联应用
echo   [ 3] 关闭商店应用推广
echo   [ 4] 关闭锁屏时的Windows聚焦推广
echo   [ 5] 关闭"使用Windows时获取技巧和建议"
echo   [ 6] 禁止自动安装推荐的应用程序
echo   [ 7] 关闭游戏录制工具
echo   [ 8] 关闭多嘴的小娜
echo   [ 9] 加快关机速度
echo   [10] 缩短关闭服务等待时间
echo   [11] 禁用程序兼容性助手
echo   [12] 禁用远程修改注册表
echo   [13] 禁用诊断服务
echo   [14] 禁用SysMain
echo   [15] 禁用Windows Search
echo   [16] 禁用错误报告
echo   [17] 禁用客户体验改善计划
echo   [18] 禁用NTFS链接跟踪服务
echo   [19] 禁止自动维护计划
echo   [20] 不要自动升级ReFS文件系统版本
echo   [21] 突破260个字符的路径长度限制
echo   [22] 禁止NTFS更新文件访问时间
echo   [23] 允许NTFS在短文件名中使用扩展字符集
echo   [24] 将NTFS主文件表的保留空间设置为200MB
echo   [25] NTFS分区损坏时允许生成错误检查
echo   [26] 禁用NTFS卷快照提示
echo   [27] 启用大系统缓存以提高性能
echo   [28] 禁止系统内核与驱动程序分页到硬盘
echo   [29] 将文件管理系统缓存增加至256MB
echo   [30] 将Windows预读调整为关闭预读
echo   [31] 禁用处理器的幽灵和熔断补丁
echo   [32] VHD启动时节省磁盘空间
echo   [33] 关闭系统自动调试功能
echo   [34] 将磁盘错误检查等待时间缩短到五秒
echo   [35] 设备安装禁止创建系统还原点
echo   [36] 弹出USB磁盘后彻底断开电源
echo   [37] 关闭快速启动
echo   [38] 关闭休眠
echo   [39] 根据语言设置隐藏字体
echo   [40] 微软拼音输入法关闭云计算
echo   [41] 禁止Win10/11进行大版本更新
echo   [42] Windows更新不包括恶意软件删除工具
echo   [43] 禁用Windows更新
echo   [44] 禁用内容传递优化服务
echo   [45] 禁用功能更新安全措施
echo   [46] 禁用蓝屏后自动重启
echo   [47] 禁用Installer detection
echo   [48] 禁用Adobe Type Manager字体驱动
echo   [49] 禁用保留空间
echo   [50] 启用硬件加速GPU计划
echo   [51] 优化处理器性能和内存设置
echo   [52] 降低Cortana性能减少CPU占用
echo   [53] 关闭Exploit Protection
echo   [54] 关闭广告ID
echo   [55] 关闭应用启动跟踪
echo   [56] 去除搜索页面信息流和热搜
echo   [57] 停止更新到2999年
echo   [58] 关闭TSX漏洞补丁
echo   [59] 优化进程数量
echo   [60] 关闭诊断策略服务
echo   [61] 关闭程序兼容性助手
echo   [62] 关闭微软客户体验改进计划
echo   [63] 禁用交付优化
echo   [64] 禁用高精度事件定时器(HPET)
echo   [65] 禁用Game Bar
echo   [66] 禁用自动更新商店应用
echo   [67] 禁用自动更新地图
echo   [68] 加速Windows启动
echo   [69] 禁用上下文菜单显示延迟
echo.
echo   [A] 应用所有优化
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :OPT1
    if %%c EQU 2 call :OPT2
    if %%c EQU 3 call :OPT3
    if %%c EQU 4 call :OPT4
    if %%c EQU 5 call :OPT5
    if %%c EQU 6 call :OPT6
    if %%c EQU 7 call :OPT7
    if %%c EQU 8 call :OPT8
    if %%c EQU 9 call :OPT9
    if %%c EQU 10 call :OPT10
    if %%c EQU 11 call :OPT11
    if %%c EQU 12 call :OPT12
    if %%c EQU 13 call :OPT13
    if %%c EQU 14 call :OPT14
    if %%c EQU 15 call :OPT15
    if %%c EQU 16 call :OPT16
    if %%c EQU 17 call :OPT17
    if %%c EQU 18 call :OPT18
    if %%c EQU 19 call :OPT19
    if %%c EQU 20 call :OPT20
    if %%c EQU 21 call :OPT21
    if %%c EQU 22 call :OPT22
    if %%c EQU 23 call :OPT23
    if %%c EQU 24 call :OPT24
    if %%c EQU 25 call :OPT25
    if %%c EQU 26 call :OPT26
    if %%c EQU 27 call :OPT27
    if %%c EQU 28 call :OPT28
    if %%c EQU 29 call :OPT29
    if %%c EQU 30 call :OPT30
    if %%c EQU 31 call :OPT31
    if %%c EQU 32 call :OPT32
    if %%c EQU 33 call :OPT33
    if %%c EQU 34 call :OPT34
    if %%c EQU 35 call :OPT35
    if %%c EQU 36 call :OPT36
    if %%c EQU 37 call :OPT37
    if %%c EQU 38 call :OPT38
    if %%c EQU 39 call :OPT39
    if %%c EQU 40 call :OPT40
    if %%c EQU 41 call :OPT41
    if %%c EQU 42 call :OPT42
    if %%c EQU 43 call :OPT43
    if %%c EQU 44 call :OPT44
    if %%c EQU 45 call :OPT45
    if %%c EQU 46 call :OPT46
    if %%c EQU 47 call :OPT47
    if %%c EQU 48 call :OPT48
    if %%c EQU 49 call :OPT49
    if %%c EQU 50 call :OPT50
    if %%c EQU 51 call :OPT51
    if %%c EQU 52 call :OPT52
    if %%c EQU 53 call :OPT53
    if %%c EQU 54 call :OPT54
    if %%c EQU 55 call :OPT55
    if %%c EQU 56 call :OPT56
    if %%c EQU 57 call :OPT57
    if %%c EQU 58 call :OPT58
    if %%c EQU 59 call :OPT59
    if %%c EQU 60 call :OPT60
    if %%c EQU 61 call :OPT61
    if %%c EQU 62 call :OPT62
    if %%c EQU 63 call :OPT63
    if %%c EQU 64 call :OPT64
    if %%c EQU 65 call :OPT65
    if %%c EQU 66 call :OPT66
    if %%c EQU 67 call :OPT67
    if %%c EQU 68 call :OPT68
    if %%c EQU 69 call :OPT69
)

echo.
echo 注意：部分优化需要重启系统才能完全生效
echo.
pause
goto custom_optimize

:: 下面是各个优化函数的实现
:OPT1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 不允许在开始菜单显示建议
goto :EOF

:OPT2
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 不要在应用商店中查找关联应用
goto :EOF

:OPT3
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭商店应用推广
goto :EOF

:OPT4
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭锁屏时的Windows聚焦推广
goto :EOF

:OPT5
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭"使用Windows时获取技巧和建议"
goto :EOF

:OPT6
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 禁止自动安装推荐的应用程序
goto :EOF

:OPT7
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭游戏录制工具
goto :EOF

:OPT8
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭多嘴的小娜
goto :EOF

:OPT9
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
echo [√] 加快关机速度
goto :EOF

:OPT10
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
echo [√] 缩短关闭服务等待时间
goto :EOF

:OPT11
sc config "PcaSvc" start= disabled >nul
sc stop "PcaSvc" >nul
echo [√] 禁用程序兼容性助手
goto :EOF

:OPT12
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用远程修改注册表
goto :EOF

:OPT13
sc config "DPS" start= disabled >nul
sc stop "DPS" >nul
echo [√] 禁用诊断服务
goto :EOF

:OPT14
sc config "SysMain" start= disabled >nul
sc stop "SysMain" >nul
echo [√] 禁用SysMain
goto :EOF

:OPT15
sc config "WSearch" start= disabled >nul
sc stop "WSearch" >nul
echo [√] 禁用Windows Search
goto :EOF

:OPT16
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 禁用错误报告
goto :EOF

:OPT17
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用客户体验改善计划
goto :EOF

:OPT18
sc config "TrkWks" start= disabled >nul
sc stop "TrkWks" >nul
echo [√] 禁用NTFS链接跟踪服务
goto :EOF

:OPT19
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止自动维护计划
goto :EOF

:OPT20
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "RefsDisableUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 不要自动升级ReFS文件系统版本
goto :EOF

:OPT21
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f >nul
echo [√] 突破260个字符的路径长度限制
goto :EOF

:OPT22
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止NTFS更新文件访问时间
goto :EOF

:OPT23
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsAllowExtendedCharacterIn8dot3Name" /t REG_DWORD /d 1 /f >nul
echo [√] 允许NTFS在短文件名中使用扩展字符集
goto :EOF

:OPT24
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f >nul
echo [√] 将NTFS主文件表的保留空间设置为200MB
goto :EOF

:OPT25
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] NTFS分区损坏时允许生成错误检查
goto :EOF

:OPT26
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "NoVolumeTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 禁用NTFS卷快照提示
goto :EOF

:OPT27
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
echo [√] 启用大系统缓存以提高性能
goto :EOF

:OPT28
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止系统内核与驱动程序分页到硬盘
goto :EOF

:OPT29
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
echo [√] 将文件管理系统缓存增加至256MB
goto :EOF

:OPT30
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭Windows预读功能
goto :EOF

:OPT31
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul
echo [√] 禁用处理器的幽灵和熔断补丁以提高性能
goto :EOF

:OPT32
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
echo [√] VHD启动时节省磁盘空间
goto :EOF

:OPT33
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭系统自动调试功能
goto :EOF

:OPT34
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
echo [√] 将磁盘错误检查等待时间缩短到五秒
goto :EOF

:OPT35
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
echo [√] 设备安装禁止创建系统还原点
goto :EOF

:OPT36
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
echo [√] 弹出USB磁盘后彻底断开电源
goto :EOF

:OPT37
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭快速启动
goto :EOF

:OPT38
powercfg /hibernate off
echo [√] 关闭休眠
goto :EOF

:OPT39
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
echo [√] 根据语言设置隐藏字体
goto :EOF

:OPT40
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
echo [√] 微软拼音输入法关闭云计算
goto :EOF

:OPT41
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 禁止Win10/11进行大版本更新
goto :EOF

:OPT42
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] Windows更新不包括恶意软件删除工具
goto :EOF

:OPT43
sc config "wuauserv" start= disabled >nul
sc stop "wuauserv" >nul
echo [√] 禁用Windows更新
goto :EOF

:OPT44
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用内容传递优化服务
goto :EOF

:OPT45
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用功能更新安全措施
goto :EOF

:OPT46
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用蓝屏后自动重启
goto :EOF

:OPT47
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用Installer detection
goto :EOF

:OPT48
sc config "ATMFD" start= disabled >nul
sc stop "ATMFD" >nul
echo [√] 禁用Adobe Type Manager字体驱动
goto :EOF

:OPT49
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
echo [√] 禁用保留空间
goto :EOF

:OPT50
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul
echo [√] 启用硬件加速GPU计划
goto :EOF

:OPT51
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d 2 /f >nul
echo [√] 优化处理器性能和内存设置
goto :EOF

:OPT52
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 降低Cortana性能，减少CPU占用
goto :EOF

:OPT53
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /t REG_BINARY /d 22222200000200000002000000000000 /f >nul
echo [√] 关闭Exploit Protection
goto :EOF

:OPT54
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
echo [√] 关闭广告ID
goto :EOF

:OPT55
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭应用启动跟踪
goto :EOF

:OPT56
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 去除搜索页面信息流和热搜
goto :EOF

:OPT57
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /t REG_SZ /d "7152" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2024-01-01T10:00:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2024-01-01T10:00:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2024-01-01T09:59:52Z" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
echo [√] 停止更新到2999年
goto :EOF

:OPT58
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /t REG_DWORD /d 1 /f >nul
echo [√] 关闭TSX漏洞补丁
goto :EOF

:OPT59
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_SZ /d "ffffffff" /f >nul
echo [√] 优化进程数量
goto :EOF

:OPT60
sc config "DPS" start= disabled >nul
sc stop "DPS" >nul
echo [√] 关闭诊断策略服务
goto :EOF

:OPT61
sc config "PcaSvc" start= disabled >nul
sc stop "PcaSvc" >nul
echo [√] 关闭程序兼容性助手
goto :EOF

:OPT62
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 关闭微软客户体验改进计划
goto :EOF

:OPT63
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用交付优化
goto :EOF

:OPT64
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /t REG_DWORD /d 4 /f >nul
echo [√] 禁用高精度事件定时器(HPET)
goto :EOF

:OPT65
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用Game Bar
goto :EOF

:OPT66
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 禁用自动更新商店应用
goto :EOF

:OPT67
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul
echo [√] 禁用自动更新地图
goto :EOF

:OPT68
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 1 /f >nul
echo [√] 加速Windows启动
goto :EOF

:OPT69
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
echo [√] 禁用上下文菜单显示延迟
goto :EOF

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - Edge优化设置
::-------------------------------------------------------------------------------------------
:Edge

cls
echo.===============================================================================
echo.                    ZyperWin++ - Edge优化设置
echo.===============================================================================
echo.
echo 请选择要应用的优化项（可多选，用空格分隔）：
echo.
echo   [ 1] 不要显示"首次运行"欢迎页面
echo   [ 2] 关闭Adobe Flash即点即用
echo   [ 3] 关闭后禁止继续运行后台应用
echo   [ 4] 阻止必应搜索结果中的所有广告
echo   [ 5] 禁用新选项卡页面上的微软资讯
echo   [ 6] 隐藏新标签页中的默认热门网站
echo   [ 7] 隐藏Edge浏览器边栏
echo   [ 8] 禁用Smartscreen筛选器
echo   [ 9] 不要发送任何诊断数据
echo   [10] 禁用标签页性能检测器
echo   [11] 关闭停止支持旧系统的通知
echo   [12] 关闭Edge自启动
echo   [13] 启用效率模式
echo   [14] 关闭"由你的组织管理"提示
echo.
echo   [A] 应用所有优化
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :OPT1
    if %%c EQU 2 call :OPT2
    if %%c EQU 3 call :OPT3
    if %%c EQU 4 call :OPT4
    if %%c EQU 5 call :OPT5
    if %%c EQU 6 call :OPT6
    if %%c EQU 7 call :OPT7
    if %%c EQU 8 call :OPT8
    if %%c EQU 9 call :OPT9
    if %%c EQU 10 call :OPT10
    if %%c EQU 11 call :OPT11
    if %%c EQU 12 call :OPT12
    if %%c EQU 13 call :OPT13
    if %%c EQU 14 call :OPT14
)

echo.
echo 注意：部分优化需要重启Edge浏览器才能生效
echo.
pause
goto custom_optimize


:: 下面是各个优化函数的实现
:OPT1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用"首次运行"欢迎页面
goto :EOF

:OPT2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Adobe Flash即点即用
goto :EOF

:OPT3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止Edge关闭后继续运行后台应用
goto :EOF

:OPT4
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" /t REG_DWORD /d 2 /f >nul
echo [√] 已阻止必应搜索结果中的所有广告
goto :EOF

:OPT5
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用新选项卡页面上的微软资讯内容
goto :EOF

:OPT6
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d 1 /f >nul
echo [√] 已隐藏新标签页中的默认热门网站
goto :EOF

:OPT7
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏Edge浏览器边栏
goto :EOF

:OPT8
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Smartscreen筛选器
goto :EOF

:OPT9
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止发送任何诊断数据
goto :EOF

:OPT10
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用标签页性能检测器
goto :EOF

:OPT11
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭停止支持旧系统的通知
goto :EOF

:OPT12
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Edge自启动
goto :EOF

:OPT13
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" /t REG_DWORD /d 2 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用效率模式
goto :EOF

:OPT14
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭"由你的组织管理"提示
goto :EOF

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安全设置
::-------------------------------------------------------------------------------------------
:anquan

cls
echo.===============================================================================
echo.                    ZyperWin++ - 安全设置
echo.===============================================================================
echo.
echo 请选择要应用的优化项（可多选，用空格分隔）：
echo.
echo   [ 1] 将UAC调整为从不通知
echo   [ 2] 启用内置管理员账户的管理审批模式
echo   [ 3] 仅提升安全路径下的UIAccess程序
echo   [ 4] 允许UIAccess在非安全桌面上提升
echo   [ 5] 关闭SmartScreen应用筛选器
echo   [ 6] 关闭打开程序的安全警告
echo   [ 7] 禁用Windows Defender
echo   [ 8] 关闭默认共享
echo   [ 9] 关闭防火墙
echo   [10] 不允许SAM账户的匿名枚举
echo   [11] 启用不安全的来宾登录
echo   [12] 关闭远程协助
echo   [13] 禁用安全中心所有通知
echo   [14] 禁用Defender篡改保护
echo   [15] UAC管理员不提示直接提升
echo   [16] 禁用安全桌面提示
echo   [17] 禁用SmartScreen在线服务
echo   [18] 禁用基于虚拟化的安全性(VBS)
echo   [19] 关闭WD应用程序控制(WDAC)
echo   [20] 禁用烦人的安全通知
echo   [21] 禁用安全中心服务
echo   [22] 禁用内存完整性(VBS)
echo   [23] 禁用Windows平台二进制表
echo   [24] 禁用AMSI
echo   [25] 禁用代码完整性
echo   [26] 禁用UAC
echo.
echo   [A] 应用所有优化
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :OPT1
    if %%c EQU 2 call :OPT2
    if %%c EQU 3 call :OPT3
    if %%c EQU 4 call :OPT4
    if %%c EQU 5 call :OPT5
    if %%c EQU 6 call :OPT6
    if %%c EQU 7 call :OPT7
    if %%c EQU 8 call :OPT8
    if %%c EQU 9 call :OPT9
    if %%c EQU 10 call :OPT10
    if %%c EQU 11 call :OPT11
    if %%c EQU 12 call :OPT12
    if %%c EQU 13 call :OPT13
    if %%c EQU 14 call :OPT14
    if %%c EQU 15 call :OPT15
    if %%c EQU 16 call :OPT16
    if %%c EQU 17 call :OPT17
    if %%c EQU 18 call :OPT18
    if %%c EQU 19 call :OPT19
    if %%c EQU 20 call :OPT20
    if %%c EQU 21 call :OPT21
    if %%c EQU 22 call :OPT22
    if %%c EQU 23 call :OPT23
    if %%c EQU 24 call :OPT24
    if %%c EQU 25 call :OPT25
    if %%c EQU 26 call :OPT26
)

echo.
echo 注意：部分优化需要重启系统才能完全生效
echo.
pause
goto custom_optimize

:: 下面是各个优化函数的实现
:OPT1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
echo [√] 已将UAC调整为从不通知
goto :EOF

:OPT2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f >nul
echo [√] 已启用内置管理员账户的管理审批模式
goto :EOF

:OPT3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d 1 /f >nul
echo [√] 仅提升安全路径下的UIAccess程序
goto :EOF

:OPT4
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul
echo [√] 允许UIAccess在非安全桌面上提升
goto :EOF

:OPT5
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭SmartScreen应用筛选器
goto :EOF

:OPT6
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "LowRiskFileTypes" /t REG_SZ /d ".exe;.bat;.cmd" /f >nul
echo [√] 已关闭打开程序的安全警告
goto :EOF

:OPT7
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
sc config WinDefend start= disabled >nul
sc stop WinDefend >nul
echo [√] 已禁用Windows Defender
goto :EOF

:OPT8
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭默认共享
goto :EOF

:OPT9
netsh advfirewall set allprofiles state off >nul
echo [√] 已关闭防火墙
goto :EOF

:OPT10
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymous" /t REG_DWORD /d 1 /f >nul
echo [√] 不允许SAM账户的匿名枚举
goto :EOF

:OPT11
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用不安全的来宾登录
goto :EOF

:OPT12
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭远程协助
goto :EOF

:OPT13
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Security Center" /v "Notifications_Disable" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用安全中心所有通知
goto :EOF

:OPT14
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Defender篡改保护
goto :EOF

:OPT15
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] UAC管理员不提示直接提升
goto :EOF

:OPT16
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用安全桌面提示
goto :EOF

:OPT17
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
echo [√] 已禁用SmartScreen在线服务
goto :EOF

:OPT18
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul
bcdedit /set hypervisorlaunchtype off >nul 2>&1
echo [√] 已禁用基于虚拟化的安全性(VBS)
goto :EOF

:OPT19
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭WD应用程序控制(WDAC)
goto :EOF

:OPT20
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用烦人的安全通知
goto :EOF

:OPT21
sc config wscsvc start= disabled >nul
sc stop wscsvc >nul
echo [√] 已禁用安全中心服务
goto :EOF

:OPT22
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用内存完整性(VBS)
goto :EOF

:OPT23
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnablePlatformSecurity" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Windows平台二进制表
goto :EOF

:OPT24
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用AMSI
goto :EOF

:OPT25
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用代码完整性
goto :EOF

:OPT26
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul
echo [√] 已完全禁用UAC
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 隐私设置
::-------------------------------------------------------------------------------------------
:yinsi

cls
echo.===============================================================================
echo.                    ZyperWin++ - 隐私设置
echo.===============================================================================
echo.
echo 请选择要应用的隐私设置（可多选，用空格分隔）：
echo.
echo   [ 1] 禁用页面预测功能
echo   [ 2] 禁用开始屏幕建议
echo   [ 3] 禁用活动收集
echo   [ 4] 禁用应用启动跟踪
echo   [ 5] 禁用广告标识符
echo   [ 6] 禁用应用访问文件系统
echo   [ 7] 禁用应用访问文档
echo   [ 8] 禁用应用访问日历
echo   [ 9] 禁用应用访问联系人
echo   [10] 禁用应用访问视频
echo   [11] 禁用网站语言跟踪
echo   [12] 禁用Windows欢迎体验
echo   [13] 禁用反馈频率
echo   [14] 禁用诊断数据收集
echo   [15] 禁用写作习惯跟踪
echo   [16] 禁用设置应用建议
echo   [17] 禁用Bing搜索结果
echo   [18] 禁用通讯录收集
echo   [19] 禁用键入文本收集
echo   [20] 禁用搜索历史
echo   [21] 禁用赞助商应用安装
echo   [22] 禁用自动连接热点
echo   [23] 禁用输入数据个性化
echo   [24] 禁用键入见解
echo   [25] 禁用预安装应用
echo   [26] 禁用.NET遥测
echo   [27] 禁用PowerShell遥测
echo   [28] 禁用遥测服务
echo   [29] 禁用错误报告(WER)
echo   [30] 禁用语音激活(Cortana)
echo   [31] 禁用位置服务
echo   [32] 禁用搜索数据收集
echo   [33] 禁用定向广告
echo   [34] 禁用Wi-Fi感知
echo   [35] 禁用步骤记录器
echo   [36] 禁用活动订阅源
echo   [37] 禁用应用访问账户信息
echo   [38] 禁用应用访问运动数据
echo   [39] 禁用应用访问电话
echo   [40] 禁用应用访问信任设备
echo   [41] 禁用应用访问同步
echo   [42] 禁用应用访问诊断信息
echo   [43] 禁用应用访问通话记录
echo   [44] 禁用应用访问电子邮件
echo   [45] 禁用应用访问任务
echo   [46] 禁用应用访问消息
echo.
echo   [A] 应用所有优化
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :OPT1
    if %%c EQU 2 call :OPT2
    if %%c EQU 3 call :OPT3
    if %%c EQU 4 call :OPT4
    if %%c EQU 5 call :OPT5
    if %%c EQU 6 call :OPT6
    if %%c EQU 7 call :OPT7
    if %%c EQU 8 call :OPT8
    if %%c EQU 9 call :OPT9
    if %%c EQU 10 call :OPT10
    if %%c EQU 11 call :OPT11
    if %%c EQU 12 call :OPT12
    if %%c EQU 13 call :OPT13
    if %%c EQU 14 call :OPT14
    if %%c EQU 15 call :OPT15
    if %%c EQU 16 call :OPT16
    if %%c EQU 17 call :OPT17
    if %%c EQU 18 call :OPT18
    if %%c EQU 19 call :OPT19
    if %%c EQU 20 call :OPT20
    if %%c EQU 21 call :OPT21
    if %%c EQU 22 call :OPT22
    if %%c EQU 23 call :OPT23
    if %%c EQU 24 call :OPT24
    if %%c EQU 25 call :OPT25
    if %%c EQU 26 call :OPT26
    if %%c EQU 27 call :OPT27
    if %%c EQU 28 call :OPT28
    if %%c EQU 29 call :OPT29
    if %%c EQU 30 call :OPT30
    if %%c EQU 31 call :OPT31
    if %%c EQU 32 call :OPT32
    if %%c EQU 33 call :OPT33
    if %%c EQU 34 call :OPT34
    if %%c EQU 35 call :OPT35
    if %%c EQU 36 call :OPT36
    if %%c EQU 37 call :OPT37
    if %%c EQU 38 call :OPT38
    if %%c EQU 39 call :OPT39
    if %%c EQU 40 call :OPT40
    if %%c EQU 41 call :OPT41
    if %%c EQU 42 call :OPT42
    if %%c EQU 43 call :OPT43
    if %%c EQU 44 call :OPT44
    if %%c EQU 45 call :OPT45
    if %%c EQU 46 call :OPT46
)

echo.
pause
goto custom_optimize


:: 下面是各个设置函数的实现

:OPT1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用页面预测功能
goto :EOF

:OPT2
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始屏幕建议
goto :EOF

:OPT3
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用活动收集
goto :EOF

:OPT4
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用应用启动跟踪
goto :EOF

:OPT5
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用广告标识符
goto :EOF

:OPT6
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文件系统
goto :EOF

:OPT7
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文档
goto :EOF

:OPT8
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问日历
goto :EOF

:OPT9
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问联系人
goto :EOF

:OPT10
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问视频
goto :EOF

:OPT11
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用网站语言跟踪
goto :EOF

:OPT12
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows欢迎体验
goto :EOF

:OPT13
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用反馈频率
goto :EOF

:OPT14
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用诊断数据收集
goto :EOF

:OPT15
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写作习惯跟踪
goto :EOF

:OPT16
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用设置应用建议
goto :EOF

:OPT17
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Bing搜索结果
goto :EOF

:OPT18
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用通讯录收集
goto :EOF

:OPT19
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入文本收集
goto :EOF

:OPT20
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索历史
goto :EOF

:OPT21
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用赞助商应用安装
goto :EOF

:OPT22
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用自动连接热点
goto :EOF

:OPT23
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用输入数据个性化
goto :EOF

:OPT24
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入见解
goto :EOF

:OPT25
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用预安装应用
goto :EOF

:OPT26
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用.NET遥测
goto :EOF

:OPT27
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用PowerShell遥测
goto :EOF

:OPT28
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
echo [√] 已禁用遥测服务
goto :EOF

:OPT29
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告(WER)
goto :EOF

:OPT30
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用语音激活(Cortana)
goto :EOF

:OPT31
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用位置服务
goto :EOF

:OPT32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索数据收集
goto :EOF

:OPT33
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用定向广告
goto :EOF

:OPT34
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Wi-Fi感知
goto :EOF

:OPT35
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用步骤记录器
goto :EOF

:OPT36
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用活动订阅源
goto :EOF

:OPT37
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问账户信息
goto :EOF

:OPT38
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问运动数据
goto :EOF

:OPT39
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电话
goto :EOF

:OPT40
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问信任设备
goto :EOF

:OPT41
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问同步
goto :EOF

:OPT42
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问诊断信息
goto :EOF

:OPT43
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问通话记录
goto :EOF

:OPT44
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电子邮件
goto :EOF

:OPT45
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问任务
goto :EOF

:OPT46
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问消息
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 外观/资源管理器
::-------------------------------------------------------------------------------------------
:rizhi

cls
echo.===============================================================================
echo.                    ZyperWin++ - 日志设置
echo.===============================================================================
echo.
echo 请选择要禁用的日志设置（可多选，用空格分隔）：
echo.
echo   [ 1] 禁用组件堆栈日志
echo   [ 2] 禁用更新解压模块日志
echo   [ 3] 禁用错误报告日志
echo   [ 4] 禁用组件堆栈文件备份
echo   [ 5] 禁用崩溃时写入调试信息
echo   [ 6] 禁用账户登录日志报告
echo   [ 7] 禁用WfpDiag.ETL日志
echo   [ 8] 禁用写入调试信息
echo   [ 9] 禁用将事件写入系统日志
echo.
echo   [A] 应用所有优化
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto custom_optimize
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    if %%c EQU 1 call :OPT1
    if %%c EQU 2 call :OPT2
    if %%c EQU 3 call :OPT3
    if %%c EQU 4 call :OPT4
    if %%c EQU 5 call :OPT5
    if %%c EQU 6 call :OPT6
    if %%c EQU 7 call :OPT7
    if %%c EQU 8 call :OPT8
    if %%c EQU 9 call :OPT9
)

echo.
echo 注意：部分设置需要重启系统才能完全生效
echo.
pause
goto custom_optimize

:: 下面是各个设置函数的实现
:OPT1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用组件堆栈日志
goto :EOF

:OPT2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用更新解压模块日志
goto :EOF

:OPT3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告日志
goto :EOF

:OPT4
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "BackupRegistry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用组件堆栈文件备份
goto :EOF

:OPT5
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用崩溃时写入调试信息
goto :EOF

:OPT6
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用账户登录日志报告
goto :EOF

:OPT7
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用WfpDiag.ETL日志
goto :EOF

:OPT8
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写入调试信息
goto :EOF

:OPT9
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用将事件写入系统日志
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 服务项优化
::-------------------------------------------------------------------------------------------
:fuwuxiang

cls
echo.===============================================================================
echo.                    ZyperWin++ - 服务项优化
echo.===============================================================================
echo.
echo 注意：此过程可能此过程可能需要几分钟时间时间，请耐心等待...
echo.

:: 服务优化 - 禁用不必要的服务
echo 正在禁用并停止非必要服务...
echo.

:: 诊断跟踪服务
sc config DiagTrack start= disabled >nul
sc stop DiagTrack >nul 2>&1
echo [√] 已禁用: DiagTrack (诊断跟踪服务)

:: SuperFetch服务
sc config SysMain start= disabled >nul
sc stop SysMain >nul 2>&1
echo [√] 已禁用: SysMain (SuperFetch服务)

:: Windows搜索服务
sc config WSearch start= disabled >nul
sc stop WSearch >nul 2>&1
echo [√] 已禁用: WSearch (Windows搜索服务)

:: Windows更新服务
sc config UsoSvc start= disabled >nul
sc stop UsoSvc >nul 2>&1
echo [√] 已禁用: UsoSvc (Windows更新服务)

:: 分布式链接跟踪服务
sc config TrkWks start= disabled >nul
sc stop TrkWks >nul 2>&1
echo [√] 已禁用: TrkWks (分布式链接跟踪服务)

:: Windows Defender服务
sc config WinDefend start= disabled >nul
sc stop WinDefend >nul 2>&1
echo [√] 已禁用: WinDefend (Windows Defender服务)

:: 诊断服务
sc config diagsvc start= disabled >nul
sc stop diagsvc >nul 2>&1
echo [√] 已禁用: diagsvc (诊断服务)

:: 诊断策略服务
sc config DPS start= disabled >nul
sc stop DPS >nul 2>&1
echo [√] 已禁用: DPS (诊断策略服务)

:: 诊断服务主机
sc config WdiServiceHost start= disabled >nul
sc stop WdiServiceHost >nul 2>&1
echo [√] 已禁用: WdiServiceHost (诊断服务主机)

:: 诊断系统主机
sc config WdiSystemHost start= disabled >nul
sc stop WdiSystemHost >nul 2>&1
echo [√] 已禁用: WdiSystemHost (诊断系统主机)

:: 地图服务
sc config MapsBroker start= demand >nul
echo [√] 已设置手动: MapsBroker (地图服务)

:: IP助手服务
sc config iphlpsvc start= disabled >nul
sc stop iphlpsvc >nul 2>&1
echo [√] 已禁用: iphlpsvc (IP助手服务)

:: 诊断中心收集器服务
sc config diagnosticshub.standardcollector.service start= disabled >nul
sc stop diagnosticshub.standardcollector.service >nul 2>&1
echo [√] 已禁用: diagnosticshub.standardcollector.service (诊断中心收集器)

:: SMS路由器服务
sc config SmsRouter start= disabled >nul
sc stop SmsRouter >nul 2>&1
echo [√] 已禁用: SmsRouter (SMS路由器服务)

:: 程序兼容性助手服务
sc config PcaSvc start= disabled >nul
sc stop PcaSvc >nul 2>&1
echo [√] 已禁用: PcaSvc (程序兼容性助手)

:: Shell硬件检测服务
sc config ShellHWDetection start= demand >nul
echo [√] 已设置手动: ShellHWDetection (Shell硬件检测)

:: 系统防护服务
sc config SgrmBroker start= disabled >nul
sc stop SgrmBroker >nul 2>&1
echo [√] 已禁用: SgrmBroker (系统防护服务)

:: 任务计划服务
sc config Schedule start= demand >nul
echo [√] 已设置手动: Schedule (任务计划服务)

:: Windows事件收集服务
sc config Wecsvc start= disabled >nul
sc stop Wecsvc >nul 2>&1
echo [√] 已禁用: Wecsvc (Windows事件收集服务)

:: 安全健康服务
sc config SecurityHealthService start= disabled >nul
sc stop SecurityHealthService >nul 2>&1
echo [√] 已禁用: SecurityHealthService (安全健康服务)

echo.
echo 服务项优化已完成! 按任意键返回
echo.
echo 注意：部分设置需要重启系统才能完全生效
echo.
pause
goto custom_optimize


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 垃圾清理
::-------------------------------------------------------------------------------------------
:laji

cls
echo.===============================================================================
echo.                    ZyperWin++ - 垃圾清理
echo.===============================================================================
echo 正在清理临时文件和缓存...
echo.

:: 临时文件
del /f /s /q "%SystemDrive%\Windows\Temp\*" >nul 2>&1
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
del /f /s /q "%TEMP%\*" >nul 2>&1
echo [√] 清理: 临时文件

:: 缩略图缓存
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo [√] 清理: 缩略图缓存

:: Windows Defender文件
del /f /s /q "%ProgramData%\Microsoft\Windows Defender\Scans\*" >nul 2>&1
echo [√] 清理: Windows Defender临时文件

:: DirectX着色器缓存
del /f /s /q "%LocalAppData%\Local\D3DSCache\*" >nul 2>&1
echo [√] 清理: DirectX着色器缓存

:: 传递优化文件
del /f /s /q "%SystemRoot%\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1
echo [√] 清理: 传递优化文件

:: 诊断数据
del /f /s /q "%ProgramData%\Microsoft\Diagnosis\*" >nul 2>&1
echo [√] 清理: 诊断数据查看器数据库文件

:: 系统错误文件
del /f /s /q "%SystemRoot%\Minidump\*.dmp" >nul 2>&1
del /f /q "%SystemRoot%\memory.dmp" >nul 2>&1
echo [√] 清理: 系统错误文件

:: Windows报告
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportQueue\*" >nul 2>&1
echo [√] 清理: Windows报告文件

:: Windows下载缓存
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
echo [√] 清理: Windows更新缓存

:: Terminal Server缓存
del /f /s /q "%LocalAppData%\Microsoft\Terminal Server Client\Cache\*" >nul 2>&1
echo [√] 清理: Terminal Server Client缓存

:: Windows预读取文件
del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1
echo [√] 清理: Windows预读取文件

:: WinINet缓存
del /f /s /q "%LocalAppData%\Microsoft\Windows\INetCache\*" >nul 2>&1
echo [√] 清理: WinINet网页缓存

:: WinINet Cookies
del /f /s /q "%LocalAppData%\Microsoft\Windows\INetCookies\*" >nul 2>&1
echo [√] 清理: WinINet Cookies

:: Winsxs临时文件
del /f /s /q "%SystemRoot%\WinSxS\Temp\*" >nul 2>&1
echo [√] 清理: Winsxs临时文件

:: Windows日志
del /f /s /q "%SystemRoot%\Logs\*" >nul 2>&1
echo [√] 清理: Windows日志文件

:: 日常临时文件
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
echo [√] 清理: Windows日常临时文件

:: 崩溃dmp文件
del /f /s /q "%SystemDrive%\*.dmp" >nul 2>&1
echo [√] 清理: 系统崩溃dmp文件

:: 回收站
rd /s /q "%SystemDrive%\$Recycle.bin" >nul 2>&1
echo [√] 清理: 回收站

:: 使用DISM清理WinSxS
echo [√] 清理: 被取代的WinSxS组件 (使用DISM)
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1

:: 清理损坏的Appx
echo [√] 清理: 损坏的Appx应用
powershell -Command "Get-AppxPackage -AllUsers | Where-Object {$_.Status -eq 'Error'} | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul

:: 清理.NET程序集缓存
echo [√] 清理: .NET程序集缓存
rd /s /q "%WinDir%\assembly\NativeImages_v4.0.30319_32" >nul 2>&1
rd /s /q "%WinDir%\assembly\NativeImages_v4.0.30319_64" >nul 2>&1

echo.
echo 垃圾清理已完成！按任意键返回
echo.
pause
goto custom_optimize


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - Office 安装（64位）
::-------------------------------------------------------------------------------------------
:Office_install

cls
echo.===============================================================================
echo.                ZyperWin++ - Office 安装（64位）
echo.===============================================================================
echo.
echo.
echo.            [1]   安装 Office 365 三件套
echo.
echo.            [2]   安装 Office 365 全套
echo. 
echo.            [3]   安装 Office LTSC 2024 三件套
echo.
echo.            [4]   安装 Office LTSC 2024 全套
echo.
echo.            [5]   安装 Office LTSC 2021 三件套
echo.
echo.            [6]   安装 Office LTSC 2021 全套
echo.                             
echo.
echo.                             
echo.
echo.            [X]   返回
echo.
echo.===============================================================================
choice /C:123456X /N /M "请输入你的选项 ："
if errorlevel 7 goto :MainMenu
if errorlevel 6 goto :21A
if errorlevel 5 goto :213
if errorlevel 4 goto :24A
if errorlevel 3 goto :243
if errorlevel 2 goto :365A
if errorlevel 1 goto :3653
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 Office 365 三件套
::-------------------------------------------------------------------------------------------
:3653

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office 365 三件套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能需要几分钟时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 3653.xml
echo 正在部署Office，此过程可能需要几分钟时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 3653.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 Office 365 全套
::-------------------------------------------------------------------------------------------
:365A

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office 365 全套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能需要几分钟时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 365A.xml
echo 正在部署Office，此过程可能需要几分钟时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 365A.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 LTSC 2024 三件套
::-------------------------------------------------------------------------------------------
:243

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office LTSC 2024 三件套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能需要几分钟时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 243.xml
echo 正在部署Office，此过程可能需要几分钟时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 243.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 Office LTSC 2024 全套
::-------------------------------------------------------------------------------------------
:24A

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office LTSC 2024 全套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能需要几分钟时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 24A.xml
echo 正在部署Office，此过程可能需要几分钟时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 24A.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 Office LTSC 2021 三件套
::-------------------------------------------------------------------------------------------
:213

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office LTSC 2021 三件套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能此过程可能需要几分钟时间时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 213.xml
echo 正在部署Office，此过程可能此过程可能需要几分钟时间时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 213.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安装 Office LTSC 2021 全套
::-------------------------------------------------------------------------------------------
:21A

cls
echo.===============================================================================
echo.                ZyperWin++ - 安装 Office LTSC 2021 全套
echo.===============================================================================
echo.
echo 正在下载Office安装文件，此过程可能需要几分钟时间，具体时间取决于您的网速...
echo.
@%~dp0bin\setup.exe /download 21A.xml
echo 正在部署Office，此过程可能需要几分钟时间，具体时间取决于您的配置...
echo.
@%~dp0bin\setup.exe /configure 21A.xml
echo.
echo Office已安装完毕！按任意键返回
@rmdir /s /q "%~dp0bin\Office"
echo.
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 系统激活
::-------------------------------------------------------------------------------------------
:System_activation

cls
echo.===============================================================================
echo.                ZyperWin++ - 系统激活
echo.===============================================================================
echo.
echo 正在智能激活系统/Office，稍等片刻...
echo.
@%~dp0bin\HEU_KMS_Activator.exe /smart
echo.
echo 系统/Office已安装激活完毕！按任意键返回
echo.
pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 关于软件
::-------------------------------------------------------------------------------------------
:about

cls
echo.===============================================================================
echo.                          ZyperWin++ - 关于软件
echo.===============================================================================
echo.
echo.
echo.                             ZyperWin++ v1.0
echo.
echo.              开发者：ZyperWave
echo. 
echo.              作者B站：https://space.bilibili.com/1645147838
echo.
echo.              软件开源：https://github.com/ZyperWave/ZyperWinOptimize
echo.
echo.              特别感谢您选择ZyperWin++这款优化软件！
echo.
echo.              若出现问题请及时反馈！反馈交流群：312820776
echo.                             
echo.
echo.                             
echo.
echo.              [X]   返回
echo.
echo.===============================================================================
choice /C:X /N /M "请输入你的选项 ："
if errorlevel 1 goto :MainMenu
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: 退出 ZyperWin++
::-------------------------------------------------------------------------------------------
:Quit

cls
echo.===============================================================================
echo. 	                      ZyperWin++ - 退出
echo.===============================================================================
echo.
echo.	感谢您的使用，再见！
echo.
echo.	正在退出 ZyperWin++ ...
echo.
echo.===============================================================================
echo.
pause>nul|set /p=请按任意键继续执行...

:: 恢复 DOS 窗口大小
reg delete "HKCU\Console\%%SystemRoot%%_system32_cmd.exe" /f >nul

reg add "HKU\.DEFAULT\Console" /v "FaceName" /t REG_SZ /d "Consolas" /f
reg add "HKU\.DEFAULT\Console" /v "FontFamily" /t REG_DWORD /d "0x36" /f
reg add "HKU\.DEFAULT\Console" /v "FontSize" /t REG_DWORD /d "0x100000" /f
reg add "HKU\.DEFAULT\Console" /v "FontWeight" /t REG_DWORD /d "0x190" /f
reg add "HKU\.DEFAULT\Console" /v "ScreenBufferSize" /t REG_DWORD /d "0x12c0050" /f

color 00
endlocal

exit