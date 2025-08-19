@echo off

title ZyperWin++ v2.2

:: 设置默认控制台背景和前景色
color 1f
set ConsoleBackColor=Blue
set ConsoleForeColor=White

net session >nul 2>&1
if %errorlevel% neq 0 (
	echo.=========================================================
	echo.错误：此脚本需要以管理员身份运行。
	echo.请右键单击此文件，然后选择“以管理员身份运行”。
	echo.
	echo.=========================================================
	echo.
	pause>nul|set /p=请按任意键继续执行……
	color 00
	endlocal
	exit
)

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

if not exist "%~dp0Defender_Control.exe" (
	echo.=========================================================
	echo 错误：未找到 Defender_Control.exe
	echo 请确保本脚本与 Defender_Control.exe 在同一目录下
	echo.
	echo.=========================================================
	pause>nul|set /p=请按任意键继续执行……
	color 00
	endlocal
	exit
)

if not exist "%~dp0MAS_AIO_CN.cmd" (
	echo.=========================================================
	echo 错误：未找到 MAS_AIO_CN.cmd
	echo 请确保本脚本与 MAS_AIO_CN.cmd 在同一目录下
	echo.
	echo.=========================================================
	pause>nul|set /p=请按任意键继续执行……
	color 00
	endlocal
	exit
)

if not exist "%~dp0NSudoLG.exe" (
	echo.=========================================================
	echo 错误：未找到 NSudoLG.exe
	echo 请确保本脚本与 NSudoLG.exe 在同一目录下
	echo.
	echo.=========================================================
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
	"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKCU\Console\%%SystemRoot%%_system32_cmd.exe" /f >nul

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
echo.                           [3]   优 化 还 原
echo.
echo.                           
echo.                           [4]   其 他 功 能
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
if errorlevel 4 goto :others
if errorlevel 3 goto :recover_optimize
if errorlevel 2 goto :custom_optimize
if errorlevel 1 goto :quick_optimize
::-------------------------------------------------------------------------------------------


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 主菜单
::-------------------------------------------------------------------------------------------
:quick_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 快 速 优 化
echo.===============================================================================
echo.
echo.
echo.  [1]   基 本 优 化
echo.
echo.
echo.  [2]   深 度 优 化
echo.
echo.
echo.  [3]   极 限 优 化
echo.
echo.                           
echo.
echo.                           
echo.                             
echo.
echo.                             
echo.
echo.  [X]   退      出
echo.
echo.===============================================================================
choice /C:123X /N /M "请输入你的选项 ："
if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :all_optimize
if errorlevel 2 goto :deep_optimize
if errorlevel 1 goto :basic_optimize
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 基 本 优 化
::-------------------------------------------------------------------------------------------
:basic_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 基 本 优 化
echo.===============================================================================
echo.
echo.  正在执行基本优化...
echo.
echo.  注意：此过程可能此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
echo 正在检测Windows Defender服务状态...
sc query "WinDefend" | findstr /i "RUNNING" >nul
if %errorlevel% equ 0 (
    echo [!] Defender服务正在运行，请手动关闭（Disable）...
    "%~dp0Defender_Control.exe"
    pause
) else (
    echo [√] Defender服务未运行，自动跳过...
)

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏任务栏Cortana

:: 任务栏窗口合并
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用任务栏窗口合并

:: 资源管理器打开显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器打开时显示"此电脑"

:: 总是从内存卸载无用DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用从内存卸载无用DLL

:: 禁止跟踪损坏的快捷方式
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用跟踪损坏的快捷方式

:: 优化文件列表刷新策略
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
echo [√] 已优化Windows文件列表刷新策略

:: 创建快捷方式不添加"快捷方式"字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
echo [√] 创建快捷方式时不添加"快捷方式"字样

:: 禁止自动播放
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
echo [√] 已禁用自动播放

:: 在单独进程中打开文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
echo [√] 已在单独进程中打开文件夹窗口

:: 快速访问不显示常用文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示常用文件夹

:: 快速访问不显示最近使用文件
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示最近使用文件

:: 语言栏隐藏到任务栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
echo [√] 语言栏已隐藏到任务栏

:: 隐藏语言栏帮助按钮
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏语言栏上的帮助按钮

:: 资源管理器崩溃自动重启
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器崩溃时将自动重启

:: 显示文件扩展名
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
echo [√] 已显示已知文件类型的扩展名

:: 桌面显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"此电脑"

:: 桌面显示"回收站"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"回收站"

:: 禁用兼容性疑难解答右键菜单
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单

:: 禁用Windows Defender扫描右键菜单
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单

:: 禁用Bitlocker右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单

:: 禁用"作为便携设备打开"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单

:: 禁用新建联系人右键菜单
reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
echo [√] 已禁用新建的"联系人"右键菜单

:: 禁用"还原先前版本"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单

:: 禁用"刻录到光盘"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
echo [√] 已禁用磁盘的"刻录到光盘"右键菜单

:: 禁用"授予访问权限"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
echo [√] 已禁用"授予访问权限"右键菜单

:: 禁用"始终脱机可用"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单

:: 禁用"固定到快速访问"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
echo [√] 已禁用文件夹的"固定到快速访问"右键菜单

:: 禁用工作文件夹右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
echo [√] 已禁用"工作文件夹"右键菜单

:: 禁用画图3D右键菜单
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
echo [√] 已禁用文件的"画图3D"右键菜单

:: 禁用"包含到库中"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
echo [√] 已禁用文件夹的"包含到库中"右键菜单

:: 禁用开始菜单常用应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最常用的应用

:: 禁用开始菜单最近添加应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最近添加的应用

:: 记事本启用自动换行
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用自动换行

:: 记事本显示状态栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用状态栏显示

:: 退出时清除最近打开文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用退出系统时清除最近打开的文档

:: 恢复Win11经典右键菜单
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul
echo [√] 已恢复Win11经典右键菜单

:: 恢复Win11经典资源管理器
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /ve /t REG_SZ /d "CLSID_ItemsViewAdapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /ve /t REG_SZ /d "File Explorer Xaml Island View Adapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
echo [√] 已恢复Win11经典资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 性能优化设置
:: 不允许在开始菜单显示建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在开始菜单显示建议

:: 不要在应用商店中查找关联应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在应用商店中查找关联应用

:: 关闭商店应用推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭商店应用推广

:: 关闭锁屏时的Windows聚焦推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭锁屏时的Windows聚焦推广

:: 关闭"使用Windows时获取技巧和建议"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭"使用Windows时获取技巧和建议"

:: 关闭游戏录制工具
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭游戏录制工具

:: 关闭多嘴的小娜
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭多嘴的小娜

:: 加快关机速度
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
echo [√] 已加快关机速度

:: 缩短关闭服务等待时间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
echo [√] 已缩短关闭服务等待时间

:: 禁用程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用程序兼容性助手

:: 禁用诊断服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用诊断服务

:: 禁用SysMain
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用SysMain

:: 禁用Windows Search
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用Windows Search

:: 禁用错误报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告

:: 禁用客户体验改善计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用客户体验改善计划

:: 禁用NTFS链接跟踪服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用NTFS链接跟踪服务

:: 禁止自动维护计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止自动维护计划

:: 启用大系统缓存以提高性能
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用大系统缓存以提高性能

:: 禁止系统内核与驱动程序分页到硬盘
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止系统内核与驱动程序分页到硬盘

:: 将文件管理系统缓存增加至256MB
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
echo [√] 已将文件管理系统缓存增加至256MB

:: 将Windows预读调整为关闭预读
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Windows预读功能

:: VHD启动时节省磁盘空间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
echo [√] VHD启动时已节省磁盘空间

:: 关闭系统自动调试功能
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭系统自动调试功能

:: 将磁盘错误检查等待时间缩短到五秒
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
echo [√] 已将磁盘错误检查等待时间缩短到五秒

:: 设备安装禁止创建系统还原点
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
echo [√] 设备安装已禁止创建系统还原点

:: 弹出USB磁盘后彻底断开电源
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
echo [√] 弹出USB磁盘后已彻底断开电源

:: 关闭快速启动
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭快速启动

:: 关闭休眠
powercfg /h off >nul
echo [√] 已关闭休眠

:: 根据语言设置隐藏字体
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
echo [√] 已根据语言设置隐藏字体

:: 微软拼音输入法关闭云计算
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
echo [√] 微软拼音输入法已关闭云计算

:: 禁用内容传递优化服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用内容传递优化服务
:: 禁用程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用: PcaSvc 程序兼容性助手

:: 禁用诊断服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用: DPS 诊断策略服务

:: 禁用SysMain (SuperFetch服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用: SysMain SuperFetch服务

:: 禁用Windows Search
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用: WSearch Windows搜索服务

:: 禁用NTFS链接跟踪服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用: TrkWks 分布式链接跟踪服务

:: 禁用诊断服务主机
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiServiceHost" >nul 2>&1
echo [√] 已禁用: WdiServiceHost 诊断服务主机

:: 禁用诊断系统主机
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiSystemHost" >nul 2>&1
echo [√] 已禁用: WdiSystemHost 诊断系统主机

:: 设置手动: MapsBroker (地图服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "MapsBroker" >nul 2>&1
echo [√] 已设置手动: MapsBroker 地图服务

:: 禁用诊断中心收集器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagnosticshub.standardcollector.service" >nul 2>&1
echo [√] 已禁用: diagnosticshub.standardcollector.service 诊断中心收集器

echo.  ========================================
echo 基本优化已完成! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 深 度 优 化
::-------------------------------------------------------------------------------------------
:deep_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 深 度 优 化
echo.===============================================================================
echo.
echo.  正在执行深度优化...
echo.
echo.  注意：此过程可能此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
echo 正在检测Windows Defender服务状态...
sc query "WinDefend" | findstr /i "RUNNING" >nul
if %errorlevel% equ 0 (
    echo [!] Defender服务正在运行，请手动关闭（Disable）...
    "%~dp0Defender_Control.exe"
    pause
) else (
    echo [√] Defender服务未运行，自动跳过...
)

:: 外观/资源管理器优化
:: 隐藏任务栏Cortana
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏任务栏Cortana

:: 任务栏窗口合并
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用任务栏窗口合并

:: 资源管理器打开显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器打开时显示"此电脑"

:: 总是从内存卸载无用DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用从内存卸载无用DLL

:: 禁止跟踪损坏的快捷方式
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用跟踪损坏的快捷方式

:: 优化文件列表刷新策略
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
echo [√] 已优化Windows文件列表刷新策略

:: 创建快捷方式不添加"快捷方式"字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
echo [√] 创建快捷方式时不添加"快捷方式"字样

:: 禁止自动播放
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
echo [√] 已禁用自动播放

:: 在单独进程中打开文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
echo [√] 已在单独进程中打开文件夹窗口

:: 快速访问不显示常用文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示常用文件夹

:: 快速访问不显示最近使用文件
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示最近使用文件

:: 语言栏隐藏到任务栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
echo [√] 语言栏已隐藏到任务栏

:: 隐藏语言栏帮助按钮
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏语言栏上的帮助按钮

:: 资源管理器崩溃自动重启
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器崩溃时将自动重启

:: 显示文件扩展名
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
echo [√] 已显示已知文件类型的扩展名

:: 桌面显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"此电脑"

:: 桌面显示"回收站"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"回收站"

:: 禁用兼容性疑难解答右键菜单
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单

:: 禁用Windows Defender扫描右键菜单
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单

:: 禁用Bitlocker右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单

:: 禁用"作为便携设备打开"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单

:: 禁用新建联系人右键菜单
reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
echo [√] 已禁用新建的"联系人"右键菜单

:: 禁用"还原先前版本"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单

:: 禁用"刻录到光盘"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
echo [√] 已禁用磁盘的"刻录到光盘"右键菜单

:: 禁用"授予访问权限"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
echo [√] 已禁用"授予访问权限"右键菜单

:: 禁用"始终脱机可用"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单

:: 禁用"固定到快速访问"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
echo [√] 已禁用文件夹的"固定到快速访问"右键菜单

:: 禁用工作文件夹右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
echo [√] 已禁用"工作文件夹"右键菜单

:: 禁用画图3D右键菜单
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
echo [√] 已禁用文件的"画图3D"右键菜单

:: 禁用"包含到库中"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
echo [√] 已禁用文件夹的"包含到库中"右键菜单

:: 禁用开始菜单常用应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最常用的应用

:: 禁用开始菜单最近添加应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最近添加的应用

:: 记事本启用自动换行
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用自动换行

:: 记事本显示状态栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用状态栏显示

:: 退出时清除最近打开文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用退出系统时清除最近打开的文档

:: 恢复Win11经典右键菜单
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul
echo [√] 已恢复Win11经典右键菜单

:: 恢复Win11经典资源管理器
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /ve /t REG_SZ /d "CLSID_ItemsViewAdapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /ve /t REG_SZ /d "File Explorer Xaml Island View Adapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
echo [√] 已恢复Win11经典资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 性能优化设置
:: 不允许在开始菜单显示建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在开始菜单显示建议

:: 不要在应用商店中查找关联应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在应用商店中查找关联应用

:: 关闭商店应用推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭商店应用推广

:: 关闭锁屏时的Windows聚焦推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭锁屏时的Windows聚焦推广

:: 关闭"使用Windows时获取技巧和建议"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭"使用Windows时获取技巧和建议"

:: 关闭游戏录制工具
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭游戏录制工具

:: 关闭多嘴的小娜
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭多嘴的小娜

:: 加快关机速度
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
echo [√] 已加快关机速度

:: 缩短关闭服务等待时间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
echo [√] 已缩短关闭服务等待时间

:: 禁用程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用程序兼容性助手

:: 禁用诊断服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用诊断服务

:: 禁用SysMain
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用SysMain

:: 禁用Windows Search
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用Windows Search

:: 禁用错误报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告

:: 禁用客户体验改善计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用客户体验改善计划

:: 禁用NTFS链接跟踪服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用NTFS链接跟踪服务

:: 禁止自动维护计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止自动维护计划

:: 启用大系统缓存以提高性能
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用大系统缓存以提高性能

:: 禁止系统内核与驱动程序分页到硬盘
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止系统内核与驱动程序分页到硬盘

:: 将文件管理系统缓存增加至256MB
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
echo [√] 已将文件管理系统缓存增加至256MB

:: 将Windows预读调整为关闭预读
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Windows预读功能

:: VHD启动时节省磁盘空间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
echo [√] VHD启动时已节省磁盘空间

:: 关闭系统自动调试功能
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭系统自动调试功能

:: 将磁盘错误检查等待时间缩短到五秒
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
echo [√] 已将磁盘错误检查等待时间缩短到五秒

:: 设备安装禁止创建系统还原点
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
echo [√] 设备安装已禁止创建系统还原点

:: 弹出USB磁盘后彻底断开电源
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
echo [√] 弹出USB磁盘后已彻底断开电源

:: 关闭快速启动
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭快速启动

:: 关闭休眠
powercfg /h off >nul
echo [√] 已关闭休眠

:: 根据语言设置隐藏字体
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
echo [√] 已根据语言设置隐藏字体

:: 微软拼音输入法关闭云计算
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
echo [√] 微软拼音输入法已关闭云计算

:: 禁用内容传递优化服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用内容传递优化服务

:: 禁用SmartScreen筛选器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用SmartScreen筛选器

:: 禁用Windows安全中心报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows安全中心报告

:: 禁用Edge浏览器SmartScreen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Edge浏览器SmartScreen

:: 禁用文件资源管理器SmartScreen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f >nul
echo [√] 已禁用文件资源管理器SmartScreen

:: 禁用Microsoft Store应用SmartScreen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Microsoft Store应用SmartScreen

:: 禁用UAC(用户账户控制)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用UAC

:: 关闭防火墙
netsh advfirewall set allprofiles state off >nul
echo [√] 已关闭防火墙

:: 关闭默认共享
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭默认共享

:: 关闭远程协助
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭远程协助

:: 启用硬件加速GPU计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul
echo [√] 已启用硬件加速GPU计划

:: 优化处理器性能和内存设置
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d 2 /f >nul
echo [√] 已优化处理器性能和内存设置

:: 降低Cortana性能减少CPU占用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已降低Cortana性能，减少CPU占用

:: 关闭广告ID
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭广告ID

:: 关闭应用启动跟踪
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭应用启动跟踪

:: 去除搜索页面信息流和热搜
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已去除搜索页面信息流和热搜

:: 禁用高精度事件定时器(HPET)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /t REG_DWORD /d 4 /f >nul
echo [√] 已禁用高精度事件定时器

:: 禁用Game Bar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Game Bar

:: 禁用远程修改注册表
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用远程修改注册表

:: 禁用保留空间
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
echo [√] 已禁用保留空间

:: 禁用上下文菜单显示延迟
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
echo [√] 已禁用上下文菜单显示延迟

:: 禁用蓝屏后自动重启
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用蓝屏后自动重启

:: 禁用Installer detection
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Installer detection

:: 禁用功能更新安全措施
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用功能更新安全措施

:: 禁用交付优化
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用交付优化

:: 禁用微软客户体验改进计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用微软客户体验改进计划

:: 禁用遥测服务
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
echo [√] 已禁用遥测服务

:: 禁用错误报告(WER)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告

:: 禁用语音激活(Cortana)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用语音激活

:: 禁用位置服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用位置服务

:: 禁用搜索数据收集
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索数据收集

:: 禁用定向广告
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用定向广告

:: 禁用Wi-Fi感知
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Wi-Fi感知

:: 禁用步骤记录器
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用步骤记录器

:: 禁用写入调试信息
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写入调试信息

:: 禁用Windows欢迎体验
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows欢迎体验

:: 禁用反馈频率
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用反馈频率

:: 禁用诊断数据收集
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用诊断数据收集

:: 禁用写作习惯跟踪
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写作习惯跟踪

:: 禁用设置应用建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用设置应用建议

:: 禁用Bing搜索结果
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Bing搜索结果

:: 禁用搜索历史
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索历史

:: 禁用赞助商应用安装
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用赞助商应用安装

:: 禁用自动连接热点
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用自动连接热点

:: 禁用输入数据个性化
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用输入数据个性化

:: 禁用键入见解
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入见解

:: 禁用预安装应用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用预安装应用

:: 禁用.NET遥测
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用.NET遥测

:: 禁用PowerShell遥测
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用PowerShell遥测

:: 禁用自动安装推荐的应用程序
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁止自动安装推荐的应用程序

:: 禁止Win10/11进行大版本更新
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止Win10/11进行大版本更新

:: Windows更新不包括恶意软件删除工具
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] Windows更新已不包括恶意软件删除工具

:: 禁用自动更新商店应用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用自动更新商店应用

:: 禁用自动更新地图
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用自动更新地图

:: 禁用程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用: PcaSvc 程序兼容性助手

:: 禁用诊断服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用: DPS 诊断策略服务

:: 禁用SysMain (SuperFetch服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用: SysMain SuperFetch服务

:: 禁用Windows Search
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用: WSearch Windows搜索服务

:: 禁用NTFS链接跟踪服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用: TrkWks 分布式链接跟踪服务

:: 禁用诊断服务主机
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiServiceHost" >nul 2>&1
echo [√] 已禁用: WdiServiceHost 诊断服务主机

:: 禁用诊断系统主机
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiSystemHost" >nul 2>&1
echo [√] 已禁用: WdiSystemHost 诊断系统主机

:: 设置手动: MapsBroker (地图服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "MapsBroker" >nul 2>&1
echo [√] 已设置手动: MapsBroker 地图服务

:: 禁用诊断中心收集器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagnosticshub.standardcollector.service" >nul 2>&1
echo [√] 已禁用: diagnosticshub.standardcollector.service 诊断中心收集器

:: 禁用IP助手服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "iphlpsvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "iphlpsvc" >nul 2>&1
echo [√] 已禁用: iphlpsvc IP助手服务

:: 禁用SMS路由器服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SmsRouter" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SmsRouter" >nul 2>&1
echo [√] 已禁用: SmsRouter SMS路由器服务

:: 设置手动: Shell硬件检测
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "ShellHWDetection" >nul 2>&1
echo [√] 已设置手动: ShellHWDetection Shell 硬件检测

:: 设置手动: 任务计划服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Schedule" >nul 2>&1
echo [√] 已设置手动: Schedule 任务计划服务

:: 禁用Windows事件收集服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Wecsvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Wecsvc" >nul 2>&1
echo [√] 已禁用: Wecsvc Windows事件收集服务

:: 禁用遥测服务
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
echo [√] 已禁用: DiagTrack 遥测服务

echo.  ========================================
echo 深度优化已完成! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 极 限 优 化
::-------------------------------------------------------------------------------------------
:all_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 极 限 优 化
echo.===============================================================================
echo.
echo.  正在执行极限优化...
echo.
echo.  注意：此过程可能此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
echo 正在检测Windows Defender服务状态...
sc query "WinDefend" | findstr /i "RUNNING" >nul
if %errorlevel% equ 0 (
    echo [!] Defender服务正在运行，请手动关闭（Disable）...
    "%~dp0Defender_Control.exe"
    pause
) else (
    echo [√] Defender服务未运行，自动跳过...
)

:: 禁用LSA保护(RunAsPPL)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "RunAsPPL" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPLBoot" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用LSA保护

:: 禁用SmartScreen筛选器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用SmartScreen筛选器

:: 禁用Windows安全中心报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows安全中心报告

:: 禁用驱动程序阻止列表
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用驱动程序阻止列表

:: 禁用Edge浏览器SmartScreen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Edge浏览器SmartScreen

:: 禁用文件资源管理器SmartScreen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f >nul
echo [√] 已禁用文件资源管理器SmartScreen

:: 禁用Microsoft Store应用SmartScreen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Microsoft Store应用SmartScreen

:: 禁用攻击面减少规则(ASR)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR" /v "ExploitGuard_ASR_Rules" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用攻击面减少规则

:: 禁用UAC(用户账户控制)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用UAC

:: 禁用虚拟化安全(VBS)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /t REG_DWORD /d 0 /f >nul
bcdedit /set hypervisorlaunchtype off >nul 2>&1
echo [√] 已禁用虚拟化安全

:: 禁用凭证保护(Credential Guard)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用凭证保护

:: 禁用受控文件夹访问
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用受控文件夹访问

:: 禁用网络保护
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用网络保护

:: 禁用AMSI
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用AMSI

:: 禁用代码完整性
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用代码完整性

:: 关闭防火墙
netsh advfirewall set allprofiles state off >nul
echo [√] 已关闭防火墙

:: 关闭默认共享
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭默认共享

:: 关闭远程协助
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭远程协助

:: 启用不安全的来宾登录
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用不安全的来宾登录

:: 外观/资源管理器优化
:: 隐藏任务栏Cortana
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏任务栏Cortana

:: 任务栏窗口合并
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用任务栏窗口合并

:: 资源管理器打开显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器打开时显示"此电脑"

:: 总是从内存卸载无用DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用从内存卸载无用DLL

:: 禁止跟踪损坏的快捷方式
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用跟踪损坏的快捷方式

:: 优化文件列表刷新策略
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
echo [√] 已优化Windows文件列表刷新策略

:: 创建快捷方式不添加"快捷方式"字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
echo [√] 创建快捷方式时不添加"快捷方式"字样

:: 禁止自动播放
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
echo [√] 已禁用自动播放

:: 在单独进程中打开文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
echo [√] 已在单独进程中打开文件夹窗口

:: 快速访问不显示常用文件夹
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示常用文件夹

:: 快速访问不显示最近使用文件
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
echo [√] 快速访问不再显示最近使用文件

:: 语言栏隐藏到任务栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
echo [√] 语言栏已隐藏到任务栏

:: 隐藏语言栏帮助按钮
reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏语言栏上的帮助按钮

:: 资源管理器崩溃自动重启
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
echo [√] 资源管理器崩溃时将自动重启

:: 显示文件扩展名
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
echo [√] 已显示已知文件类型的扩展名

:: 桌面显示"此电脑"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"此电脑"

:: 桌面显示"回收站"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
echo [√] 桌面已显示"回收站"

:: 禁用兼容性疑难解答右键菜单
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单

:: 禁用Windows Defender扫描右键菜单
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单

:: 禁用Bitlocker右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单

:: 禁用"作为便携设备打开"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单

:: 禁用新建联系人右键菜单
reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
echo [√] 已禁用新建的"联系人"右键菜单

:: 禁用"还原先前版本"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单

:: 禁用"刻录到光盘"右键菜单
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
echo [√] 已禁用磁盘的"刻录到光盘"右键菜单

:: 禁用"授予访问权限"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
echo [√] 已禁用"授予访问权限"右键菜单

:: 禁用"始终脱机可用"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单

:: 禁用"固定到快速访问"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
echo [√] 已禁用文件夹的"固定到快速访问"右键菜单

:: 禁用工作文件夹右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
echo [√] 已禁用"工作文件夹"右键菜单

:: 禁用画图3D右键菜单
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
echo [√] 已禁用文件的"画图3D"右键菜单

:: 禁用"包含到库中"右键菜单
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
echo [√] 已禁用文件夹的"包含到库中"右键菜单

:: 禁用开始菜单常用应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最常用的应用

:: 禁用开始菜单最近添加应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始菜单App列表-最近添加的应用

:: 记事本启用自动换行
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用自动换行

:: 记事本显示状态栏
reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
echo [√] 记事本已启用状态栏显示

:: 退出时清除最近打开文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用退出系统时清除最近打开的文档

:: 恢复Win11经典右键菜单
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul
echo [√] 已恢复Win11经典右键菜单

:: 恢复Win11经典资源管理器
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /ve /t REG_SZ /d "CLSID_ItemsViewAdapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /ve /t REG_SZ /d "File Explorer Xaml Island View Adapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
echo [√] 已恢复Win11经典资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 性能优化设置
:: 不允许在开始菜单显示建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在开始菜单显示建议

:: 不要在应用商店中查找关联应用
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止在应用商店中查找关联应用

:: 关闭商店应用推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭商店应用推广

:: 关闭锁屏时的Windows聚焦推广
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭锁屏时的Windows聚焦推广

:: 关闭"使用Windows时获取技巧和建议"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭"使用Windows时获取技巧和建议"

:: 禁止自动安装推荐的应用程序
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁止自动安装推荐的应用程序

:: 关闭游戏录制工具
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭游戏录制工具

:: 关闭多嘴的小娜
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭多嘴的小娜

:: 加快关机速度
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
echo [√] 已加快关机速度

:: 缩短关闭服务等待时间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
echo [√] 已缩短关闭服务等待时间

:: 禁用程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用程序兼容性助手

:: 禁用远程修改注册表
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用远程修改注册表

:: 禁用诊断服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用诊断服务

:: 禁用SysMain
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用SysMain

:: 禁用Windows Search
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用Windows Search

:: 禁用错误报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告

:: 禁用客户体验改善计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用客户体验改善计划

:: 禁用NTFS链接跟踪服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用NTFS链接跟踪服务

:: 禁止自动维护计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止自动维护计划

:: 启用大系统缓存以提高性能
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用大系统缓存以提高性能

:: 禁止系统内核与驱动程序分页到硬盘
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止系统内核与驱动程序分页到硬盘

:: 将文件管理系统缓存增加至256MB
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
echo [√] 已将文件管理系统缓存增加至256MB

:: 将Windows预读调整为关闭预读
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Windows预读功能

:: 禁用处理器的幽灵和熔断补丁
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul
echo [√] 已禁用处理器的幽灵和熔断补丁以提高性能

:: VHD启动时节省磁盘空间
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
echo [√] VHD启动时已节省磁盘空间

:: 关闭系统自动调试功能
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭系统自动调试功能

:: 将磁盘错误检查等待时间缩短到五秒
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
echo [√] 已将磁盘错误检查等待时间缩短到五秒

:: 设备安装禁止创建系统还原点
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
echo [√] 设备安装已禁止创建系统还原点

:: 弹出USB磁盘后彻底断开电源
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
echo [√] 弹出USB磁盘后已彻底断开电源

:: 关闭快速启动
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭快速启动

:: 关闭休眠
powercfg /h off >nul
echo [√] 已关闭休眠

:: 根据语言设置隐藏字体
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
echo [√] 已根据语言设置隐藏字体

:: 微软拼音输入法关闭云计算
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
echo [√] 微软拼音输入法已关闭云计算

:: 禁用内容传递优化服务
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用内容传递优化服务

:: 禁用功能更新安全措施
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用功能更新安全措施

:: 禁用蓝屏后自动重启
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用蓝屏后自动重启

:: 禁用Installer detection
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Installer detection

:: 禁用上下文菜单显示延迟
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
echo [√] 已禁用上下文菜单显示延迟

:: 禁用保留空间
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
echo [√] 已禁用保留空间

:: 启用硬件加速GPU计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul
echo [√] 已启用硬件加速GPU计划

:: 优化处理器性能和内存设置
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d 2 /f >nul
echo [√] 已优化处理器性能和内存设置

:: 降低Cortana性能减少CPU占用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已降低Cortana性能，减少CPU占用

:: 关闭Exploit Protection
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /t REG_BINARY /d 22222200000200000002000000000000 /f >nul
echo [√] 已关闭Exploit Protection

:: 关闭广告ID
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭广告ID

:: 关闭应用启动跟踪
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭应用启动跟踪

:: 去除搜索页面信息流和热搜
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已去除搜索页面信息流和热搜

:: 关闭TSX漏洞补丁
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭TSX漏洞补丁

:: 优化进程数量
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_SZ /d "ffffffff" /f >nul
echo [√] 已优化进程数量

:: 关闭诊断策略服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已关闭诊断策略服务

:: 关闭程序兼容性助手
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已关闭程序兼容性助手

:: 关闭微软客户体验改进计划
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭微软客户体验改进计划

:: 禁用交付优化
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用交付优化

:: 禁用高精度事件定时器(HPET)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /t REG_DWORD /d 4 /f >nul
echo [√] 已禁用高精度事件定时器

:: 禁用Game Bar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Game Bar

:: Edge优化设置
:: 禁用"首次运行"欢迎页面
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用"首次运行"欢迎页面

:: 关闭Adobe Flash即点即用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Adobe Flash即点即用

:: 关闭后禁止继续运行后台应用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止Edge关闭后继续运行后台应用

:: 阻止必应搜索结果中的所有广告
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" /t REG_DWORD /d 2 /f >nul
echo [√] 已阻止必应搜索结果中的所有广告

:: 禁用新选项卡页面上的微软资讯
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用新选项卡页面上的微软资讯内容

:: 隐藏新标签页中的默认热门网站
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d 1 /f >nul
echo [√] 已隐藏新标签页中的默认热门网站

:: 隐藏Edge浏览器边栏
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" /t REG_DWORD /d 0 /f >nul
echo [√] 已隐藏Edge浏览器边栏

:: 禁用Smartscreen筛选器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Smartscreen筛选器

:: 禁止发送任何诊断数据
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁止发送任何诊断数据

:: 禁用标签页性能检测器
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用标签页性能检测器

:: 关闭停止支持旧系统的通知
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭停止支持旧系统的通知

:: 关闭Edge自启动
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已关闭Edge自启动

:: 启用效率模式
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" /t REG_DWORD /d 1 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" /t REG_DWORD /d 2 /f >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已启用效率模式

:: 关闭"由你的组织管理"提示
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" /t REG_DWORD /d 1 /f >nul
echo [√] 已关闭"由你的组织管理"提示

:: 隐私设置
:: 禁用页面预测功能
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用页面预测功能

:: 禁用开始屏幕建议
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用开始屏幕建议

:: 禁用活动收集
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用活动收集

:: 禁用应用启动跟踪
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用应用启动跟踪

:: 禁用广告标识符
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用广告标识符

:: 禁用应用访问文件系统
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文件系统

:: 禁用应用访问文档
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问文档

:: 禁用应用访问日历
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问日历

:: 禁用应用访问联系人
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问联系人

:: 禁用应用访问视频
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问视频

:: 禁用网站语言跟踪
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用网站语言跟踪

:: 禁用Windows欢迎体验
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Windows欢迎体验

:: 禁用反馈频率
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用反馈频率

:: 禁用诊断数据收集
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用诊断数据收集

:: 禁用写作习惯跟踪
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写作习惯跟踪

:: 禁用设置应用建议
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用设置应用建议

:: 禁用Bing搜索结果
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用Bing搜索结果

:: 禁用通讯录收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用通讯录收集

:: 禁用键入文本收集
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入文本收集

:: 禁用搜索历史
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索历史

:: 禁用赞助商应用安装
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用赞助商应用安装

:: 禁用自动连接热点
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用自动连接热点

:: 禁用输入数据个性化
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用输入数据个性化

:: 禁用键入见解
reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用键入见解

:: 禁用预安装应用
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用预安装应用

:: 禁用.NET遥测
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用.NET遥测

:: 禁用PowerShell遥测
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用PowerShell遥测

:: 禁用遥测服务
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
echo [√] 已禁用遥测服务

:: 禁用错误报告(WER)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告

:: 禁用语音激活(Cortana)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用语音激活

:: 禁用位置服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用位置服务

:: 禁用搜索数据收集
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用搜索数据收集

:: 禁用定向广告
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用定向广告

:: 禁用Wi-Fi感知
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用Wi-Fi感知

:: 禁用步骤记录器
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用步骤记录器

:: 禁用写入调试信息
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用写入调试信息

:: 禁用应用访问账户信息
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问账户信息

:: 禁用应用访问运动数据
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问运动数据

:: 禁用应用访问电话
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电话

:: 禁用应用访问信任设备
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问信任设备

:: 禁用应用访问同步
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问同步

:: 禁用应用访问诊断信息
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问诊断信息

:: 禁用应用访问通话记录
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问通话记录

:: 禁用应用访问电子邮件
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问电子邮件

:: 禁用应用访问任务
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问任务

:: 禁用应用访问消息
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" /t REG_SZ /d "Deny" /f >nul
echo [√] 已禁用应用访问消息

:: 禁用组件堆栈日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用组件堆栈日志

:: 禁用更新解压模块日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用更新解压模块日志

:: 禁用错误报告日志
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用错误报告日志

:: 禁用将事件写入系统日志
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用将事件写入系统日志

:: 禁用崩溃时写入调试信息
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用崩溃时写入调试信息

:: 禁用账户登录日志报告
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁用账户登录日志报告

:: 禁用WfpDiag.ETL日志
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用WfpDiag.ETL日志

:: 更新设置
:: 禁止Win10/11进行大版本更新
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul
echo [√] 已禁止Win10/11进行大版本更新

:: Windows更新不包括恶意软件删除工具
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul
echo [√] Windows更新已不包括恶意软件删除工具

:: 禁用Windows更新 停止更新到2999年
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
echo [√] 已停止更新到2999年

:: 禁用自动更新商店应用
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
echo [√] 已禁用自动更新商店应用

:: 禁用自动更新地图
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul
echo [√] 已禁用自动更新地图

:: 服务项优化
:: SecurityHealthService (安全健康服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SecurityHealthService" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SecurityHealthService" >nul 2>&1
echo [√] 已禁用: SecurityHealthService 安全健康服务

:: SysMain (SuperFetch服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
echo [√] 已禁用: SysMain SuperFetch服务

:: WSearch (Windows搜索服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
echo [√] 已禁用: WSearch Windows搜索服务

:: UsoSvc (Windows更新服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "UsoSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "UsoSvc" >nul 2>&1
echo [√] 已禁用: UsoSvc Windows更新服务

:: TrkWks (分布式链接跟踪服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
echo [√] 已禁用: TrkWks 分布式链接跟踪服务

:: WinDefend (Windows Defender服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WinDefend" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WinDefend" >nul 2>&1
echo [√] 已禁用: WinDefend Windows Defender服务

:: diagsvc (诊断服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagsvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagsvc" >nul 2>&1
echo [√] 已禁用: diagsvc 诊断服务

:: DPS (诊断策略服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
echo [√] 已禁用: DPS 诊断策略服务

:: WdiServiceHost (诊断服务主机)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiServiceHost" >nul 2>&1
echo [√] 已禁用: WdiServiceHost 诊断服务主机

:: WdiSystemHost (诊断系统主机)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiSystemHost" >nul 2>&1
echo [√] 已禁用: WdiSystemHost 诊断系统主机

:: MapsBroker (地图服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "MapsBroker" >nul 2>&1
echo [√] 已设置手动: MapsBroker 地图服务

:: iphlpsvc (IP助手服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "iphlpsvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "iphlpsvc" >nul 2>&1
echo [√] 已禁用: iphlpsvc IP助手服务

:: diagnosticshub.standardcollector.service (诊断中心收集器)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagnosticshub.standardcollector.service" >nul 2>&1
echo [√] 已禁用: diagnosticshub.standardcollector.service 诊断中心收集器

:: SmsRouter (SMS路由器服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SmsRouter" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SmsRouter" >nul 2>&1
echo [√] 已禁用: SmsRouter SMS路由器服务

:: PcaSvc (程序兼容性助手)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
echo [√] 已禁用: PcaSvc 程序兼容性助手

:: ShellHWDetection (Shell硬件检测)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "ShellHWDetection" >nul 2>&1
echo [√] 已设置手动: ShellHWDetection Shell 硬件检测

:: SgrmBroker (系统防护服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SgrmBroker" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SgrmBroker" >nul 2>&1
echo [√] 已禁用: SgrmBroker 系统防护服务

:: Schedule (任务计划服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= demand >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Schedule" >nul 2>&1
echo [√] 已设置手动: Schedule 任务计划服务

:: Wecsvc (Windows事件收集服务)
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Wecsvc" start= disabled >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Wecsvc" >nul 2>&1
echo [√] 已禁用: Wecsvc

echo.  ========================================
echo 极限优化已完成! 
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
echo.  [1]   外观/资源管理器
echo.
echo.  [2]   性能优化设置
echo.
echo.  [3]   Edge优化设置
echo.
echo.  [4]   安全设置
echo.
echo.  [5]   隐私设置
echo.
echo.  [6]   更新设置
echo.
echo.  [7]   服务项优化
echo.
echo.
echo.
echo.  [X]   返回
echo.
echo.===============================================================================
choice /C:1234567X /N /M "请输入你的选项 ："
if errorlevel 8 goto :MainMenu
if errorlevel 7 goto :fuwuxiang
if errorlevel 6 goto :update
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
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,37) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_OPT_Status

cls
echo.===============================================================================
echo.                    ZyperWin++ - 外观/资源管理器优化设置
echo.===============================================================================
echo. 状态标记: [+]已优化  [-]未优化
echo.
echo   [ 1] %opt1_mark% 隐藏任务栏Cortana
echo   [ 2] %opt2_mark% 任务栏窗口合并
echo   [ 3] %opt3_mark% 资源管理器打开显示"此电脑"
echo   [ 4] %opt4_mark% 总是从内存卸载无用DLL
echo   [ 5] %opt5_mark% 禁止跟踪损坏的快捷方式
echo   [ 6] %opt6_mark% 优化文件列表刷新策略
echo   [ 7] %opt7_mark% 创建快捷方式不添加"快捷方式"字样
echo   [ 8] %opt8_mark% 禁止自动播放
echo   [ 9] %opt9_mark% 在单独进程中打开文件夹
echo   [10] %opt10_mark% 快速访问不显示常用文件夹
echo   [11] %opt11_mark% 快速访问不显示最近使用文件
echo   [12] %opt12_mark% 语言栏隐藏到任务栏
echo   [13] %opt13_mark% 隐藏语言栏帮助按钮
echo   [14] %opt14_mark% 资源管理器崩溃自动重启
echo   [15] %opt15_mark% 显示文件扩展名
echo   [16] %opt16_mark% 桌面显示"此电脑"
echo   [17] %opt17_mark% 桌面显示"回收站"
echo   [18] %opt18_mark% 禁用兼容性疑难解答右键菜单
echo   [19] %opt19_mark% 禁用Windows Defender扫描右键菜单
echo   [20] %opt20_mark% 禁用Bitlocker右键菜单
echo   [21] %opt21_mark% 禁用"作为便携设备打开"右键菜单
echo   [22] %opt22_mark% 禁用新建联系人右键菜单
echo   [23] %opt23_mark% 禁用"还原先前版本"右键菜单
echo   [24] %opt24_mark% 禁用"刻录到光盘"右键菜单
echo   [25] %opt25_mark% 禁用"授予访问权限"右键菜单
echo   [26] %opt26_mark% 禁用"始终脱机可用"右键菜单
echo   [27] %opt27_mark% 禁用"固定到快速访问"右键菜单
echo   [28] %opt28_mark% 禁用工作文件夹右键菜单
echo   [29] %opt29_mark% 禁用画图3D右键菜单
echo   [30] %opt30_mark% 禁用"包含到库中"右键菜单
echo   [31] %opt31_mark% 禁用开始菜单常用应用
echo   [32] %opt32_mark% 禁用开始菜单最近添加应用
echo   [33] %opt33_mark% 记事本启用自动换行
echo   [34] %opt34_mark% 记事本显示状态栏
echo   [35] %opt35_mark% 退出时清除最近打开文档
echo   [36] %opt36_mark% Win11恢复经典右键
echo   [37] %opt37_mark% Win11恢复经典资源管理器
echo.
echo   [A] 应用所有未优化的项
echo   [R] 重启资源管理器
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto waiguan
if /i "%choices%"=="X" goto custom_optimize
if /i "%choices%"=="R" goto RESTART_EXPLORER

:: 处理全选（只选未优化的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,37) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有优化项已应用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_OPT %%c
)

:: 更新状态
for /l %%i in (1,1,37) do set "opt%%i_status=0"
call :Check_OPT_Status

echo.
echo 注意：部分设置需要重启资源管理器才能生效
echo.
pause
goto waiguan

:: 检测所有优化项状态的函数
:Check_OPT_Status
:: 1.隐藏任务栏Cortana
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")

:: 2.任务栏窗口合并
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.资源管理器打开显示"此电脑"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.总是从内存卸载无用DLL
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.禁止跟踪损坏的快捷方式
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.优化文件列表刷新策略
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.创建快捷方式不添加"快捷方式"字样
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" 2>nul | findstr /i "00000000" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.禁止自动播放
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" 2>nul | findstr /i "0xff" >nul
if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")

:: 9.在单独进程中打开文件夹
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.快速访问不显示常用文件夹
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.快速访问不显示最近使用文件
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")

:: 12.语言栏隐藏到任务栏
reg query "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" 2>nul | findstr /i "0x3" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.隐藏语言栏帮助按钮
reg query "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")

:: 14.资源管理器崩溃自动重启
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")

:: 15.显示文件扩展名
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt15_status=1" & set "opt15_mark=[+]") else (set "opt15_mark=[-]")

:: 16.桌面显示"此电脑"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt16_status=1" & set "opt16_mark=[+]") else (set "opt16_mark=[-]")

:: 17.桌面显示"回收站"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt17_status=1" & set "opt17_mark=[+]") else (set "opt17_mark=[-]")

:: 18.禁用兼容性疑难解答右键菜单
reg query "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" 2>nul
if %errorlevel% neq 0 (set "opt18_status=1" & set "opt18_mark=[+]") else (set "opt18_mark=[-]")

:: 19.禁用Windows Defender扫描右键菜单
reg query "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" 2>nul
if %errorlevel% neq 0 (set "opt19_status=1" & set "opt19_mark=[+]") else (set "opt19_mark=[-]")

:: 20.禁用Bitlocker右键菜单
reg query "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" 2>nul
if %errorlevel% neq 0 (set "opt20_status=1" & set "opt20_mark=[+]") else (set "opt20_mark=[-]")

:: 21.禁用"作为便携设备打开"右键菜单
reg query "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" 2>nul
if %errorlevel% neq 0 (set "opt21_status=1" & set "opt21_mark=[+]") else (set "opt21_mark=[-]")

:: 22.禁用新建联系人右键菜单
reg query "HKEY_CLASSES_ROOT\.contact\ShellNew" 2>nul
if %errorlevel% neq 0 (set "opt22_status=1" & set "opt22_mark=[+]") else (set "opt22_mark=[-]")

:: 23.禁用"还原先前版本"右键菜单
reg query "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" 2>nul
if %errorlevel% neq 0 (set "opt23_status=1" & set "opt23_mark=[+]") else (set "opt23_mark=[-]")

:: 24.禁用"刻录到光盘"右键菜单
reg query "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" 2>nul
if %errorlevel% neq 0 (set "opt24_status=1" & set "opt24_mark=[+]") else (set "opt24_mark=[-]")

:: 25.禁用"授予访问权限"右键菜单
reg query "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" 2>nul
if %errorlevel% neq 0 (set "opt25_status=1" & set "opt25_mark=[+]") else (set "opt25_mark=[-]")

:: 26.禁用"始终脱机可用"右键菜单
reg query "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" 2>nul
if %errorlevel% neq 0 (set "opt26_status=1" & set "opt26_mark=[+]") else (set "opt26_mark=[-]")

:: 27.禁用"固定到快速访问"右键菜单
reg query "HKEY_CLASSES_ROOT\Folder\shell\pintohome" 2>nul
if %errorlevel% neq 0 (set "opt27_status=1" & set "opt27_mark=[+]") else (set "opt27_mark=[-]")

:: 28.禁用工作文件夹右键菜单
reg query "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" 2>nul
if %errorlevel% neq 0 (set "opt28_status=1" & set "opt28_mark=[+]") else (set "opt28_mark=[-]")

:: 29.禁用画图3D右键菜单
reg query "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" 2>nul
if %errorlevel% neq 0 (set "opt29_status=1" & set "opt29_mark=[+]") else (set "opt29_mark=[-]")

:: 30.禁用"包含到库中"右键菜单
reg query "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" 2>nul
if %errorlevel% neq 0 (set "opt30_status=1" & set "opt30_mark=[+]") else (set "opt30_mark=[-]")

:: 31.禁用开始菜单常用应用
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt31_status=1" & set "opt31_mark=[+]") else (set "opt31_mark=[-]")

:: 32.禁用开始菜单最近添加应用
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt32_status=1" & set "opt32_mark=[+]") else (set "opt32_mark=[-]")

:: 33.记事本启用自动换行
reg query "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt33_status=1" & set "opt33_mark=[+]") else (set "opt33_mark=[-]")

:: 34.记事本显示状态栏
reg query "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt34_status=1" & set "opt34_mark=[+]") else (set "opt34_mark=[-]")

:: 35.退出时清除最近打开文档
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt35_status=1" & set "opt35_mark=[+]") else (set "opt35_mark=[-]")

:: 36. Win11恢复经典右键
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" >nul 2>&1
if %errorlevel% equ 0 (set "opt36_status=1" & set "opt36_mark=[+]") else (set "opt36_mark=[-]")

:: 37. Win11恢复经典资源管理器
reg query "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" >nul 2>&1
if %errorlevel% equ 0 (set "opt37_status=1" & set "opt37_mark=[+]") else (set "opt37_mark=[-]")
goto :eof

:: 切换优化状态的函数
:Toggle_OPT
setlocal
set option=%1

:: 1.隐藏任务栏Cortana
if %option% equ 1 (
    if %opt1_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul
        echo [√] 已隐藏任务栏Cortana
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul
        echo [√] 已显示任务栏Cortana
    )
    goto :EOF
)

:: 2.任务栏窗口合并
if %option% equ 2 (
    if %opt2_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用任务栏窗口合并
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用任务栏窗口合并
    )
    goto :EOF
)

:: 3.资源管理器打开显示"此电脑"
if %option% equ 3 (
    if %opt3_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
        echo [√] 资源管理器打开时显示"此电脑"
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 2 /f >nul
        echo [√] 资源管理器打开时显示"快速访问"
    )
    goto :EOF
)

:: 4.总是从内存卸载无用DLL
if %option% equ 4 (
    if %opt4_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用从内存卸载无用DLL
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用从内存卸载无用DLL
    )
    goto :EOF
)

:: 5.禁止跟踪损坏的快捷方式
if %option% equ 5 (
    if %opt5_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用跟踪损坏的快捷方式
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用跟踪损坏的快捷方式
    )
    goto :EOF
)

:: 6.优化文件列表刷新策略
if %option% equ 6 (
    if %opt6_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul
        echo [√] 已优化Windows文件列表刷新策略
    ) else (
        reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 200000 /f >nul
        echo [√] 已恢复默认文件列表刷新策略
    )
    goto :EOF
)

:: 7.创建快捷方式不添加"快捷方式"字样
if %option% equ 7 (
    if %opt7_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
        echo [√] 创建快捷方式时不添加"快捷方式"字样
    ) else (
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul
        echo [√] 已恢复快捷方式默认命名规则
    )
    goto :EOF
)

:: 8.禁止自动播放
if %option% equ 8 (
    if %opt8_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul
        echo [√] 已禁用自动播放
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 145 /f >nul
        echo [√] 已启用自动播放
    )
    goto :EOF
)

:: 9.在单独进程中打开文件夹
if %option% equ 9 (
    if %opt9_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul
        echo [√] 已在单独进程中打开文件夹窗口
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用单独进程打开文件夹窗口
    )
    goto :EOF
)

:: 10.快速访问不显示常用文件夹
if %option% equ 10 (
    if %opt10_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
        echo [√] 快速访问不再显示常用文件夹
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 1 /f >nul
        echo [√] 快速访问已显示常用文件夹
    )
    goto :EOF
)

:: 11.快速访问不显示最近使用文件
if %option% equ 11 (
    if %opt11_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
        echo [√] 快速访问不再显示最近使用文件
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 1 /f >nul
        echo [√] 快速访问已显示最近使用文件
    )
    goto :EOF
)

:: 12.语言栏隐藏到任务栏
if %option% equ 12 (
    if %opt12_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 3 /f >nul
        echo [√] 语言栏已隐藏到任务栏
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 0 /f >nul
        echo [√] 语言栏已恢复默认显示
    )
    goto :EOF
)

:: 13.隐藏语言栏帮助按钮
if %option% equ 13 (
    if %opt13_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f >nul
        echo [√] 已隐藏语言栏上的帮助按钮
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d 1 /f >nul
        echo [√] 已显示语言栏上的帮助按钮
    )
    goto :EOF
)

:: 14.资源管理器崩溃自动重启
if %option% equ 14 (
    if %opt14_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 1 /f >nul
        echo [√] 资源管理器崩溃时将自动重启
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用资源管理器崩溃自动重启
    )
    goto :EOF
)

:: 15.显示文件扩展名
if %option% equ 15 (
    if %opt15_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
        echo [√] 已显示已知文件类型的扩展名
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 1 /f >nul
        echo [√] 已隐藏已知文件类型的扩展名
    )
    goto :EOF
)

:: 16.桌面显示"此电脑"
if %option% equ 16 (
    if %opt16_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f >nul
        echo [√] 桌面已显示"此电脑"
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 1 /f >nul
        echo [√] 桌面已隐藏"此电脑"
    )
    goto :EOF
)

:: 17.桌面显示"回收站"
if %option% equ 17 (
    if %opt17_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0 /f >nul
        echo [√] 桌面已显示"回收站"
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 1 /f >nul
        echo [√] 桌面已隐藏"回收站"
    )
    goto :EOF
)

:: 18.禁用兼容性疑难解答右键菜单
if %option% equ 18 (
    if %opt18_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f >nul 2>&1
        echo [√] 已禁用可执行文件的"兼容性疑难解答"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >nul
        echo [√] 已恢复可执行文件的"兼容性疑难解答"右键菜单
    )
    goto :EOF
)

:: 19.禁用Windows Defender扫描右键菜单
if %option% equ 19 (
    if %opt19_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
        echo [√] 已禁用文件/文件夹的"使用Windows Defender扫描"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /ve /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul
        echo [√] 已恢复文件/文件夹的"使用Windows Defender扫描"右键菜单
    )
    goto :EOF
)

:: 20.禁用Bitlocker右键菜单
if %option% equ 20 (
    if %opt20_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /f >nul 2>&1
        echo [√] 已禁用磁盘的"启用Bitlocker"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /ve /t REG_SZ /d "BitLocker" /f >nul
        echo [√] 已恢复磁盘的"启用Bitlocker"右键菜单
    )
    goto :EOF
)

:: 21.禁用"作为便携设备打开"右键菜单
if %option% equ 21 (
    if %opt21_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /f >nul 2>&1
        echo [√] 已禁用磁盘的"作为便携设备打开"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /ve /t REG_SZ /d "PortableDeviceMenu" /f >nul
        echo [√] 已恢复磁盘的"作为便携设备打开"右键菜单
    )
    goto :EOF
)

:: 22.禁用新建联系人右键菜单
if %option% equ 22 (
    if %opt22_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /f >nul 2>&1
        echo [√] 已禁用新建的"联系人"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\.contact\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul
        echo [√] 已恢复新建的"联系人"右键菜单
    )
    goto :EOF
)


:: 23.禁用"还原先前版本"右键菜单
if %option% equ 23 (
    if %opt23_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
        echo [√] 已禁用文件/磁盘的"还原先前版本"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /ve /t REG_SZ /d "" /f >nul
        echo [√] 已恢复文件/磁盘的"还原先前版本"右键菜单
    )
    goto :EOF
)

:: 24.禁用"刻录到光盘"右键菜单
if %option% equ 24 (
    if %opt24_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /f >nul 2>&1
        echo [√] 已禁用磁盘的"刻录到光盘"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /ve /t REG_SZ /d "" /f >nul
        echo [√] 已恢复磁盘的"刻录到光盘"右键菜单
    )
    goto :EOF
)

:: 25.禁用"授予访问权限"右键菜单
if %option% equ 25 (
    if %opt25_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
        echo [√] 已禁用"授予访问权限"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >nul
        echo [√] 已恢复"授予访问权限"右键菜单
    )
    goto :EOF
)

:: 26.禁用"始终脱机可用"右键菜单
if %option% equ 26 (
    if %opt26_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /f >nul 2>&1
        echo [√] 已禁用文件/文件夹的"始终脱机可用"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >nul
        echo [√] 已恢复文件/文件夹的"始终脱机可用"右键菜单
    )
    goto :EOF
)

:: 27.禁用"固定到快速访问"右键菜单
if %option% equ 27 (
    if %opt27_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /f >nul 2>&1
        echo [√] 已禁用文件夹的"固定到快速访问"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /ve /t REG_SZ /d "固定到快速访问" /f >nul
        echo [√] 已恢复文件夹的"固定到快速访问"右键菜单
    )
    goto :EOF
)

:: 28.禁用工作文件夹右键菜单
if %option% equ 28 (
    if %opt28_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /f >nul 2>&1
        echo [√] 已禁用"工作文件夹"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "{E50FF753-70F3-4C12-95FB-6586AFEBA48B}" /f >nul
        echo [√] 已恢复"工作文件夹"右键菜单
    )
    goto :EOF
)

:: 29.禁用画图3D右键菜单
if %option% equ 29 (
    if %opt29_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
        echo [√] 已禁用文件的"画图3D"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /ve /t REG_SZ /d "画图3D" /f >nul
        echo [√] 已恢复文件的"画图3D"右键菜单
    )
    goto :EOF
)

:: 30.禁用"包含到库中"右键菜单
if %option% equ 30 (
    if %opt30_status% equ 0 (
        reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /f >nul 2>&1
        echo [√] 已禁用文件夹的"包含到库中"右键菜单
    ) else (
        reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "{018B4BE5-2F3F-45E6-9B3D-4D4BEE19812D}" /f >nul
        echo [√] 已恢复文件夹的"包含到库中"右键菜单
    )
    goto :EOF
)

:: 31.禁用开始菜单常用应用
if %option% equ 31 (
    if %opt31_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用开始菜单App列表-最常用的应用
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用开始菜单App列表-最常用的应用
    )
    goto :EOF
)

:: 32.禁用开始菜单最近添加应用
if %option% equ 32 (
    if %opt32_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用开始菜单App列表-最近添加的应用
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用开始菜单App列表-最近添加的应用
    )
    goto :EOF
)

:: 33.记事本启用自动换行
if %option% equ 33 (
    if %opt33_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f >nul
        echo [√] 记事本已启用自动换行
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 0 /f >nul
        echo [√] 记事本已禁用自动换行
    )
    goto :EOF
)

:: 34.记事本显示状态栏
if %option% equ 34 (
    if %opt34_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 1 /f >nul
        echo [√] 记事本已启用状态栏显示
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 0 /f >nul
        echo [√] 记事本已禁用状态栏显示
    )
    goto :EOF
)

:: 35.退出时清除最近打开文档
if %option% equ 35 (
    if %opt35_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用退出系统时清除最近打开的文档
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用退出系统时清除最近打开的文档
    )
    goto :EOF
)
goto :EOF

:OPT36
if %opt36_status% equ 0 (
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul
    echo [√] 已恢复Win11经典右键菜单
) else (
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul
    echo [√] 已还原Win11默认右键菜单
)
goto :eof

:OPT37
if %opt37_status% equ 0 (
    reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /ve /t REG_SZ /d "CLSID_ItemsViewAdapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /ve /t REG_SZ /d "File Explorer Xaml Island View Adapter" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /ve /t REG_SZ /d "C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v ThreadingModel /t REG_SZ /d Apartment /f >nul
    echo [√] 已恢复Win11经典资源管理器
) else (
    reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /f >nul
    echo [√] 已还原Win11默认资源管理器
)
endlocal
goto :EOF

:RESTART_EXPLORER
echo.
echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启
echo.
pause
goto waiguan

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 性能优化设置
::-------------------------------------------------------------------------------------------
:xingneng
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,54) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_OPT_Status

:xingneng
cls
echo.===============================================================================
echo.                    ZyperWin++ - 性能优化设置
echo.===============================================================================
echo. 状态标记: [+]已优化  [-]未优化
echo.
echo   [ 1] %opt1_mark% 不允许在开始菜单显示建议
echo   [ 2] %opt2_mark% 不要在应用商店中查找关联应用
echo   [ 3] %opt3_mark% 关闭商店应用推广
echo   [ 4] %opt4_mark% 关闭锁屏时的Windows聚焦推广
echo   [ 5] %opt5_mark% 关闭"使用Windows时获取技巧和建议"
echo   [ 6] %opt6_mark% 禁止自动安装推荐的应用程序
echo   [ 7] %opt7_mark% 关闭游戏录制工具
echo   [ 8] %opt8_mark% 关闭多嘴的小娜
echo   [ 9] %opt9_mark% 加快关机速度
echo   [10] %opt10_mark% 缩短关闭服务等待时间
echo   [11] %opt11_mark% 禁用程序兼容性助手
echo   [12] %opt12_mark% 禁用远程修改注册表
echo   [13] %opt13_mark% 禁用诊断服务
echo   [14] %opt14_mark% 禁用SysMain
echo   [15] %opt15_mark% 禁用Windows Search
echo   [16] %opt16_mark% 禁用错误报告
echo   [17] %opt17_mark% 禁用客户体验改善计划
echo   [18] %opt18_mark% 禁用NTFS链接跟踪服务
echo   [19] %opt19_mark% 禁止自动维护计划
echo   [20] %opt20_mark% 启用大系统缓存以提高性能
echo   [21] %opt21_mark% 禁止系统内核与驱动程序分页到硬盘
echo   [22] %opt22_mark% 将文件管理系统缓存增加至256MB
echo   [23] %opt23_mark% 将Windows预读调整为关闭预读
echo   [24] %opt24_mark% 禁用处理器的幽灵和熔断补丁
echo   [25] %opt25_mark% VHD启动时节省磁盘空间
echo   [26] %opt26_mark% 关闭系统自动调试功能
echo   [27] %opt27_mark% 将磁盘错误检查等待时间缩短到五秒
echo   [28] %opt28_mark% 设备安装禁止创建系统还原点
echo   [29] %opt29_mark% 弹出USB磁盘后彻底断开电源
echo   [30] %opt30_mark% 关闭快速启动
echo   [31] %opt31_mark% 关闭休眠
echo   [32] %opt32_mark% 根据语言设置隐藏字体
echo   [33] %opt33_mark% 微软拼音输入法关闭云计算
echo   [34] %opt34_mark% 禁用内容传递优化服务
echo   [35] %opt35_mark% 禁用功能更新安全措施
echo   [36] %opt36_mark% 禁用蓝屏后自动重启
echo   [37] %opt37_mark% 禁用Installer detection
echo   [38] %opt38_mark% 禁用上下文菜单显示延迟
echo   [39] %opt39_mark% 禁用保留空间
echo   [40] %opt40_mark% 启用硬件加速GPU计划
echo   [41] %opt41_mark% 优化处理器性能和内存设置
echo   [42] %opt42_mark% 降低Cortana性能减少CPU占用
echo   [43] %opt43_mark% 关闭Exploit Protection
echo   [44] %opt44_mark% 关闭广告ID
echo   [45] %opt45_mark% 关闭应用启动跟踪
echo   [46] %opt46_mark% 去除搜索页面信息流和热搜
echo   [47] %opt47_mark% 关闭TSX漏洞补丁
echo   [48] %opt48_mark% 优化进程数量
echo   [49] %opt49_mark% 关闭诊断策略服务
echo   [50] %opt50_mark% 关闭程序兼容性助手
echo   [51] %opt51_mark% 关闭微软客户体验改进计划
echo   [52] %opt52_mark% 禁用交付优化
echo   [53] %opt53_mark% 禁用高精度事件定时器(HPET)
echo   [54] %opt54_mark% 禁用Game Bar
echo.
echo   [A] 应用所有未优化的项
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto xingneng
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选（只选未优化的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,54) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有优化项已应用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_OPT %%c
)

:: 更新状态
for /l %%i in (1,1,54) do set "opt%%i_status=0"
call :Check_OPT_Status

echo.
echo 注意：部分设置需要重启系统才能完全生效
echo.
pause
goto xingneng

:: 检测所有优化项状态的函数
:Check_OPT_Status
:: 1.不允许在开始菜单显示建议
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")

:: 2.不要在应用商店中查找关联应用
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.关闭商店应用推广
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.关闭锁屏时的Windows聚焦推广
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.关闭"使用Windows时获取技巧和建议"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.禁止自动安装推荐的应用程序
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" 2>nul | findstr /i "0x2" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.关闭游戏录制工具
reg query "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.关闭多嘴的小娜
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")

:: 9.加快关机速度
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" 2>nul | findstr /i "1000" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.缩短关闭服务等待时间
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" 2>nul | findstr /i "0x7d0" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.禁用程序兼容性助手
sc query "PcaSvc" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")

:: 12.禁用远程修改注册表
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.禁用诊断服务
sc query "DPS" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")

:: 14.禁用SysMain
sc query "SysMain" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")

:: 15.禁用Windows Search
sc query "WSearch" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt15_status=1" & set "opt15_mark=[+]") else (set "opt15_mark=[-]")

:: 16.禁用错误报告
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt16_status=1" & set "opt16_mark=[+]") else (set "opt16_mark=[-]")

:: 17.禁用客户体验改善计划
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt17_status=1" & set "opt17_mark=[+]") else (set "opt17_mark=[-]")

:: 18.禁用NTFS链接跟踪服务
sc query "TrkWks" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt18_status=1" & set "opt18_mark=[+]") else (set "opt18_mark=[-]")

:: 19.禁止自动维护计划
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt19_status=1" & set "opt19_mark=[+]") else (set "opt19_mark=[-]")

:: 20.启用大系统缓存以提高性能
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt20_status=1" & set "opt20_mark=[+]") else (set "opt20_mark=[-]")

:: 21.禁止系统内核与驱动程序分页到硬盘
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt21_status=1" & set "opt21_mark=[+]") else (set "opt21_mark=[-]")

:: 22.将文件管理系统缓存增加至256MB
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" 2>nul | findstr /i "0x400000" >nul
if %errorlevel% equ 0 (set "opt22_status=1" & set "opt22_mark=[+]") else (set "opt22_mark=[-]")

:: 23.将Windows预读调整为关闭预读
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt23_status=1" & set "opt23_mark=[+]") else (set "opt23_mark=[-]")

:: 24.禁用处理器的幽灵和熔断补丁
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" 2>nul | findstr /i "0x3" >nul
if %errorlevel% equ 0 (set "opt24_status=1" & set "opt24_mark=[+]") else (set "opt24_mark=[-]")

:: 25.VHD启动时节省磁盘空间
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" 2>nul | findstr /i "0x4" >nul
if %errorlevel% equ 0 (set "opt25_status=1" & set "opt25_mark=[+]") else (set "opt25_mark=[-]")

:: 26.关闭系统自动调试功能
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt26_status=1" & set "opt26_mark=[+]") else (set "opt26_mark=[-]")

:: 27.将磁盘错误检查等待时间缩短到五秒
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" 2>nul | findstr /i "0x5" >nul
if %errorlevel% equ 0 (set "opt27_status=1" & set "opt27_mark=[+]") else (set "opt27_mark=[-]")

:: 28.设备安装禁止创建系统还原点
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt28_status=1" & set "opt28_mark=[+]") else (set "opt28_mark=[-]")

:: 29.弹出USB磁盘后彻底断开电源
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt29_status=1" & set "opt29_mark=[+]") else (set "opt29_mark=[-]")

:: 30.关闭快速启动
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt30_status=1" & set "opt30_mark=[+]") else (set "opt30_mark=[-]")

:: 31.关闭休眠
powercfg /a 2>&1 | findstr /i "尚未启用休眠。" >nul
if %errorlevel% equ 0 (set "opt31_status=1" & set "opt31_mark=[+]") else (set "opt31_mark=[-]")

:: 32.根据语言设置隐藏字体
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" 2>nul | findstr /i "10000000000000000000000000000000" >nul
if %errorlevel% equ 0 (set "opt32_status=1" & set "opt32_mark=[+]") else (set "opt32_mark=[-]")

:: 33.微软拼音输入法关闭云计算
reg query "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt33_status=1" & set "opt33_mark=[+]") else (set "opt33_mark=[-]")

:: 34.禁用内容传递优化服务
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt34_status=1" & set "opt34_mark=[+]") else (set "opt34_mark=[-]")

:: 35.禁用功能更新安全措施
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt35_status=1" & set "opt35_mark=[+]") else (set "opt35_mark=[-]")

:: 36.禁用蓝屏后自动重启
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt36_status=1" & set "opt36_mark=[+]") else (set "opt36_mark=[-]")

:: 37.禁用Installer detection
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt37_status=1" & set "opt37_mark=[+]") else (set "opt37_mark=[-]")

:: 38.禁用上下文菜单显示延迟
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" 2>nul | findstr /i "0" >nul
if %errorlevel% equ 0 (set "opt38_status=1" & set "opt38_mark=[+]") else (set "opt38_mark=[-]")

:: 39.禁用保留空间
dism /online /get-reservedstoragestate 2>&1 | findstr /i "已禁用" >nul
if %errorlevel% equ 0 (set "opt39_status=1" & set "opt39_mark=[+]") else (set "opt39_mark=[-]")

:: 40.启用硬件加速GPU计划
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" 2>nul | findstr /i "0x2" >nul
if %errorlevel% equ 0 (set "opt40_status=1" & set "opt40_mark=[+]") else (set "opt40_mark=[-]")

:: 41.优化处理器性能和内存设置
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" 2>nul | findstr /i "0x26" >nul
if %errorlevel% equ 0 (set "opt41_status=1" & set "opt41_mark=[+]") else (set "opt41_mark=[-]")

:: 42.降低Cortana性能减少CPU占用
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt42_status=1" & set "opt42_mark=[+]") else (set "opt42_mark=[-]")

:: 43.关闭Exploit Protection
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" 2>nul | findstr /i "22222200000200000002000000000000" >nul
if %errorlevel% equ 0 (set "opt43_status=1" & set "opt43_mark=[+]") else (set "opt43_mark=[-]")

:: 44.关闭广告ID
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt44_status=1" & set "opt44_mark=[+]") else (set "opt44_mark=[-]")

:: 45.关闭应用启动跟踪
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt45_status=1" & set "opt45_mark=[+]") else (set "opt45_mark=[-]")

:: 46.去除搜索页面信息流和热搜
reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt46_status=1" & set "opt46_mark=[+]") else (set "opt46_mark=[-]")

:: 47.关闭TSX漏洞补丁
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt47_status=1" & set "opt47_mark=[+]") else (set "opt47_mark=[-]")

:: 48.优化进程数量
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" 2>nul | findstr /i "ffffffff" >nul
if %errorlevel% equ 0 (set "opt48_status=1" & set "opt48_mark=[+]") else (set "opt48_mark=[-]")

:: 49.关闭诊断策略服务
sc query "DPS" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt49_status=1" & set "opt49_mark=[+]") else (set "opt49_mark=[-]")

:: 50.关闭程序兼容性助手
sc query "PcaSvc" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt50_status=1" & set "opt50_mark=[+]") else (set "opt50_mark=[-]")

:: 51.关闭微软客户体验改进计划
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt51_status=1" & set "opt51_mark=[+]") else (set "opt51_mark=[-]")

:: 52.禁用交付优化
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt52_status=1" & set "opt52_mark=[+]") else (set "opt52_mark=[-]")

:: 53.禁用高精度事件定时器(HPET)
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" 2>nul | findstr /i "0x4" >nul
if %errorlevel% equ 0 (set "opt53_status=1" & set "opt53_mark=[+]") else (set "opt53_mark=[-]")

:: 54.禁用Game Bar
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt54_status=1" & set "opt54_mark=[+]") else (set "opt54_mark=[-]")
goto :eof

:: 切换优化状态的函数
:Toggle_OPT
setlocal
set option=%1

:: 1.不允许在开始菜单显示建议
if %option% equ 1 (
    if %opt1_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁止在开始菜单显示建议
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /f >nul
        echo [√] 已允许在开始菜单显示建议
    )
    goto :EOF
)

:: 2.不要在应用商店中查找关联应用
if %option% equ 2 (
    if %opt2_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁止在应用商店中查找关联应用
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /f >nul
        echo [√] 已允许在应用商店中查找关联应用
    )
    goto :EOF
)

:: 3.关闭商店应用推广
if %option% equ 3 (
    if %opt3_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭商店应用推广
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /f >nul
        echo [√] 已启用商店应用推广
    )
    goto :EOF
)

:: 4.关闭锁屏时的Windows聚焦推广
if %option% equ 4 (
    if %opt4_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭锁屏时的Windows聚焦推广
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /f >nul
        echo [√] 已启用锁屏时的Windows聚焦推广
    )
    goto :EOF
)

:: 5.关闭"使用Windows时获取技巧和建议"
if %option% equ 5 (
    if %opt5_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭"使用Windows时获取技巧和建议"
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /f >nul
        echo [√] 已启用"使用Windows时获取技巧和建议"
    )
    goto :EOF
)

:: 6.禁止自动安装推荐的应用程序
if %option% equ 6 (
    if %opt6_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
        echo [√] 已禁止自动安装推荐的应用程序
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /f >nul
        echo [√] 已允许自动安装推荐的应用程序
    )
    goto :EOF
)

:: 7.关闭游戏录制工具
if %option% equ 7 (
    if %opt7_status% equ 0 (
        reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭游戏录制工具
    ) else (
        reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /f >nul
        echo [√] 已启用游戏录制工具
    )
    goto :EOF
)

:: 8.关闭多嘴的小娜
if %option% equ 8 (
    if %opt8_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭多嘴的小娜
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul
        echo [√] 已启用多嘴的小娜
    )
    goto :EOF
)

:: 9.加快关机速度
if %option% equ 9 (
    if %opt9_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f >nul
        echo [√] 已加快关机速度
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /f >nul
        echo [√] 已恢复默认关机速度
    )
    goto :EOF
)

:: 10.缩短关闭服务等待时间
if %option% equ 10 (
    if %opt10_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /t REG_DWORD /d 2000 /f >nul
        echo [√] 已缩短关闭服务等待时间
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /f >nul
        echo [√] 已恢复默认服务关闭等待时间
    )
    goto :EOF
)

:: 11.禁用程序兼容性助手
if %option% equ 11 (
    if %opt11_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
        echo [√] 已禁用程序兼容性助手
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "PcaSvc" >nul 2>&1
        echo [√] 已启用程序兼容性助手
    )
    goto :EOF
)

:: 12.禁用远程修改注册表
if %option% equ 12 (
    if %opt12_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用远程修改注册表
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /f >nul
        echo [√] 已启用远程修改注册表
    )
    goto :EOF
)

:: 13.禁用诊断服务
if %option% equ 13 (
    if %opt13_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
        echo [√] 已禁用诊断服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "DPS" >nul 2>&1
        echo [√] 已启用诊断服务
    )
    goto :EOF
)

:: 14.禁用SysMain
if %option% equ 14 (
    if %opt14_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
        echo [√] 已禁用SysMain
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SysMain" >nul 2>&1
        echo [√] 已启用SysMain
    )
    goto :EOF
)

:: 15.禁用Windows Search
if %option% equ 15 (
    if %opt15_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
        echo [√] 已禁用Windows Search
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WSearch" >nul 2>&1
        echo [√] 已启用Windows Search
    )
    goto :EOF
)

:: 16.禁用错误报告
if %option% equ 16 (
    if %opt16_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用错误报告
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul
        echo [√] 已启用错误报告
    )
    goto :EOF
)

:: 17.禁用客户体验改善计划
if %option% equ 17 (
    if %opt17_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用客户体验改善计划
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul
        echo [√] 已启用客户体验改善计划
    )
    goto :EOF
)

:: 18.禁用NTFS链接跟踪服务
if %option% equ 18 (
    if %opt18_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
        echo [√] 已禁用NTFS链接跟踪服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "TrkWks" >nul 2>&1
        echo [√] 已启用NTFS链接跟踪服务
    )
    goto :EOF
)

:: 19.禁止自动维护计划
if %option% equ 19 (
    if %opt19_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁止自动维护计划
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f >nul
        echo [√] 已启用自动维护计划
    )
    goto :EOF
)

:: 20.启用大系统缓存以提高性能
if %option% equ 20 (
    if %opt20_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用大系统缓存以提高性能
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用大系统缓存
    )
    goto :EOF
)

:: 21.禁止系统内核与驱动程序分页到硬盘
if %option% equ 21 (
    if %opt21_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁止系统内核与驱动程序分页到硬盘
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 0 /f >nul
        echo [√] 已允许系统内核与驱动程序分页到硬盘
    )
    goto :EOF
)

:: 22.将文件管理系统缓存增加至256MB
if %option% equ 22 (
    if %opt22_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 4194304 /f >nul
        echo [√] 已将文件管理系统缓存增加至256MB
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /f >nul
        echo [√] 已恢复默认文件管理系统缓存大小
    )
    goto :EOF
)

:: 23.将Windows预读调整为关闭预读
if %option% equ 23 (
    if %opt23_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭Windows预读功能
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 3 /f >nul
        echo [√] 已启用Windows预读功能
    )
    goto :EOF
)

:: 24.禁用处理器的幽灵和熔断补丁
if %option% equ 24 (
    if %opt24_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul
        echo [√] 已禁用处理器的幽灵和熔断补丁以提高性能
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /f >nul
        echo [√] 已启用处理器的幽灵和熔断补丁
    )
    goto :EOF
)

:: 25.VHD启动时节省磁盘空间
if %option% equ 25 (
    if %opt25_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d 4 /f >nul
        echo [√] VHD启动时已节省磁盘空间
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /f >nul
        echo [√] 已恢复VHD启动默认设置
    )
    goto :EOF
)

:: 26.关闭系统自动调试功能
if %option% equ 26 (
    if %opt26_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭系统自动调试功能
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用系统自动调试功能
    )
    goto :EOF
)

:: 27.将磁盘错误检查等待时间缩短到五秒
if %option% equ 27 (
    if %opt27_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /t REG_DWORD /d 5 /f >nul
        echo [√] 已将磁盘错误检查等待时间缩短到五秒
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /f >nul
        echo [√] 已恢复默认磁盘错误检查等待时间
    )
    goto :EOF
)

:: 28.设备安装禁止创建系统还原点
if %option% equ 28 (
    if %opt28_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /t REG_DWORD /d 1 /f >nul
        echo [√] 设备安装已禁止创建系统还原点
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /f >nul
        echo [√] 设备安装已允许创建系统还原点
    )
    goto :EOF
)

:: 29.弹出USB磁盘后彻底断开电源
if %option% equ 29 (
    if %opt29_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /t REG_DWORD /d 0 /f >nul
        echo [√] 弹出USB磁盘后已彻底断开电源
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /f >nul
        echo [√] 已恢复USB磁盘默认电源设置
    )
    goto :EOF
)

:: 30.关闭快速启动
if %option% equ 30 (
    if %opt30_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭快速启动
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /f >nul
        echo [√] 已启用快速启动
    )
    goto :EOF
)

:: 31.关闭休眠
if %option% equ 31 (
    if %opt31_status% equ 0 (
        powercfg /h off >nul
        echo [√] 已关闭休眠
    ) else (
        powercfg /h on >nul
        echo [√] 已启用休眠
    )
    goto :EOF
)

:: 32.根据语言设置隐藏字体
if %option% equ 32 (
    if %opt32_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /t REG_SZ /d "10000000000000000000000000000000" /f >nul
        echo [√] 已根据语言设置隐藏字体
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /f >nul
        echo [√] 已显示所有字体
    )
    goto :EOF
)

:: 33.微软拼音输入法关闭云计算
if %option% equ 33 (
    if %opt33_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /t REG_DWORD /d 0 /f >nul
        echo [√] 微软拼音输入法已关闭云计算
    ) else (
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /f >nul
        echo [√] 微软拼音输入法已启用云计算
    )
    goto :EOF
)

:: 34.禁用内容传递优化服务
if %option% equ 34 (
    if %opt34_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用内容传递优化服务
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /f >nul
        echo [√] 已启用内容传递优化服务
    )
    goto :EOF
)

:: 35.禁用功能更新安全措施
if %option% equ 35 (
    if %opt35_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用功能更新安全措施
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /f >nul
        echo [√] 已启用功能更新安全措施
    )
    goto :EOF
)

:: 36.禁用蓝屏后自动重启
if %option% equ 36 (
    if %opt36_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用蓝屏后自动重启
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /f >nul
        echo [√] 已启用蓝屏后自动重启
    )
    goto :EOF
)

:: 37.禁用Installer detection
if %option% equ 37 (
    if %opt37_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Installer detection
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /f >nul
        echo [√] 已启用Installer detection
    )
    goto :EOF
)

:: 38禁用上下文菜单显示延迟
if %option% equ 38 (
    if %opt38_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
        echo [√] 已禁用上下文菜单显示延迟
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "400" /f >nul
        echo [√] 已启用上下文菜单显示延迟
    )
    goto :EOF
)

:: 39.禁用保留空间
if %option% equ 39 (
    if %opt39_status% equ 0 (
        DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
        echo [√] 已禁用保留空间
    ) else (
        DISM.exe /Online /Set-ReservedStorageState /State:Enabled >nul 2>&1
        echo [√] 已启用保留空间
    )
    goto :EOF
)

:: 40.启用硬件加速GPU计划
if %option% equ 40 (
    if %opt40_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul
        echo [√] 已启用硬件加速GPU计划
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f >nul
        echo [√] 已禁用硬件加速GPU计划
    )
    goto :EOF
)

:: 41.优化处理器性能和内存设置
if %option% equ 41 (
    if %opt41_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d 2 /f >nul
        echo [√] 已优化处理器性能和内存设置
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /f >nul
        echo [√] 已恢复默认处理器性能和内存设置
    )
    goto :EOF
)

:: 42.降低Cortana性能减少CPU占用
if %option% equ 42 (
    if %opt42_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
        echo [√] 已降低Cortana性能，减少CPU占用
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul
        echo [√] 已恢复Cortana默认性能
    )
    goto :EOF
)

:: 43.关闭Exploit Protection
if %option% equ 43 (
    if %opt43_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /t REG_BINARY /d 22222200000200000002000000000000 /f >nul
        echo [√] 已关闭Exploit Protection
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /f >nul
        echo [√] 已启用Exploit Protection
    )
    goto :EOF
)

:: 44.关闭广告ID
if %option% equ 44 (
    if %opt44_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul
        echo [√] 已关闭广告ID
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /f >nul
        echo [√] 已启用广告ID
    )
    goto :EOF
)

:: 45.关闭应用启动跟踪
if %option% equ 45 (
    if %opt45_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭应用启动跟踪
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul
        echo [√] 已启用应用启动跟踪
    )
    goto :EOF
)

:: 46.去除搜索页面信息流和热搜
if %option% equ 46 (
    if %opt46_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
        echo [√] 已去除搜索页面信息流和热搜
    ) else (
        reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /f >nul
        echo [√] 已恢复搜索页面信息流和热搜
    )
    goto :EOF
)

:: 47.关闭TSX漏洞补丁
if %option% equ 47 (
    if %opt47_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /t REG_DWORD /d 1 /f >nul
        echo [√] 已关闭TSX漏洞补丁
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /f >nul
        echo [√] 已启用TSX漏洞补丁
    )
    goto :EOF
)

:: 48.优化进程数量
if %option% equ 48 (
    if %opt48_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_SZ /d "ffffffff" /f >nul
        echo [√] 已优化进程数量
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /f >nul
        echo [√] 已恢复默认进程数量设置
    )
    goto :EOF
)

:: 49.关闭诊断策略服务
if %option% equ 49 (
    if %opt49_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
        echo [√] 已关闭诊断策略服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "DPS" >nul 2>&1
        echo [√] 已启用诊断策略服务
    )
    goto :EOF
)

:: 50.关闭程序兼容性助手
if %option% equ 50 (
    if %opt50_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
        echo [√] 已关闭程序兼容性助手
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "PcaSvc" >nul 2>&1
        echo [√] 已启用程序兼容性助手
    )
    goto :EOF
)

:: 51.关闭微软客户体验改进计划
if %option% equ 51 (
    if %opt51_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭微软客户体验改进计划
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul
        echo [√] 已启用微软客户体验改进计划
    )
    goto :EOF
)

:: 52.禁用交付优化
if %option% equ 52 (
    if %opt52_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用交付优化
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /f >nul
        echo [√] 已启用交付优化
    )
    goto :EOF
)

:: 53.禁用高精度事件定时器(HPET)
if %option% equ 53 (
    if %opt53_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /t REG_DWORD /d 4 /f >nul
        echo [√] 已禁用高精度事件定时器
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /f >nul
        echo [√] 已启用高精度事件定时器
    )
    goto :EOF
)

:: 54.禁用Game Bar
if %option% equ 54 (
    if %opt54_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Game Bar
    ) else (
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul
        echo [√] 已启用Game Bar
    )
    goto :EOF
)
endlocal
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - Edge优化设置
::-------------------------------------------------------------------------------------------
:Edge
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,14) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_OPT_Status

cls
echo.===============================================================================
echo.                    ZyperWin++ - Edge浏览器优化设置
echo.===============================================================================
echo. 状态标记: [+]已优化  [-]未优化
echo.
echo   [ 1] %opt1_mark% 禁用"首次运行"欢迎页面
echo   [ 2] %opt2_mark% 关闭Adobe Flash即点即用
echo   [ 3] %opt3_mark% 关闭后禁止继续运行后台应用
echo   [ 4] %opt4_mark% 阻止必应搜索结果中的所有广告
echo   [ 5] %opt5_mark% 禁用新选项卡页面上的微软资讯
echo   [ 6] %opt6_mark% 隐藏新标签页中的默认热门网站
echo   [ 7] %opt7_mark% 隐藏Edge浏览器边栏
echo   [ 8] %opt8_mark% 禁用Smartscreen筛选器
echo   [ 9] %opt9_mark% 禁止发送任何诊断数据
echo   [10] %opt10_mark% 禁用标签页性能检测器
echo   [11] %opt11_mark% 关闭停止支持旧系统的通知
echo   [12] %opt12_mark% 关闭Edge自启动
echo   [13] %opt13_mark% 启用效率模式
echo   [14] %opt14_mark% 关闭"由你的组织管理"提示
echo.
echo   [A] 应用所有未优化的项
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto Edge
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选（只选未优化的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,14) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有优化项已应用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_OPT %%c
)

:: 更新状态
for /l %%i in (1,1,14) do set "opt%%i_status=0"
call :Check_OPT_Status

echo.
echo 注意：部分设置需要重启Edge浏览器才能生效
echo.
pause
goto custom_optimize

:: 检测所有优化项状态的函数
:Check_OPT_Status
:: 1.禁用"首次运行"欢迎页面
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")

:: 2.关闭Adobe Flash即点即用
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.关闭后禁止继续运行后台应用
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.阻止必应搜索结果中的所有广告
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" 2>nul | findstr /i "0x2" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.禁用新选项卡页面上的微软资讯
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.隐藏新标签页中的默认热门网站
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.隐藏Edge浏览器边栏
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.禁用Smartscreen筛选器
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (
    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" 2>nul | findstr /i "0x0" >nul
    if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")
) else (set "opt8_mark=[-]")

:: 9.禁止发送任何诊断数据
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.禁用标签页性能检测器
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.关闭停止支持旧系统的通知
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")

:: 12.关闭Edge自启动
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.启用效率模式
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (
    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" 2>nul | findstr /i "0x2" >nul
    if %errorlevel% equ 0 (
        reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" 2>nul | findstr /i "0x1" >nul
        if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")
    ) else (set "opt13_mark=[-]")
) else (set "opt13_mark=[-]")

:: 14.关闭"由你的组织管理"提示
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")
goto :eof

:: 切换优化状态的函数
:Toggle_OPT
setlocal
set option=%1

:: 1.禁用"首次运行"欢迎页面
if %option% equ 1 (
    if %opt1_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用"首次运行"欢迎页面
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用"首次运行"欢迎页面
    )
    goto :EOF
)

:: 2.关闭Adobe Flash即点即用
if %option% equ 2 (
    if %opt2_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭Adobe Flash即点即用
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "RunAllFlashInAllowMode" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Adobe Flash即点即用
    )
    goto :EOF
)

:: 3.关闭后禁止继续运行后台应用
if %option% equ 3 (
    if %opt3_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁止Edge关闭后继续运行后台应用
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已允许Edge关闭后继续运行后台应用
    )
    goto :EOF
)

:: 4.阻止必应搜索结果中的所有广告
if %option% equ 4 (
    if %opt4_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" /t REG_DWORD /d 2 /f >nul
        echo [√] 已阻止必应搜索结果中的所有广告
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AdsSettingForIntrusiveAdsSites" /t REG_DWORD /d 1 /f >nul
        echo [√] 已允许必应搜索结果中显示广告
    )
    goto :EOF
)

:: 5.禁用新选项卡页面上的微软资讯
if %option% equ 5 (
    if %opt5_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用新选项卡页面上的微软资讯内容
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用新选项卡页面上的微软资讯内容
    )
    goto :EOF
)

:: 6.隐藏新标签页中的默认热门网站
if %option% equ 6 (
    if %opt6_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d 1 /f >nul
        echo [√] 已隐藏新标签页中的默认热门网站
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d 0 /f >nul
        echo [√] 已显示新标签页中的默认热门网站
    )
    goto :EOF
)

:: 7.隐藏Edge浏览器边栏
if %option% equ 7 (
    if %opt7_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" /t REG_DWORD /d 0 /f >nul
        echo [√] 已隐藏Edge浏览器边栏
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "ShowSidebar" /t REG_DWORD /d 1 /f >nul
        echo [√] 已显示Edge浏览器边栏
    )
    goto :EOF
)

:: 8.禁用Smartscreen筛选器
if %option% equ 8 (
    if %opt8_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Smartscreen筛选器
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SmartScreenForTrustedDownloadsEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Smartscreen筛选器
    )
    goto :EOF
)

:: 9.禁止发送任何诊断数据
if %option% equ 9 (
    if %opt9_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁止发送任何诊断数据
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 1 /f >nul
        echo [√] 已允许发送诊断数据
    )
    goto :EOF
)

:: 10.禁用标签页性能检测器
if %option% equ 10 (
    if %opt10_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用标签页性能检测器
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PerformanceDetectorEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用标签页性能检测器
    )
    goto :EOF
)

:: 11.关闭停止支持旧系统的通知
if %option% equ 11 (
    if %opt11_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" /t REG_DWORD /d 1 /f >nul
        echo [√] 已关闭停止支持旧系统的通知
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SuppressUnsupportedOSWarning" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用停止支持旧系统的通知
    )
    goto :EOF
)

:: 12.关闭Edge自启动
if %option% equ 12 (
    if %opt12_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭Edge自启动
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Edge自启动
    )
    goto :EOF
)

:: 13.启用效率模式
if %option% equ 13 (
    if %opt13_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" /t REG_DWORD /d 2 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用效率模式
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyMode" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeOnPowerEnabled" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EfficiencyModeEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用效率模式
    )
    goto :EOF
)

:: 14.关闭"由你的组织管理"提示
if %option% equ 14 (
    if %opt14_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" /t REG_DWORD /d 1 /f >nul
        echo [√] 已关闭"由你的组织管理"提示
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "HideManagedBrowserWarning" /t REG_DWORD /d 0 /f >nul
        echo [√] 已显示"由你的组织管理"提示
    )
    goto :EOF
)
endlocal
goto :EOF

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 安全设置
::-------------------------------------------------------------------------------------------
:anquan
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,20) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_Status

cls
echo.===============================================================================
echo.                ZyperWin++ - 综合安全设置
echo.===============================================================================
echo. 状态标记: [+]已禁用/优化  [-]已启用/未优化
echo.
echo   [ 1] %opt1_mark% 禁用Defender总进程
echo   [ 2] %opt2_mark% 禁用LSA保护(RunAsPPL)
echo   [ 3] %opt3_mark% 禁用SmartScreen筛选器
echo   [ 4] %opt4_mark% 禁用Windows安全中心报告
echo   [ 5] %opt5_mark% 禁用驱动程序阻止列表
echo   [ 6] %opt6_mark% 禁用Edge浏览器SmartScreen
echo   [ 7] %opt7_mark% 禁用文件资源管理器SmartScreen
echo   [ 8] %opt8_mark% 禁用Microsoft Store应用SmartScreen
echo   [ 9] %opt9_mark% 禁用攻击面减少规则(ASR)
echo   [10] %opt10_mark% 禁用UAC(用户账户控制)
echo   [11] %opt11_mark% 禁用虚拟化安全(VBS)
echo   [12] %opt12_mark% 禁用凭证保护(Credential Guard)
echo   [13] %opt13_mark% 禁用受控文件夹访问
echo   [14] %opt14_mark% 禁用网络保护
echo   [15] %opt15_mark% 禁用AMSI
echo   [16] %opt16_mark% 禁用代码完整性
echo   [17] %opt17_mark% 关闭防火墙
echo   [18] %opt18_mark% 关闭默认共享
echo   [19] %opt19_mark% 关闭远程协助
echo   [20] %opt20_mark% 启用不安全的来宾登录
echo.
echo   [A] 应用所有未禁用的项
echo   [X] 返回主菜单
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto anquan
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选（只选未禁用的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,20) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有安全组件已禁用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_Option %%c
)

:: 更新状态
for /l %%i in (1,1,20) do set "opt%%i_status=0"
call :Check_Status

echo.
echo 注意：部分设置需要重启计算机才能完全生效
echo.
pause
goto anquan

:: 检测所有优化项状态的函数
:Check_Status
:: 1.禁用Defender总进程
sc query "wscsvc" | findstr /i "RUNNING" >nul
if %errorlevel% equ 0 (
    reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" 2>nul | findstr /i "0x4" >nul
    if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")
) else (
    set "opt1_status=1" & set "opt1_mark=[+]"
)

:: 2.禁用LSA保护(RunAsPPL)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "RunAsPPL" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.禁用SmartScreen筛选器
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.禁用Windows安全中心报告
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.禁用驱动程序阻止列表
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.禁用Edge浏览器SmartScreen
reg query "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.禁用文件资源管理器SmartScreen
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" 2>nul | findstr /i "off" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.禁用Microsoft Store应用SmartScreen
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")

:: 9.禁用攻击面减少规则(ASR)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR" /v "ExploitGuard_ASR_Rules" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.禁用UAC(用户账户控制)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.禁用虚拟化安全(VBS)
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (
    bcdedit /enum | findstr /i "hypervisorlaunchtype" | findstr /i "off" >nul
    if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")
) else (set "opt11_mark=[-]")

:: 12.禁用凭证保护(Credential Guard)
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.禁用受控文件夹访问
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")

:: 14.禁用网络保护
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")

:: 15.禁用AMSI
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt15_status=1" & set "opt15_mark=[+]") else (set "opt15_mark=[-]")

:: 16.禁用代码完整性
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt16_status=1" & set "opt16_mark=[+]") else (set "opt16_mark=[-]")

:: 17.关闭防火墙
netsh advfirewall show allprofiles state 2>nul | findstr /i "关闭" >nul
if %errorlevel% equ 0 (set "opt17_status=1" & set "opt17_mark=[+]") else (set "opt17_mark=[-]")

:: 18.关闭默认共享
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (
    reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" 2>nul | findstr /i "0x0" >nul
    if %errorlevel% equ 0 (set "opt18_status=1" & set "opt18_mark=[+]") else (set "opt18_mark=[-]")
) else (set "opt18_mark=[-]")

:: 19.关闭远程协助
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt19_status=1" & set "opt19_mark=[+]") else (set "opt19_mark=[-]")

:: 20.启用不安全的来宾登录
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt20_status=1" & set "opt20_mark=[+]") else (set "opt20_mark=[-]")
goto :eof

:: 切换优化状态的函数
:Toggle_Option
setlocal
set option=%1

:: 1.禁用Defender总进程
if %option% equ 1 (
    if %opt1_status% equ 0 (
        echo 请手动关闭Defender（Disable）
        "%~dp0Defender_Control.exe"
        pause
    ) else (
        echo 请手动打开Defender（Enable）
        "%~dp0Defender_Control.exe"
        pause
    )
    goto :EOF
)

:: 2.禁用LSA保护(RunAsPPL)
if %option% equ 2 (
    if %opt2_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "RunAsPPL" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPLBoot" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用LSA保护
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "RunAsPPL" /f >nul 2>&1
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPLBoot" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用LSA保护
    )
    goto :EOF
)

:: 3.禁用SmartScreen筛选器
if %option% equ 3 (
    if %opt3_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用SmartScreen筛选器
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
        echo [√] 已启用SmartScreen筛选器
    )
    goto :EOF
)

:: 4.禁用Windows安全中心报告
if %option% equ 4 (
    if %opt4_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /t REG_DWORD /d 0 /f >nul
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用Windows安全中心报告
    ) else (
        reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /f >nul 2>&1
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /f >nul 2>&1
        echo [√] 已启用Windows安全中心报告
    )
    goto :EOF
)

:: 5.禁用驱动程序阻止列表
if %option% equ 5 (
    if %opt5_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用驱动程序阻止列表
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用驱动程序阻止列表
    )
    goto :EOF
)

:: 6.禁用Edge浏览器SmartScreen
if %option% equ 6 (
    if %opt6_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Edge浏览器SmartScreen
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Edge浏览器SmartScreen
    )
    goto :EOF
)

:: 7.禁用文件资源管理器SmartScreen
if %option% equ 7 (
    if %opt7_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f >nul
        echo [√] 已禁用文件资源管理器SmartScreen
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "on" /f >nul
        echo [√] 已启用文件资源管理器SmartScreen
    )
    goto :EOF
)

:: 8.禁用Microsoft Store应用SmartScreen
if %option% equ 8 (
    if %opt8_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Microsoft Store应用SmartScreen
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Microsoft Store应用SmartScreen
    )
    goto :EOF
)

:: 9.禁用攻击面减少规则(ASR)
if %option% equ 9 (
    if %opt9_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR" /v "ExploitGuard_ASR_Rules" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用攻击面减少规则
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR" /v "ExploitGuard_ASR_Rules" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用攻击面减少规则
    )
    goto :EOF
)

:: 10.禁用UAC(用户账户控制)
if %option% equ 10 (
    if %opt10_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用UAC
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用UAC
    )
    goto :EOF
)

:: 11.禁用虚拟化安全(VBS)
if %option% equ 11 (
    if %opt11_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /t REG_DWORD /d 0 /f >nul
        bcdedit /set hypervisorlaunchtype off >nul 2>&1
        echo [√] 已禁用虚拟化安全
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /t REG_DWORD /d 1 /f >nul
        bcdedit /set hypervisorlaunchtype auto >nul 2>&1
        echo [√] 已启用虚拟化安全
    )
    goto :EOF
)

:: 12.禁用凭证保护(Credential Guard)
if %option% equ 12 (
    if %opt12_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用凭证保护
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用凭证保护
    )
    goto :EOF
)

:: 13.禁用受控文件夹访问
if %option% equ 13 (
    if %opt13_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用受控文件夹访问
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用受控文件夹访问
    )
    goto :EOF
)

:: 14.禁用网络保护
if %option% equ 14 (
    if %opt14_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用网络保护
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用网络保护
    )
    goto :EOF
)

:: 15.禁用AMSI
if %option% equ 15 (
    if %opt15_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用AMSI
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用AMSI
    )
    goto :EOF
)

:: 16.禁用代码完整性
if %option% equ 16 (
    if %opt16_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用代码完整性
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用代码完整性
    )
    goto :EOF
)

:: 17.关闭防火墙
if %option% equ 17 (
    if %opt17_status% equ 0 (
        netsh advfirewall set allprofiles state off >nul
        echo [√] 已关闭防火墙
    ) else (
        netsh advfirewall set allprofiles state on >nul
        echo [√] 已启用防火墙
    )
    goto :EOF
)

:: 18.关闭默认共享
if %option% equ 18 (
    if %opt18_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭默认共享
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 1 /f >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用默认共享
    )
    goto :EOF
)

:: 19.关闭远程协助
if %option% equ 19 (
    if %opt19_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
        echo [√] 已关闭远程协助
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用远程协助
    )
    goto :EOF
)

:: 20.启用不安全的来宾登录
if %option% equ 20 (
    if %opt20_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用不安全的来宾登录
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用不安全的来宾登录
    )
    goto :EOF
)
endlocal
goto :EOF


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 隐私设置
::-------------------------------------------------------------------------------------------
:yinsi
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,53) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_OPT_Status

:yinsi_menu
cls
echo.===============================================================================
echo.                    ZyperWin++ - 隐私设置优化
echo.===============================================================================
echo. 状态标记: [+]已优化  [-]未优化
echo.
echo   [ 1] %opt1_mark% 禁用页面预测功能
echo   [ 2] %opt2_mark% 禁用开始屏幕建议
echo   [ 3] %opt3_mark% 禁用活动收集
echo   [ 4] %opt4_mark% 禁用应用启动跟踪
echo   [ 5] %opt5_mark% 禁用广告标识符
echo   [ 6] %opt6_mark% 禁用应用访问文件系统
echo   [ 7] %opt7_mark% 禁用应用访问文档
echo   [ 8] %opt8_mark% 禁用应用访问日历
echo   [ 9] %opt9_mark% 禁用应用访问联系人
echo   [10] %opt10_mark% 禁用应用访问视频
echo   [11] %opt11_mark% 禁用网站语言跟踪
echo   [12] %opt12_mark% 禁用Windows欢迎体验
echo   [13] %opt13_mark% 禁用反馈频率
echo   [14] %opt14_mark% 禁用诊断数据收集
echo   [15] %opt15_mark% 禁用写作习惯跟踪
echo   [16] %opt16_mark% 禁用设置应用建议
echo   [17] %opt17_mark% 禁用Bing搜索结果
echo   [18] %opt18_mark% 禁用通讯录收集
echo   [19] %opt19_mark% 禁用键入文本收集
echo   [20] %opt20_mark% 禁用搜索历史
echo   [21] %opt21_mark% 禁用赞助商应用安装
echo   [22] %opt22_mark% 禁用自动连接热点
echo   [23] %opt23_mark% 禁用输入数据个性化
echo   [24] %opt24_mark% 禁用键入见解
echo   [25] %opt25_mark% 禁用预安装应用
echo   [26] %opt26_mark% 禁用.NET遥测
echo   [27] %opt27_mark% 禁用PowerShell遥测
echo   [28] %opt28_mark% 禁用遥测服务
echo   [29] %opt29_mark% 禁用错误报告(WER)
echo   [30] %opt30_mark% 禁用语音激活(Cortana)
echo   [31] %opt31_mark% 禁用位置服务
echo   [32] %opt32_mark% 禁用搜索数据收集
echo   [33] %opt33_mark% 禁用定向广告
echo   [34] %opt34_mark% 禁用Wi-Fi感知
echo   [35] %opt35_mark% 禁用步骤记录器
echo   [36] %opt36_mark% 禁用写入调试信息
echo   [37] %opt37_mark% 禁用应用访问账户信息
echo   [38] %opt38_mark% 禁用应用访问运动数据
echo   [39] %opt39_mark% 禁用应用访问电话
echo   [40] %opt40_mark% 禁用应用访问信任设备
echo   [41] %opt41_mark% 禁用应用访问同步
echo   [42] %opt42_mark% 禁用应用访问诊断信息
echo   [43] %opt43_mark% 禁用应用访问通话记录
echo   [44] %opt44_mark% 禁用应用访问电子邮件
echo   [45] %opt45_mark% 禁用应用访问任务
echo   [46] %opt46_mark% 禁用应用访问消息
echo   [47] %opt47_mark% 禁用组件堆栈日志
echo   [48] %opt48_mark% 禁用更新解压模块日志
echo   [49] %opt49_mark% 禁用错误报告日志
echo   [50] %opt50_mark% 禁用将事件写入系统日志
echo   [51] %opt51_mark% 禁用崩溃时写入调试信息
echo   [52] %opt52_mark% 禁用账户登录日志报告
echo   [53] %opt53_mark% 禁用WfpDiag.ETL日志
echo.
echo   [A] 应用所有未优化的项
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto yinsi
if /i "%choices%"=="X" goto custom_optimize

:: 处理全选（只选未优化的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,53) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有优化项已应用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_OPT %%c
)

:: 更新状态
for /l %%i in (1,1,53) do set "opt%%i_status=0"
call :Check_OPT_Status

echo.
echo 注意：部分设置需要重启资源管理器或计算机才能完全生效
echo.
pause
goto yinsi_menu

:: 检测所有优化项状态的函数
:Check_OPT_Status
:: 1.禁用页面预测功能
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")

:: 2.禁用开始屏幕建议
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.禁用活动收集
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.禁用应用启动跟踪
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.禁用广告标识符
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.禁用应用访问文件系统
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.禁用应用访问文档
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.禁用应用访问日历
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")

:: 9.禁用应用访问联系人
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.禁用应用访问视频
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.禁用网站语言跟踪
reg query "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")

:: 12.禁用Windows欢迎体验
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.禁用反馈频率
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")

:: 14.禁用诊断数据收集
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")

:: 15.禁用写作习惯跟踪
reg query "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt15_status=1" & set "opt15_mark=[+]") else (set "opt15_mark=[-]")

:: 16.禁用设置应用建议
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt16_status=1" & set "opt16_mark=[+]") else (set "opt16_mark=[-]")

:: 17.禁用Bing搜索结果
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt17_status=1" & set "opt17_mark=[+]") else (set "opt17_mark=[-]")

:: 18.禁用通讯录收集
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt18_status=1" & set "opt18_mark=[+]") else (set "opt18_mark=[-]")

:: 19.禁用键入文本收集
reg query "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt19_status=1" & set "opt19_mark=[+]") else (set "opt19_mark=[-]")

:: 20.禁用搜索历史
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt20_status=1" & set "opt20_mark=[+]") else (set "opt20_mark=[-]")

:: 21.禁用赞助商应用安装
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt21_status=1" & set "opt21_mark=[+]") else (set "opt21_mark=[-]")

:: 22.禁用自动连接热点
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt22_status=1" & set "opt22_mark=[+]") else (set "opt22_mark=[-]")

:: 23.禁用输入数据个性化
reg query "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt23_status=1" & set "opt23_mark=[+]") else (set "opt23_mark=[-]")

:: 24.禁用键入见解
reg query "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt24_status=1" & set "opt24_mark=[+]") else (set "opt24_mark=[-]")

:: 25.禁用预安装应用
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt25_status=1" & set "opt25_mark=[+]") else (set "opt25_mark=[-]")

:: 26.禁用.NET遥测
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt26_status=1" & set "opt26_mark=[+]") else (set "opt26_mark=[-]")

:: 27.禁用PowerShell遥测
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt27_status=1" & set "opt27_mark=[+]") else (set "opt27_mark=[-]")

:: 28.禁用遥测服务
sc query "DiagTrack" 2>nul | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt28_status=1" & set "opt28_mark=[+]") else (set "opt28_mark=[-]")

:: 29.禁用错误报告(WER)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt29_status=1" & set "opt29_mark=[+]") else (set "opt29_mark=[-]")

:: 30.禁用语音激活(Cortana)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" 2>nul | findstr /i "0x2" >nul
if %errorlevel% equ 0 (set "opt30_status=1" & set "opt30_mark=[+]") else (set "opt30_mark=[-]")

:: 31.禁用位置服务
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt31_status=1" & set "opt31_mark=[+]") else (set "opt31_mark=[-]")

:: 32.禁用搜索数据收集
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt32_status=1" & set "opt32_mark=[+]") else (set "opt32_mark=[-]")

:: 33.禁用定向广告
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt33_status=1" & set "opt33_mark=[+]") else (set "opt33_mark=[-]")

:: 34.禁用Wi-Fi感知
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt34_status=1" & set "opt34_mark=[+]") else (set "opt34_mark=[-]")

:: 35.禁用步骤记录器
reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt35_status=1" & set "opt35_mark=[+]") else (set "opt35_mark=[-]")

:: 36.禁用写入调试信息
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt36_status=1" & set "opt36_mark=[+]") else (set "opt36_mark=[-]")

:: 37.禁用应用访问账户信息
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt37_status=1" & set "opt37_mark=[+]") else (set "opt37_mark=[-]")

:: 38.禁用应用访问运动数据
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt38_status=1" & set "opt38_mark=[+]") else (set "opt38_mark=[-]")

:: 39.禁用应用访问电话
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt39_status=1" & set "opt39_mark=[+]") else (set "opt39_mark=[-]")

:: 40.禁用应用访问信任设备
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt40_status=1" & set "opt40_mark=[+]") else (set "opt40_mark=[-]")

:: 41.禁用应用访问同步
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt41_status=1" & set "opt41_mark=[+]") else (set "opt41_mark=[-]")

:: 42.禁用应用访问诊断信息
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt42_status=1" & set "opt42_mark=[+]") else (set "opt42_mark=[-]")

:: 43.禁用应用访问通话记录
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt43_status=1" & set "opt43_mark=[+]") else (set "opt43_mark=[-]")

:: 44.禁用应用访问电子邮件
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt44_status=1" & set "opt44_mark=[+]") else (set "opt44_mark=[-]")

:: 45.禁用应用访问任务
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt45_status=1" & set "opt45_mark=[+]") else (set "opt45_mark=[-]")

:: 46.禁用应用访问消息
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" 2>nul | findstr /i "Deny" >nul
if %errorlevel% equ 0 (set "opt46_status=1" & set "opt46_mark=[+]") else (set "opt46_mark=[-]")

:: 47.禁用组件堆栈日志
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt47_status=1" & set "opt47_mark=[+]") else (set "opt47_mark=[-]")

:: 48.禁用更新解压模块日志
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt48_status=1" & set "opt48_mark=[+]") else (set "opt48_mark=[-]")

:: 49.禁用错误报告日志
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt49_status=1" & set "opt49_mark=[+]") else (set "opt49_mark=[-]")

:: 50.禁用将事件写入系统日志
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt50_status=1" & set "opt50_mark=[+]") else (set "opt50_mark=[-]")

:: 51.禁用崩溃时写入调试信息
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt51_status=1" & set "opt51_mark=[+]") else (set "opt51_mark=[-]")

:: 52.禁用账户登录日志报告
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt52_status=1" & set "opt52_mark=[+]") else (set "opt52_mark=[-]")

:: 53.禁用WfpDiag.ETL日志
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt53_status=1" & set "opt53_mark=[+]") else (set "opt53_mark=[-]")
goto :eof


:: 切换优化状态的函数
:Toggle_OPT
setlocal
set option=%1

:: 1.禁用页面预测功能
if %option% equ 1 (
    if %opt1_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用页面预测功能
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用页面预测功能
    )
    goto :EOF
)

:: 2.禁用开始屏幕建议
if %option% equ 2 (
    if %opt2_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用开始屏幕建议
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用开始屏幕建议
    )
    goto :EOF
)

:: 3.禁用活动收集
if %option% equ 3 (
    if %opt3_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用活动收集
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用活动收集
    )
    goto :EOF
)

:: 4.禁用应用启动跟踪
if %option% equ 4 (
    if %opt4_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用应用启动跟踪
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用应用启动跟踪
    )
    goto :EOF
)

:: 5.禁用广告标识符
if %option% equ 5 (
    if %opt5_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用广告标识符
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用广告标识符
    )
    goto :EOF
)

:: 6.禁用应用访问文件系统
if %option% equ 6 (
    if %opt6_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问文件系统
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问文件系统
    )
    goto :EOF
)

:: 7.禁用应用访问文档
if %option% equ 7 (
    if %opt7_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问文档
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问文档
    )
    goto :EOF
)

:: 8.禁用应用访问日历
if %option% equ 8 (
    if %opt8_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问日历
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问日历
    )
    goto :EOF
)

:: 9.禁用应用访问联系人
if %option% equ 9 (
    if %opt9_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问联系人
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问联系人
    )
    goto :EOF
)

:: 10.禁用应用访问视频
if %option% equ 10 (
    if %opt10_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问视频
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问视频
    )
    goto :EOF
)

:: 11.禁用网站语言跟踪
if %option% equ 11 (
    if %opt11_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用网站语言跟踪
    ) else (
        reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用网站语言跟踪
    )
    goto :EOF
)

:: 12.禁用Windows欢迎体验
if %option% equ 12 (
    if %opt12_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用Windows欢迎体验
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用Windows欢迎体验
    )
    goto :EOF
)

:: 13.禁用反馈频率
if %option% equ 13 (
    if %opt13_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用反馈频率
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用反馈频率
    )
    goto :EOF
)

:: 14.禁用诊断数据收集
if %option% equ 14 (
    if %opt14_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用诊断数据收集
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f >nul
        echo [√] 已启用诊断数据收集
    )
    goto :EOF
)

:: 15.禁用写作习惯跟踪
if %option% equ 15 (
    if %opt15_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用写作习惯跟踪
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用写作习惯跟踪
    )
    goto :EOF
)

:: 16.禁用设置应用建议
if %option% equ 16 (
    if %opt16_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用设置应用建议
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用设置应用建议
    )
    goto :EOF
)

:: 17.禁用Bing搜索结果
if %option% equ 17 (
    if %opt17_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用Bing搜索结果
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用Bing搜索结果
    )
    goto :EOF
)

:: 18.禁用通讯录收集
if %option% equ 18 (
    if %opt18_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用通讯录收集
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用通讯录收集
    )
    goto :EOF
)

:: 19.禁用键入文本收集
if %option% equ 19 (
    if %opt19_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用键入文本收集
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用键入文本收集
    )
    goto :EOF
)

:: 20.禁用搜索历史
if %option% equ 20 (
    if %opt20_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用搜索历史
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用搜索历史
    )
    goto :EOF
)

:: 21.禁用赞助商应用安装
if %option% equ 21 (
    if %opt21_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用赞助商应用安装
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用赞助商应用安装
    )
    goto :EOF
)

:: 22.禁用自动连接热点
if %option% equ 22 (
    if %opt22_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用自动连接热点
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用自动连接热点
    )
    goto :EOF
)

:: 23.禁用输入数据个性化
if %option% equ 23 (
    if %opt23_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用输入数据个性化
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用输入数据个性化
    )
    goto :EOF
)

:: 24.禁用键入见解
if %option% equ 24 (
    if %opt24_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用键入见解
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用键入见解
    )
    goto :EOF
)

:: 25.禁用预安装应用
if %option% equ 25 (
    if %opt25_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用预安装应用
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用预安装应用
    )
    goto :EOF
)

:: 26.禁用.NET遥测
if %option% equ 26 (
    if %opt26_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用.NET遥测
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用.NET遥测
    )
    goto :EOF
)

:: 27.禁用PowerShell遥测
if %option% equ 27 (
    if %opt27_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用PowerShell遥测
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用PowerShell遥测
    )
    goto :EOF
)

:: 28.禁用遥测服务
if %option% equ 28 (
    if %opt28_status% equ 0 (
        sc config "DiagTrack" start= disabled >nul
        sc stop "DiagTrack" >nul
        echo [√] 已禁用遥测服务
    ) else (
        sc config "DiagTrack" start= delayed-auto >nul
        sc start "DiagTrack" >nul
        echo [√] 已启用遥测服务
    )
    goto :EOF
)

:: 29.禁用错误报告(WER)
if %option% equ 29 (
    if %opt29_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用错误报告
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用错误报告
    )
    goto :EOF
)

:: 30.禁用语音激活(Cortana)
if %option% equ 30 (
    if %opt30_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f >nul
        echo [√] 已禁用语音激活
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用语音激活
    )
    goto :EOF
)

:: 31.禁用位置服务
if %option% equ 31 (
    if %opt31_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用位置服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用位置服务
    )
    goto :EOF
)

:: 32.禁用搜索数据收集
if %option% equ 32 (
    if %opt32_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用搜索数据收集
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用搜索数据收集
    )
    goto :EOF
)

:: 33.禁用定向广告
if %option% equ 33 (
    if %opt33_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用定向广告
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用定向广告
    )
    goto :EOF
)

:: 34.禁用Wi-Fi感知
if %option% equ 34 (
    if %opt34_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用Wi-Fi感知
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用Wi-Fi感知
    )
    goto :EOF
)

:: 35.禁用步骤记录器
if %option% equ 35 (
    if %opt35_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用步骤记录器
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用步骤记录器
    )
    goto :EOF
)

:: 36.禁用写入调试信息
if %option% equ 36 (
    if %opt36_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用写入调试信息
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /t REG_DWORD /d 0xf /f >nul
        echo [√] 已启用写入调试信息
    )
    goto :EOF
)

:: 37.禁用应用访问账户信息
if %option% equ 37 (
    if %opt37_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问账户信息
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问账户信息
    )
    goto :EOF
)

:: 38.禁用应用访问运动数据
if %option% equ 38 (
    if %opt38_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问运动数据
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问运动数据
    )
    goto :EOF
)

:: 39.禁用应用访问电话
if %option% equ 39 (
    if %opt39_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问电话
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问电话
    )
    goto :EOF
)

:: 40.禁用应用访问信任设备
if %option% equ 40 (
    if %opt40_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问信任设备
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问信任设备
    )
    goto :EOF
)

:: 41.禁用应用访问同步
if %option% equ 41 (
    if %opt41_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问同步
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问同步
    )
    goto :EOF
)

:: 42.禁用应用访问诊断信息
if %option% equ 42 (
    if %opt42_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问诊断信息
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问诊断信息
    )
    goto :EOF
)

:: 43.禁用应用访问通话记录
if %option% equ 43 (
    if %opt43_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问通话记录
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问通话记录
    )
    goto :EOF
)

:: 44.禁用应用访问电子邮件
if %option% equ 44 (
    if %opt44_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问电子邮件
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问电子邮件
    )
    goto :EOF
)

:: 45.禁用应用访问任务
if %option% equ 45 (
    if %opt45_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问任务
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问任务
    )
    goto :EOF
)

:: 46.禁用应用访问消息
if %option% equ 46 (
    if %opt46_status% equ 0 (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" /t REG_SZ /d "Deny" /f >nul
        echo [√] 已禁用应用访问消息
    ) else (
        reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /v "Value" /t REG_SZ /d "Allow" /f >nul
        echo [√] 已启用应用访问消息
    )
    goto :EOF
)

:: 47.禁用组件堆栈日志
if %option% equ 47 (
    if %opt47_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用组件堆栈日志
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用组件堆栈日志
    )
    goto :EOF
)

:: 48.禁用更新解压模块日志
if %option% equ 48 (
    if %opt48_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用更新解压模块日志
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用更新解压模块日志
    )
    goto :EOF
)

:: 49.禁用错误报告日志
if %option% equ 49 (
    if %opt49_status% equ 0 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用错误报告日志
    ) else (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用错误报告日志
    )
    goto :EOF
)

:: 50.禁用将事件写入系统日志
if %option% equ 50 (
    if %opt50_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用将事件写入系统日志
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用将事件写入系统日志
    )
    goto :EOF
)

:: 51.禁用崩溃时写入调试信息
if %option% equ 51 (
    if %opt51_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用崩溃时写入调试信息
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用崩溃时写入调试信息
    )
    goto :EOF
)

:: 52.禁用账户登录日志报告
if %option% equ 52 (
    if %opt52_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁用账户登录日志报告
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /t REG_DWORD /d 0 /f >nul
        echo [√] 已启用账户登录日志报告
    )
    goto :EOF
)

:: 53.禁用WfpDiag.ETL日志
if %option% equ 53 (
    if %opt53_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用WfpDiag.ETL日志
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /t REG_DWORD /d 1 /f >nul
        echo [√] 已启用WfpDiag.ETL日志
    )
    goto :EOF
)

endlocal
goto :EOF



::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 服务项优化
::-------------------------------------------------------------------------------------------
:fuwuxiang
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,19) do set "opt%%i_status=0"

:: 检测所有服务状态
call :Check_Service_Status

cls
echo.===============================================================================
echo.                    ZyperWin++ - 服务项优化
echo.===============================================================================
echo. 状态标记: [+]已禁用  [=]手动  [-]已启用
echo.
echo   [ 1] %opt1_mark% SecurityHealthService (安全健康服务)
echo   [ 2] %opt2_mark% SysMain (SuperFetch服务)
echo   [ 3] %opt3_mark% WSearch (Windows搜索服务)
echo   [ 4] %opt4_mark% UsoSvc (Windows更新服务)
echo   [ 5] %opt5_mark% TrkWks (分布式链接跟踪服务)
echo   [ 6] %opt6_mark% WinDefend (Windows Defender服务)
echo   [ 7] %opt7_mark% diagsvc (诊断服务)
echo   [ 8] %opt8_mark% DPS (诊断策略服务)
echo   [ 9] %opt9_mark% WdiServiceHost (诊断服务主机)
echo   [10] %opt10_mark% WdiSystemHost (诊断系统主机)
echo   [11] %opt11_mark% MapsBroker (地图服务)
echo   [12] %opt12_mark% iphlpsvc (IP助手服务)
echo   [13] %opt13_mark% diagnosticshub.standardcollector.service (诊断中心收集器)
echo   [14] %opt14_mark% SmsRouter (SMS路由器服务)
echo   [15] %opt15_mark% PcaSvc (程序兼容性助手)
echo   [16] %opt16_mark% ShellHWDetection (Shell硬件检测)
echo   [17] %opt17_mark% SgrmBroker (系统防护服务)
echo   [18] %opt18_mark% Schedule (任务计划服务)
echo   [19] %opt19_mark% Wecsvc (Windows事件收集服务)
echo.
echo   [A] 禁用所有非必要服务
echo   [R] 恢复所有服务默认设置
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto fuwuxiang
if /i "%choices%"=="X" goto custom_optimize
if /i "%choices%"=="R" goto RESTORE_DEFAULT

:: 处理全选（禁用所有非必要服务）
if /i "%choices%"=="A" (
    set "choices=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19"
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_Service %%c
)

:: 更新状态
for /l %%i in (1,1,19) do set "opt%%i_status=0"
call :Check_Service_Status

echo.
echo 服务项优化已完成!
echo 注意：部分设置需要重启系统才能完全生效
echo.
pause
goto fuwuxiang

:: 检测所有服务状态的函数
:Check_Service_Status
:: 1.SecurityHealthService (安全健康服务)
sc query "SecurityHealthService" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt20_status=1" & set "opt20_mark=[+]") else (set "opt20_mark=[-]")
goto :eof

:: 2.SysMain (SuperFetch服务)
sc query "SysMain" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.WSearch (Windows搜索服务)
sc query "WSearch" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.UsoSvc (Windows更新服务)
sc query "UsoSvc" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.TrkWks (分布式链接跟踪服务)
sc query "TrkWks" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")

:: 6.WinDefend (Windows Defender服务)
sc query "WinDefend" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt6_status=1" & set "opt6_mark=[+]") else (set "opt6_mark=[-]")

:: 7.diagsvc (诊断服务)
sc query "diagsvc" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt7_status=1" & set "opt7_mark=[+]") else (set "opt7_mark=[-]")

:: 8.DPS (诊断策略服务)
sc query "DPS" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt8_status=1" & set "opt8_mark=[+]") else (set "opt8_mark=[-]")

:: 9.WdiServiceHost (诊断服务主机)
sc query "WdiServiceHost" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt9_status=1" & set "opt9_mark=[+]") else (set "opt9_mark=[-]")

:: 10.WdiSystemHost (诊断系统主机)
sc query "WdiSystemHost" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt10_status=1" & set "opt10_mark=[+]") else (set "opt10_mark=[-]")

:: 11.MapsBroker (地图服务)
sc query "MapsBroker" | findstr /i "DEMAND_START" >nul
if %errorlevel% equ 0 (set "opt11_status=2" & set "opt11_mark=[=]") else (
    sc query "MapsBroker" | findstr /i "STOPPED" >nul
    if %errorlevel% equ 0 (set "opt11_status=1" & set "opt11_mark=[+]") else (set "opt11_mark=[-]")
)

:: 12.iphlpsvc (IP助手服务)
sc query "iphlpsvc" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt12_status=1" & set "opt12_mark=[+]") else (set "opt12_mark=[-]")

:: 13.diagnosticshub.standardcollector.service (诊断中心收集器)
sc query "diagnosticshub.standardcollector.service" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt13_status=1" & set "opt13_mark=[+]") else (set "opt13_mark=[-]")

:: 14.SmsRouter (SMS路由器服务)
sc query "SmsRouter" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt14_status=1" & set "opt14_mark=[+]") else (set "opt14_mark=[-]")

:: 15.PcaSvc (程序兼容性助手)
sc query "PcaSvc" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt15_status=1" & set "opt15_mark=[+]") else (set "opt15_mark=[-]")

:: 16.ShellHWDetection (Shell硬件检测)
sc query "ShellHWDetection" | findstr /i "DEMAND_START" >nul
if %errorlevel% equ 0 (set "opt16_status=2" & set "opt16_mark=[=]") else (
    sc query "ShellHWDetection" | findstr /i "STOPPED" >nul
    if %errorlevel% equ 0 (set "opt16_status=1" & set "opt16_mark=[+]") else (set "opt16_mark=[-]")
)

:: 17.SgrmBroker (系统防护服务)
sc query "SgrmBroker" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt17_status=1" & set "opt17_mark=[+]") else (set "opt17_mark=[-]")

:: 18.Schedule (任务计划服务)
sc query "Schedule" | findstr /i "DEMAND_START" >nul
if %errorlevel% equ 0 (set "opt18_status=2" & set "opt18_mark=[=]") else (
    sc query "Schedule" | findstr /i "STOPPED" >nul
    if %errorlevel% equ 0 (set "opt18_status=1" & set "opt18_mark=[+]") else (set "opt18_mark=[-]")
)

:: 19.Wecsvc (Windows事件收集服务)
sc query "Wecsvc" | findstr /i "STOPPED" >nul
if %errorlevel% equ 0 (set "opt19_status=1" & set "opt19_mark=[+]") else (set "opt19_mark=[-]")

:: 切换服务状态的函数
:Toggle_Service
setlocal
set option=%1

:: 1.SecurityHealthService (安全健康服务)
if %option% equ 1 (
    if %opt1_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SecurityHealthService" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SecurityHealthService" >nul 2>&1
        echo [√] 已禁用: SecurityHealthService 安全健康服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SecurityHealthService" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SecurityHealthService" >nul 2>&1
        echo [√] 已启用: SecurityHealthService 安全健康服务
    )
    goto :EOF
)

:: 2.SysMain (SuperFetch服务)
if %option% equ 2 (
    if %opt2_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SysMain" >nul 2>&1
        echo [√] 已禁用: SysMain SuperFetch服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SysMain" >nul 2>&1
        echo [√] 已启用: SysMain SuperFetch服务
    )
    goto :EOF
)

:: 3.WSearch (Windows搜索服务)
if %option% equ 3 (
    if %opt3_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WSearch" >nul 2>&1
        echo [√] 已禁用: WSearch Windows搜索服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WSearch" >nul 2>&1
        echo [√] 已启用: WSearch Windows搜索服务
    )
    goto :EOF
)

:: 4.UsoSvc (Windows更新服务)
if %option% equ 4 (
    if %opt4_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "UsoSvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "UsoSvc" >nul 2>&1
        echo [√] 已禁用: UsoSvc Windows更新服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "UsoSvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "UsoSvc" >nul 2>&1
        echo [√] 已启用: UsoSvc Windows更新服务
    )
    goto :EOF
)

:: 5.TrkWks (分布式链接跟踪服务)
if %option% equ 5 (
    if %opt5_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "TrkWks" >nul 2>&1
        echo [√] 已禁用: TrkWks 分布式链接跟踪服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "TrkWks" >nul 2>&1
        echo [√] 已启用: TrkWks 分布式链接跟踪服务
    )
    goto :EOF
)

:: 6.WinDefend (Windows Defender服务)
if %option% equ 6 (
    if %opt6_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WinDefend" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WinDefend" >nul 2>&1
        echo [√] 已禁用: WinDefend Windows Defender服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WinDefend" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WinDefend" >nul 2>&1
        echo [√] 已启用: WinDefend Windows Defender服务
    )
    goto :EOF
)

:: 7.diagsvc (诊断服务)
if %option% equ 7 (
    if %opt7_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagsvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagsvc" >nul 2>&1
        echo [√] 已禁用: diagsvc 诊断服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagsvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "diagsvc" >nul 2>&1
        echo [√] 已启用: diagsvc 诊断服务
    )
    goto :EOF
)

:: 8.DPS (诊断策略服务)
if %option% equ 8 (
    if %opt8_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "DPS" >nul 2>&1
        echo [√] 已禁用: DPS 诊断策略服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "DPS" >nul 2>&1
        echo [√] 已启用: DPS 诊断策略服务
    )
    goto :EOF
)

:: 9.WdiServiceHost (诊断服务主机)
if %option% equ 9 (
    if %opt9_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiServiceHost" >nul 2>&1
        echo [√] 已禁用: WdiServiceHost 诊断服务主机
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WdiServiceHost" >nul 2>&1
        echo [√] 已启用: WdiServiceHost 诊断服务主机
    )
    goto :EOF
)

:: 10.WdiSystemHost (诊断系统主机)
if %option% equ 10 (
    if %opt10_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "WdiSystemHost" >nul 2>&1
        echo [√] 已禁用: WdiSystemHost 诊断系统主机
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WdiSystemHost" >nul 2>&1
        echo [√] 已启用: WdiSystemHost 诊断系统主机
    )
    goto :EOF
)

:: 11.MapsBroker (地图服务)
if %option% equ 11 (
    if %opt11_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= demand >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "MapsBroker" >nul 2>&1
        echo [√] 已设置手动: MapsBroker 地图服务
    ) else if %opt11_status% equ 1 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "MapsBroker" >nul 2>&1
        echo [√] 已设置自动: MapsBroker 地图服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "MapsBroker" >nul 2>&1
        echo [√] 已禁用: MapsBroker 地图服务
    )
    goto :EOF
)

:: 12.iphlpsvc (IP助手服务)
if %option% equ 12 (
    if %opt12_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "iphlpsvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "iphlpsvc" >nul 2>&1
        echo [√] 已禁用: iphlpsvc IP助手服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "iphlpsvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "iphlpsvc" >nul 2>&1
        echo [√] 已启用: iphlpsvc IP助手服务
    )
    goto :EOF
)

:: 13.diagnosticshub.standardcollector.service (诊断中心收集器)
if %option% equ 13 (
    if %opt13_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "diagnosticshub.standardcollector.service" >nul 2>&1
        echo [√] 已禁用: diagnosticshub.standardcollector.service 诊断中心收集器
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "diagnosticshub.standardcollector.service" >nul 2>&1
        echo [√] 已启用: diagnosticshub.standardcollector.service 诊断中心收集器
    )
    goto :EOF
)

:: 14.SmsRouter (SMS路由器服务)
if %option% equ 14 (
    if %opt14_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SmsRouter" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SmsRouter" >nul 2>&1
        echo [√] 已禁用: SmsRouter SMS路由器服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SmsRouter" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SmsRouter" >nul 2>&1
        echo [√] 已启用: SmsRouter SMS路由器服务
    )
    goto :EOF
)

:: 15.PcaSvc (程序兼容性助手)
if %option% equ 15 (
    if %opt15_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "PcaSvc" >nul 2>&1
        echo [√] 已禁用: PcaSvc 程序兼容性助手
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "PcaSvc" >nul 2>&1
        echo [√] 已启用: PcaSvc 程序兼容性助手
    )
    goto :EOF
)

:: 16.ShellHWDetection (Shell硬件检测)
if %option% equ 16 (
    if %opt16_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= demand >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "ShellHWDetection" >nul 2>&1
        echo [√] 已设置手动: ShellHWDetection Shell硬件检测
    ) else if %opt16_status% equ 1 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "ShellHWDetection" >nul 2>&1
        echo [√] 已设置自动: ShellHWDetection Shell硬件检测
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "ShellHWDetection" >nul 2>&1
        echo [√] 已禁用: ShellHWDetection Shell硬件检测
    )
    goto :EOF
)

:: 17.SgrmBroker (系统防护服务)
if %option% equ 17 (
    if %opt17_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SgrmBroker" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "SgrmBroker" >nul 2>&1
        echo [√] 已禁用: SgrmBroker 系统防护服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SgrmBroker" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SgrmBroker" >nul 2>&1
        echo [√] 已启用: SgrmBroker 系统防护服务
    )
    goto :EOF
)

:: 18.Schedule (任务计划服务)
if %option% equ 18 (
    if %opt18_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= demand >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Schedule" >nul 2>&1
        echo [√] 已设置手动: Schedule 任务计划服务
    ) else if %opt18_status% equ 1 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "Schedule" >nul 2>&1
        echo [√] 已设置自动: Schedule 任务计划服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Schedule" >nul 2>&1
        echo [√] 已禁用: Schedule 任务计划服务
    )
    goto :EOF
)

:: 19.Wecsvc (Windows事件收集服务)
if %option% equ 19 (
    if %opt19_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Wecsvc" start= disabled >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "Wecsvc" >nul 2>&1
        echo [√] 已禁用: Wecsvc Windows事件收集服务
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Wecsvc" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "Wecsvc" >nul 2>&1
        echo [√] 已启用: Wecsvc Windows事件收集服务
    )
    goto :EOF
)
endlocal
goto :EOF

:: 恢复所有服务默认设置的函数
:RESTORE_DEFAULT
echo.
echo 正在恢复所有服务默认设置...
echo.

:: 恢复默认设置并启动服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SysMain" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WSearch" start= delayed-auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "UsoSvc" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "TrkWks" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WinDefend" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagsvc" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "DPS" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiServiceHost" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WdiSystemHost" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "MapsBroker" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "iphlpsvc" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "diagnosticshub.standardcollector.service" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SmsRouter" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "PcaSvc" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "ShellHWDetection" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SgrmBroker" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Schedule" start= auto >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "Wecsvc" start= manual >nul
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SecurityHealthService" start= auto >nul

:: 启动应该自动启动的服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SysMain" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "TrkWks" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WinDefend" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "DPS" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "PcaSvc" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "ShellHWDetection" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "Schedule" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SecurityHealthService" >nul 2>&1

echo 所有服务已恢复默认设置!
echo.
pause
goto fuwuxiang_menu

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 更新设置
::-------------------------------------------------------------------------------------------
:update
setlocal enabledelayedexpansion

:: 初始化状态变量
for /l %%i in (1,1,5) do set "opt%%i_status=0"

:: 检测所有优化项状态
call :Check_OPT_Status

cls
echo.===============================================================================
echo.                    ZyperWin++ - 更新设置
echo.===============================================================================
echo. 状态标记: [+]已优化  [-]未优化
echo.
echo   [ 1] %opt1_mark% 禁止Win10/11进行大版本更新
echo   [ 2] %opt2_mark% Windows更新不包括恶意软件删除工具
echo   [ 3] %opt3_mark% 禁用Windows更新 停止更新到2999年
echo   [ 4] %opt4_mark% 禁用自动更新商店应用
echo   [ 5] %opt5_mark% 禁用自动更新地图
echo.
echo   [A] 应用所有未优化的项
echo   [R] 重启Windows更新服务
echo   [X] 返回
echo.
set /p "choices=请输入选择（如: 1 3 5 或 A）: "

if "%choices%"=="" goto update
if /i "%choices%"=="X" goto custom_optimize
if /i "%choices%"=="R" goto RESTART_WU_SERVICE

:: 处理全选（只选未优化的项）
if /i "%choices%"=="A" (
    set "choices="
    for /l %%i in (1,1,5) do (
        if !opt%%i_status! equ 0 set "choices=!choices! %%i"
    )
    if "!choices!"=="" (
        echo 所有优化项已应用，无需操作！
        pause
        goto custom_optimize
    )
)

:: 逐个处理选择
for %%c in (%choices%) do (
    call :Toggle_OPT %%c
)

:: 更新状态
for /l %%i in (1,1,5) do set "opt%%i_status=0"
call :Check_OPT_Status

echo.
echo 注意：部分设置需要重启系统才能完全生效
echo.
pause
goto update

:: 检测所有优化项状态的函数
:Check_OPT_Status
:: 1.禁止Win10/11进行大版本更新
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt1_status=1" & set "opt1_mark=[+]") else (set "opt1_mark=[-]")

:: 2.Windows更新不包括恶意软件删除工具
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" 2>nul | findstr /i "0x1" >nul
if %errorlevel% equ 0 (set "opt2_status=1" & set "opt2_mark=[+]") else (set "opt2_mark=[-]")

:: 3.禁用Windows更新 停止更新到2999年
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" 2>nul | findstr /i "2999" >nul
if %errorlevel% equ 0 (set "opt3_status=1" & set "opt3_mark=[+]") else (set "opt3_mark=[-]")

:: 4.禁用自动更新商店应用
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" 2>nul | findstr /i "0x2" >nul
if %errorlevel% equ 0 (set "opt4_status=1" & set "opt4_mark=[+]") else (set "opt4_mark=[-]")

:: 5.禁用自动更新地图
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" 2>nul | findstr /i "0x0" >nul
if %errorlevel% equ 0 (set "opt5_status=1" & set "opt5_mark=[+]") else (set "opt5_mark=[-]")
goto :eof

:: 切换优化状态的函数
:Toggle_OPT
setlocal
set option=%1

:: 1.禁止Win10/11进行大版本更新
if %option% equ 1 (
    if %opt1_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul
        echo [√] 已禁止Win10/11进行大版本更新
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /f >nul
        echo [√] 已允许Win10/11进行大版本更新
    )
    goto :EOF
)

:: 2.Windows更新不包括恶意软件删除工具
if %option% equ 2 (
    if %opt2_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul
        echo [√] Windows更新已不包括恶意软件删除工具
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul
        echo [√] Windows更新已包括恶意软件删除工具
    )
    goto :EOF
)

:: 3.禁用Windows更新 停止更新到2999年
if %option% equ 3 (
    if %opt3_status% equ 0 (
        :: 暂停更新（但不删除关键注册表项）
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2999-12-01T09:59:52Z" /f >nul
        echo [√] 已暂停 Windows 更新至 2999 年
    ) else (
        :: 恢复更新（仅重置关键值，而不是删除整个键）
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "" /f >nul
        echo [√] 已恢复 Windows 更新
    )
    goto :EOF
)

:: 4.禁用自动更新商店应用
if %option% equ 4 (
    if %opt4_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul
        echo [√] 已禁用自动更新商店应用
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul
        echo [√] 已启用自动更新商店应用
    )
    goto :EOF
)

:: 5.禁用自动更新地图
if %option% equ 5 (
    if %opt6_status% equ 0 (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t REG_DWORD /d 0 /f >nul
        echo [√] 已禁用自动更新地图
    ) else (
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /f >nul
        echo [√] 已启用自动更新地图
    )
    goto :EOF
)
endlocal
goto :EOF

:RESTART_WU_SERVICE
echo.
echo 正在重启 Windows Update 相关服务...
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "wuauserv" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "CryptSvc" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc stop "BITS" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "BITS" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "CryptSvc" >nul 2>&1
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "wuauserv" >nul 2>&1
echo Windows Update 服务及依赖项已重启
echo.
pause
goto update

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 优化还原
::-------------------------------------------------------------------------------------------
:recover_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 优 化 还 原
echo.===============================================================================
echo.
echo.
echo.  [1]   基本优化还原
echo.
echo.  [2]   深度优化还原
echo.
echo.  [3]   所有优化还原
echo.
echo.  [4]   系统更新还原
echo.
echo.  [5]   Defender 还原
echo.                           
echo.                           
echo.                             
echo.                           
echo.                             
echo.
echo.  [X]   退      出
echo.
echo.===============================================================================
choice /C:12345X /N /M "请输入你的选项 ："
if errorlevel 6 goto :MainMenu
if errorlevel 5 goto :recover_defender
if errorlevel 4 goto :recover_update
if errorlevel 3 goto :recover_all_optimize
if errorlevel 2 goto :recover_deep_optimize
if errorlevel 1 goto :recover_basic_optimize
::-------------------------------------------------------------------------------------------

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 基本优化还原
::-------------------------------------------------------------------------------------------
:recover_basic_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 基本优化还原
echo.===============================================================================
echo.
echo.  正在还原基本优化设置...
echo.
echo.  注意：此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================

:: 还原Defender设置
sc config "wscsvc" start= auto >nul
echo [√] 已恢复Defender服务默认设置

:: 还原任务栏Cortana
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /f >nul 2>&1
echo [√] 已恢复任务栏Cortana显示

:: 还原任务栏窗口合并
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /f >nul 2>&1
echo [√] 已恢复任务栏窗口合并默认设置

:: 还原资源管理器打开位置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /f >nul 2>&1
echo [√] 已恢复资源管理器打开位置默认设置

:: 还原DLL卸载设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /f >nul 2>&1
echo [√] 已恢复DLL卸载默认设置

:: 还原快捷方式跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /f >nul 2>&1
echo [√] 已恢复快捷方式跟踪默认设置

:: 还原文件列表刷新策略
reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /f >nul 2>&1
echo [√] 已恢复文件列表刷新默认策略

:: 还原快捷方式创建文字
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
echo [√] 已恢复快捷方式创建默认文字

:: 还原自动播放设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /f >nul 2>&1
echo [√] 已恢复自动播放默认设置

:: 还原文件夹进程设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /f >nul 2>&1
echo [√] 已恢复文件夹进程默认设置

:: 还原快速访问常用文件夹
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /f >nul 2>&1
echo [√] 已恢复快速访问常用文件夹显示

:: 还原快速访问最近文件
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /f >nul 2>&1
echo [√] 已恢复快速访问最近文件显示

:: 还原语言栏设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /f >nul 2>&1
echo [√] 已恢复语言栏默认设置

:: 还原语言栏帮助按钮
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /f >nul 2>&1
echo [√] 已恢复语言栏帮助按钮显示

:: 还原资源管理器崩溃重启
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /f >nul 2>&1
echo [√] 已恢复资源管理器崩溃重启设置

:: 还原文件扩展名显示
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /f >nul 2>&1
echo [√] 已恢复文件扩展名默认显示设置

:: 还原桌面"此电脑"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /f >nul 2>&1
echo [√] 已恢复桌面"此电脑"图标默认设置

:: 还原桌面"回收站"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /f >nul 2>&1
echo [√] 已恢复桌面"回收站"图标默认设置

:: 还原右键菜单项
reg add "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >nul
reg add "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /ve /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /ve /t REG_SZ /d "启用BitLocker..." /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /ve /t REG_SZ /d "作为便携设备打开" /f >nul
reg add "HKEY_CLASSES_ROOT\.contact\ShellNew" /ve /t REG_SZ /d "联系人" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /ve /t REG_SZ /d "固定到快速访问" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /ve /t REG_SZ /d "在画图3D中编辑" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "" /f >nul
echo [√] 已恢复所有右键菜单项

:: 还原开始菜单常用应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul 2>&1
echo [√] 已恢复开始菜单常用应用显示

:: 还原开始菜单最近添加应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /f >nul 2>&1
echo [√] 已恢复开始菜单最近添加应用显示

:: 还原记事本自动换行
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /f >nul 2>&1
echo [√] 已恢复记事本自动换行默认设置

:: 还原记事本状态栏
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /f >nul 2>&1
echo [√] 已恢复记事本状态栏默认设置

:: 还原最近文档清除
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /f >nul 2>&1
echo [√] 已恢复最近文档清除设置

:: 还原Win11右键菜单
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
echo [√] 已恢复Win11默认右键菜单

:: 还原Win11资源管理器
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /f >nul
echo [√] 已恢复Win11默认资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 还原开始菜单建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /f >nul 2>&1
echo [√] 已恢复开始菜单建议显示

:: 还原应用商店关联应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复应用商店关联应用查找

:: 还原商店应用推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复商店应用推广

:: 还原锁屏聚焦推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /f >nul 2>&1
echo [√] 已恢复锁屏聚焦推广

:: 还原技巧和建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /f >nul 2>&1
echo [√] 已恢复"使用Windows时获取技巧和建议"

:: 还原游戏录制工具
reg delete "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /f >nul 2>&1
echo [√] 已恢复游戏录制工具

:: 还原小娜设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
echo [√] 已恢复小娜默认设置

:: 还原关机速度
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /f >nul 2>&1
echo [√] 已恢复默认关机速度

:: 还原服务关闭等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /f >nul 2>&1
echo [√] 已恢复默认服务关闭等待时间

:: 还原程序兼容性助手
sc config "PcaSvc" start= auto >nul
sc start "PcaSvc" >nul 2>&1
echo [√] 已恢复程序兼容性助手

:: 还原诊断服务
sc config "DPS" start= auto >nul
sc start "DPS" >nul 2>&1
echo [√] 已恢复诊断服务

:: 还原SysMain
sc config "SysMain" start= auto >nul
sc start "SysMain" >nul 2>&1
echo [√] 已恢复SysMain

:: 还原Windows Search
sc config "WSearch" start= auto >nul
sc start "WSearch" >nul 2>&1
echo [√] 已恢复Windows Search

:: 还原错误报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复错误报告

:: 还原客户体验改善计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul 2>&1
echo [√] 已恢复客户体验改善计划

:: 还原NTFS链接跟踪服务
sc config "TrkWks" start= auto >nul
sc start "TrkWks" >nul 2>&1
echo [√] 已恢复NTFS链接跟踪服务

:: 还原自动维护计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f >nul 2>&1
echo [√] 已恢复自动维护计划

:: 还原大系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /f >nul 2>&1
echo [√] 已恢复系统缓存默认设置

:: 还原系统内核分页
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /f >nul 2>&1
echo [√] 已恢复系统内核分页默认设置

:: 还原文件管理系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /f >nul 2>&1
echo [√] 已恢复文件管理系统缓存默认设置

:: 还原Windows预读
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /f >nul 2>&1
echo [√] 已恢复Windows预读功能

:: 还原VHD启动设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /f >nul 2>&1
echo [√] 已恢复VHD启动默认设置

:: 还原系统自动调试
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /f >nul 2>&1
echo [√] 已恢复系统自动调试功能

:: 还原磁盘错误检查等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /f >nul 2>&1
echo [√] 已恢复磁盘错误检查默认等待时间

:: 还原设备安装系统还原点
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /f >nul 2>&1
echo [√] 已恢复设备安装系统还原点创建

:: 还原USB磁盘电源设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /f >nul 2>&1
echo [√] 已恢复USB磁盘电源默认设置

:: 还原快速启动
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /f >nul 2>&1
echo [√] 已恢复快速启动默认设置

:: 还原休眠
powercfg /h on >nul
echo [√] 已恢复休眠功能

:: 还原字体设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /f >nul 2>&1
echo [√] 已恢复字体默认设置

:: 还原微软拼音云计算
reg delete "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /f >nul 2>&1
echo [√] 已恢复微软拼音云计算功能

:: 还原内容传递优化服务
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /f >nul 2>&1
echo [√] 已恢复内容传递优化服务

echo.  ========================================
echo 基本优化已还原! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 深度优化还原
::-------------------------------------------------------------------------------------------
:recover_deep_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 深度优化还原
echo.===============================================================================
echo.
echo.  正在还原深度优化设置...
echo.
echo.  注意：此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
:: 还原Defender设置
sc config "wscsvc" start= auto >nul
echo [√] 已恢复Defender服务默认设置

:: 还原任务栏Cortana
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /f >nul 2>&1
echo [√] 已恢复任务栏Cortana显示

:: 还原任务栏窗口合并
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /f >nul 2>&1
echo [√] 已恢复任务栏窗口合并默认设置

:: 还原资源管理器打开位置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /f >nul 2>&1
echo [√] 已恢复资源管理器打开位置默认设置

:: 还原DLL卸载设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /f >nul 2>&1
echo [√] 已恢复DLL卸载默认设置

:: 还原快捷方式跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /f >nul 2>&1
echo [√] 已恢复快捷方式跟踪默认设置

:: 还原文件列表刷新策略
reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /f >nul 2>&1
echo [√] 已恢复文件列表刷新默认策略

:: 还原快捷方式创建文字
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
echo [√] 已恢复快捷方式创建默认文字

:: 还原自动播放设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /f >nul 2>&1
echo [√] 已恢复自动播放默认设置

:: 还原文件夹进程设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /f >nul 2>&1
echo [√] 已恢复文件夹进程默认设置

:: 还原快速访问常用文件夹
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /f >nul 2>&1
echo [√] 已恢复快速访问常用文件夹显示

:: 还原快速访问最近文件
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /f >nul 2>&1
echo [√] 已恢复快速访问最近文件显示

:: 还原语言栏设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /f >nul 2>&1
echo [√] 已恢复语言栏默认设置

:: 还原语言栏帮助按钮
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /f >nul 2>&1
echo [√] 已恢复语言栏帮助按钮显示

:: 还原资源管理器崩溃重启
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /f >nul 2>&1
echo [√] 已恢复资源管理器崩溃重启设置

:: 还原文件扩展名显示
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /f >nul 2>&1
echo [√] 已恢复文件扩展名默认显示设置

:: 还原桌面"此电脑"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /f >nul 2>&1
echo [√] 已恢复桌面"此电脑"图标默认设置

:: 还原桌面"回收站"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /f >nul 2>&1
echo [√] 已恢复桌面"回收站"图标默认设置

:: 还原右键菜单项
reg add "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >nul
reg add "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /ve /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /ve /t REG_SZ /d "启用BitLocker..." /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /ve /t REG_SZ /d "作为便携设备打开" /f >nul
reg add "HKEY_CLASSES_ROOT\.contact\ShellNew" /ve /t REG_SZ /d "联系人" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /ve /t REG_SZ /d "固定到快速访问" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /ve /t REG_SZ /d "在画图3D中编辑" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "" /f >nul
echo [√] 已恢复所有右键菜单项

:: 还原开始菜单常用应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul 2>&1
echo [√] 已恢复开始菜单常用应用显示

:: 还原开始菜单最近添加应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /f >nul 2>&1
echo [√] 已恢复开始菜单最近添加应用显示

:: 还原记事本自动换行
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /f >nul 2>&1
echo [√] 已恢复记事本自动换行默认设置

:: 还原记事本状态栏
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /f >nul 2>&1
echo [√] 已恢复记事本状态栏默认设置

:: 还原最近文档清除
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /f >nul 2>&1
echo [√] 已恢复最近文档清除设置

:: 还原Win11右键菜单
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
echo [√] 已恢复Win11默认右键菜单

:: 还原Win11资源管理器
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /f >nul
echo [√] 已恢复Win11默认资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 还原开始菜单建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /f >nul 2>&1
echo [√] 已恢复开始菜单建议显示

:: 还原应用商店关联应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复应用商店关联应用查找

:: 还原商店应用推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复商店应用推广

:: 还原锁屏聚焦推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /f >nul 2>&1
echo [√] 已恢复锁屏聚焦推广

:: 还原技巧和建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /f >nul 2>&1
echo [√] 已恢复"使用Windows时获取技巧和建议"

:: 还原游戏录制工具
reg delete "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /f >nul 2>&1
echo [√] 已恢复游戏录制工具

:: 还原小娜设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
echo [√] 已恢复小娜默认设置

:: 还原关机速度
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /f >nul 2>&1
echo [√] 已恢复默认关机速度

:: 还原服务关闭等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /f >nul 2>&1
echo [√] 已恢复默认服务关闭等待时间

:: 还原程序兼容性助手
sc config "PcaSvc" start= auto >nul
sc start "PcaSvc" >nul 2>&1
echo [√] 已恢复程序兼容性助手

:: 还原诊断服务
sc config "DPS" start= auto >nul
sc start "DPS" >nul 2>&1
echo [√] 已恢复诊断服务

:: 还原SysMain
sc config "SysMain" start= auto >nul
sc start "SysMain" >nul 2>&1
echo [√] 已恢复SysMain

:: 还原Windows Search
sc config "WSearch" start= auto >nul
sc start "WSearch" >nul 2>&1
echo [√] 已恢复Windows Search

:: 还原错误报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复错误报告

:: 还原客户体验改善计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul 2>&1
echo [√] 已恢复客户体验改善计划

:: 还原NTFS链接跟踪服务
sc config "TrkWks" start= auto >nul
sc start "TrkWks" >nul 2>&1
echo [√] 已恢复NTFS链接跟踪服务

:: 还原自动维护计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f >nul 2>&1
echo [√] 已恢复自动维护计划

:: 还原大系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /f >nul 2>&1
echo [√] 已恢复系统缓存默认设置

:: 还原系统内核分页
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /f >nul 2>&1
echo [√] 已恢复系统内核分页默认设置

:: 还原文件管理系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /f >nul 2>&1
echo [√] 已恢复文件管理系统缓存默认设置

:: 还原Windows预读
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /f >nul 2>&1
echo [√] 已恢复Windows预读功能

:: 还原VHD启动设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /f >nul 2>&1
echo [√] 已恢复VHD启动默认设置

:: 还原系统自动调试
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /f >nul 2>&1
echo [√] 已恢复系统自动调试功能

:: 还原磁盘错误检查等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /f >nul 2>&1
echo [√] 已恢复磁盘错误检查默认等待时间

:: 还原设备安装系统还原点
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /f >nul 2>&1
echo [√] 已恢复设备安装系统还原点创建

:: 还原USB磁盘电源设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /f >nul 2>&1
echo [√] 已恢复USB磁盘电源默认设置

:: 还原快速启动
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /f >nul 2>&1
echo [√] 已恢复快速启动默认设置

:: 还原休眠
powercfg /h on >nul
echo [√] 已恢复休眠功能

:: 还原字体设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /f >nul 2>&1
echo [√] 已恢复字体默认设置

:: 还原微软拼音云计算
reg delete "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /f >nul 2>&1
echo [√] 已恢复微软拼音云计算功能

:: 还原内容传递优化服务
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /f >nul 2>&1
echo [√] 已恢复内容传递优化服务

:: 还原SmartScreen筛选器
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
echo [√] 已恢复SmartScreen筛选器

:: 还原安全中心报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复Windows安全中心报告

:: 还原Edge浏览器SmartScreen
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /f >nul 2>&1
echo [√] 已恢复Edge浏览器SmartScreen

:: 还原文件资源管理器SmartScreen
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
echo [√] 已恢复文件资源管理器SmartScreen

:: 还原Store应用SmartScreen
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
echo [√] 已恢复Microsoft Store应用SmartScreen

:: 还原UAC设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /f >nul 2>&1
echo [√] 已恢复UAC默认设置

:: 还原防火墙
netsh advfirewall set allprofiles state on >nul
echo [√] 已恢复防火墙

:: 还原默认共享
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /f >nul 2>&1
echo [√] 已恢复默认共享

:: 还原远程协助
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /f >nul 2>&1
echo [√] 已恢复远程协助

:: 还原硬件加速GPU计划
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f >nul 2>&1
echo [√] 已恢复硬件加速GPU计划默认设置

:: 还原处理器性能和内存设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /f >nul 2>&1
echo [√] 已恢复处理器性能和内存默认设置

:: 还原Cortana性能
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
echo [√] 已恢复Cortana默认性能

:: 还原广告ID
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /f >nul 2>&1
echo [√] 已恢复广告ID

:: 还原应用启动跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul 2>&1
echo [√] 已恢复应用启动跟踪

:: 还原搜索页面信息流
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /f >nul 2>&1
echo [√] 已恢复搜索页面信息流和热搜

:: 还原高精度事件定时器
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /f >nul 2>&1
echo [√] 已恢复高精度事件定时器

:: 还原Game Bar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul 2>&1
echo [√] 已恢复Game Bar

:: 还原远程注册表修改
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /f >nul 2>&1
echo [√] 已恢复远程注册表修改权限

:: 还原保留空间
DISM.exe /Online /Set-ReservedStorageState /State:Enabled >nul 2>&1
echo [√] 已恢复保留空间

:: 还原上下文菜单延迟
reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /f >nul 2>&1
echo [√] 已恢复上下文菜单显示延迟

:: 还原蓝屏自动重启
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /f >nul 2>&1
echo [√] 已恢复蓝屏后自动重启

:: 还原Installer detection
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /f >nul 2>&1
echo [√] 已恢复Installer detection

:: 还原功能更新安全措施
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /f >nul 2>&1
echo [√] 已恢复功能更新安全措施

:: 还原交付优化
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /f >nul 2>&1
echo [√] 已恢复交付优化

:: 还原客户体验改进计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul 2>&1
echo [√] 已恢复微软客户体验改进计划

:: 还原遥测服务
sc config "DiagTrack" start= auto >nul
sc start "DiagTrack" >nul 2>&1
echo [√] 已恢复遥测服务

:: 还原错误报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复错误报告

:: 还原语音激活
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /f >nul 2>&1
echo [√] 已恢复语音激活

:: 还原位置服务
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /f >nul 2>&1
echo [√] 已恢复位置服务

:: 还原搜索数据收集
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
echo [√] 已恢复搜索数据收集

:: 还原定向广告
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f >nul 2>&1
echo [√] 已恢复定向广告

:: 还原Wi-Fi感知
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /f >nul 2>&1
echo [√] 已恢复Wi-Fi感知

:: 还原步骤记录器
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /f >nul 2>&1
echo [√] 已恢复步骤记录器

:: 还原写入调试信息
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /f >nul 2>&1
echo [√] 已恢复写入调试信息

:: 还原Windows欢迎体验
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /f >nul 2>&1
echo [√] 已恢复Windows欢迎体验

:: 还原反馈频率
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /f >nul 2>&1
echo [√] 已恢复反馈频率

:: 还原诊断数据收集
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f >nul 2>&1
echo [√] 已恢复诊断数据收集

:: 还原写作习惯跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /f >nul 2>&1
echo [√] 已恢复写作习惯跟踪

:: 还原设置应用建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /f >nul 2>&1
echo [√] 已恢复设置应用建议

:: 还原Bing搜索结果
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
echo [√] 已恢复Bing搜索结果

:: 还原搜索历史
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /f >nul 2>&1
echo [√] 已恢复搜索历史

:: 还原赞助商应用安装
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /f >nul 2>&1
echo [√] 已恢复赞助商应用安装

:: 还原自动连接热点
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /f >nul 2>&1
echo [√] 已恢复自动连接热点

:: 还原输入数据个性化
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /f >nul 2>&1
echo [√] 已恢复输入数据个性化

:: 还原键入见解
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /f >nul 2>&1
echo [√] 已恢复键入见解

:: 还原预安装应用
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /f >nul 2>&1
echo [√] 已恢复预安装应用

:: 还原.NET遥测
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /f >nul 2>&1
echo [√] 已恢复.NET遥测

:: 还原PowerShell遥测
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /f >nul 2>&1
echo [√] 已恢复PowerShell遥测

:: 还原自动安装推荐的应用程序
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /f >nul 2>&1
echo [√] 已恢复自动安装推荐的应用程序

:: 还原大版本更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /f >nul 2>&1
echo [√] 已恢复Windows大版本更新

:: 还原恶意软件删除工具
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
echo [√] Windows更新已恢复包括恶意软件删除工具

:: 还原商店应用自动更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul 2>&1
echo [√] 已恢复自动更新商店应用

:: 还原地图自动更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /f >nul 2>&1
echo [√] 已恢复自动更新地图

:: 还原IP助手服务
sc config "iphlpsvc" start= auto >nul
sc start "iphlpsvc" >nul 2>&1
echo [√] 已恢复IP助手服务

:: 还原SMS路由器服务
sc config "SmsRouter" start= auto >nul
sc start "SmsRouter" >nul 2>&1
echo [√] 已恢复SMS路由器服务

:: 还原Shell硬件检测
sc config "ShellHWDetection" start= auto >nul
sc start "ShellHWDetection" >nul 2>&1
echo [√] 已恢复Shell硬件检测

:: 还原任务计划服务
sc config "Schedule" start= auto >nul
sc start "Schedule" >nul 2>&1
echo [√] 已恢复任务计划服务

:: 还原Windows事件收集服务
sc config "Wecsvc" start= auto >nul
sc start "Wecsvc" >nul 2>&1
echo [√] 已恢复Windows事件收集服务

:: 还原诊断中心收集器
sc config "diagnosticshub.standardcollector.service" start= auto >nul
sc start "diagnosticshub.standardcollector.service" >nul 2>&1
echo [√] 已恢复诊断中心收集器

echo.  ========================================
echo 深度优化已还原! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 所有优化还原
::-------------------------------------------------------------------------------------------
:recover_all_optimize

cls
echo.===============================================================================
echo.                          ZyperWin++ - 所有优化还原
echo.===============================================================================
echo.
echo.  正在还原所有优化设置...
echo.
echo.  注意：此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================
:: 还原Defender设置
sc config "wscsvc" start= auto >nul
echo [√] 已恢复Defender服务默认设置

:: 还原任务栏Cortana
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /f >nul 2>&1
echo [√] 已恢复任务栏Cortana显示

:: 还原任务栏窗口合并
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /f >nul 2>&1
echo [√] 已恢复任务栏窗口合并默认设置

:: 还原资源管理器打开位置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /f >nul 2>&1
echo [√] 已恢复资源管理器打开位置默认设置

:: 还原DLL卸载设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /f >nul 2>&1
echo [√] 已恢复DLL卸载默认设置

:: 还原快捷方式跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /f >nul 2>&1
echo [√] 已恢复快捷方式跟踪默认设置

:: 还原文件列表刷新策略
reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /f >nul 2>&1
echo [√] 已恢复文件列表刷新默认策略

:: 还原快捷方式创建文字
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
echo [√] 已恢复快捷方式创建默认文字

:: 还原自动播放设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /f >nul 2>&1
echo [√] 已恢复自动播放默认设置

:: 还原文件夹进程设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /f >nul 2>&1
echo [√] 已恢复文件夹进程默认设置

:: 还原快速访问常用文件夹
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /f >nul 2>&1
echo [√] 已恢复快速访问常用文件夹显示

:: 还原快速访问最近文件
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /f >nul 2>&1
echo [√] 已恢复快速访问最近文件显示

:: 还原语言栏设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /f >nul 2>&1
echo [√] 已恢复语言栏默认设置

:: 还原语言栏帮助按钮
reg delete "HKEY_CURRENT_USER\Software\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /f >nul 2>&1
echo [√] 已恢复语言栏帮助按钮显示

:: 还原资源管理器崩溃重启
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /f >nul 2>&1
echo [√] 已恢复资源管理器崩溃重启设置

:: 还原文件扩展名显示
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /f >nul 2>&1
echo [√] 已恢复文件扩展名默认显示设置

:: 还原桌面"此电脑"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /f >nul 2>&1
echo [√] 已恢复桌面"此电脑"图标默认设置

:: 还原桌面"回收站"图标
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{645FF040-5081-101B-9F08-00AA002F954E}" /f >nul 2>&1
echo [√] 已恢复桌面"回收站"图标默认设置

:: 还原右键菜单项
reg add "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >nul
reg add "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /ve /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\BitLocker" /ve /t REG_SZ /d "启用BitLocker..." /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shell\PortableDeviceMenu" /ve /t REG_SZ /d "作为便携设备打开" /f >nul
reg add "HKEY_CLASSES_ROOT\.contact\ShellNew" /ve /t REG_SZ /d "联系人" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{B327765E-D724-4347-8B16-78AE18552FC3}" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\pintohome" /ve /t REG_SZ /d "固定到快速访问" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /ve /t REG_SZ /d "在画图3D中编辑" /f >nul
reg add "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "" /f >nul
echo [√] 已恢复所有右键菜单项

:: 还原开始菜单常用应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul 2>&1
echo [√] 已恢复开始菜单常用应用显示

:: 还原开始菜单最近添加应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /f >nul 2>&1
echo [√] 已恢复开始菜单最近添加应用显示

:: 还原记事本自动换行
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /f >nul 2>&1
echo [√] 已恢复记事本自动换行默认设置

:: 还原记事本状态栏
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "StatusBar" /f >nul 2>&1
echo [√] 已恢复记事本状态栏默认设置

:: 还原最近文档清除
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /f >nul 2>&1
echo [√] 已恢复最近文档清除设置

:: 还原Win11右键菜单
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
echo [√] 已恢复Win11默认右键菜单

:: 还原Win11资源管理器
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /f >nul
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /f >nul
echo [√] 已恢复Win11默认资源管理器

echo 正在重启资源管理器...
taskkill /f /im explorer.exe >nul
start explorer.exe >nul
echo 资源管理器已重启

:: 还原开始菜单建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /f >nul 2>&1
echo [√] 已恢复开始菜单建议显示

:: 还原应用商店关联应用
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复应用商店关联应用查找

:: 还原商店应用推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /f >nul 2>&1
echo [√] 已恢复商店应用推广

:: 还原锁屏聚焦推广
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /f >nul 2>&1
echo [√] 已恢复锁屏聚焦推广

:: 还原技巧和建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /f >nul 2>&1
echo [√] 已恢复"使用Windows时获取技巧和建议"

:: 还原游戏录制工具
reg delete "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /f >nul 2>&1
echo [√] 已恢复游戏录制工具

:: 还原小娜设置
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
echo [√] 已恢复小娜默认设置

:: 还原关机速度
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /f >nul 2>&1
echo [√] 已恢复默认关机速度

:: 还原服务关闭等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "ServicesPipeTimeout" /f >nul 2>&1
echo [√] 已恢复默认服务关闭等待时间

:: 还原程序兼容性助手
sc config "PcaSvc" start= auto >nul
sc start "PcaSvc" >nul 2>&1
echo [√] 已恢复程序兼容性助手

:: 还原诊断服务
sc config "DPS" start= auto >nul
sc start "DPS" >nul 2>&1
echo [√] 已恢复诊断服务

:: 还原SysMain
sc config "SysMain" start= auto >nul
sc start "SysMain" >nul 2>&1
echo [√] 已恢复SysMain

:: 还原Windows Search
sc config "WSearch" start= auto >nul
sc start "WSearch" >nul 2>&1
echo [√] 已恢复Windows Search

:: 还原错误报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复错误报告

:: 还原客户体验改善计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul 2>&1
echo [√] 已恢复客户体验改善计划

:: 还原NTFS链接跟踪服务
sc config "TrkWks" start= auto >nul
sc start "TrkWks" >nul 2>&1
echo [√] 已恢复NTFS链接跟踪服务

:: 还原自动维护计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f >nul 2>&1
echo [√] 已恢复自动维护计划

:: 还原大系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /f >nul 2>&1
echo [√] 已恢复系统缓存默认设置

:: 还原系统内核分页
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /f >nul 2>&1
echo [√] 已恢复系统内核分页默认设置

:: 还原文件管理系统缓存
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /f >nul 2>&1
echo [√] 已恢复文件管理系统缓存默认设置

:: 还原Windows预读
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /f >nul 2>&1
echo [√] 已恢复Windows预读功能

:: 还原VHD启动设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /f >nul 2>&1
echo [√] 已恢复VHD启动默认设置

:: 还原系统自动调试
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v "Auto" /f >nul 2>&1
echo [√] 已恢复系统自动调试功能

:: 还原磁盘错误检查等待时间
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "AutoChkTimeOut" /f >nul 2>&1
echo [√] 已恢复磁盘错误检查默认等待时间

:: 还原设备安装系统还原点
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "DisableSystemRestore" /f >nul 2>&1
echo [√] 已恢复设备安装系统还原点创建

:: 还原USB磁盘电源设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "DisableOnSoftRemove" /f >nul 2>&1
echo [√] 已恢复USB磁盘电源默认设置

:: 还原快速启动
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /f >nul 2>&1
echo [√] 已恢复快速启动默认设置

:: 还原休眠
powercfg /h on >nul
echo [√] 已恢复休眠功能

:: 还原字体设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions" /v "MitigationOptions_FontBocking" /f >nul 2>&1
echo [√] 已恢复字体默认设置

:: 还原微软拼音云计算
reg delete "HKEY_CURRENT_USER\Software\Microsoft\InputMethod\Settings\CHS" /v "CloudCandidate" /f >nul 2>&1
echo [√] 已恢复微软拼音云计算功能

:: 还原内容传递优化服务
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /f >nul 2>&1
echo [√] 已恢复内容传递优化服务

:: 还原SmartScreen筛选器
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
echo [√] 已恢复SmartScreen筛选器

:: 还原安全中心报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复Windows安全中心报告

:: 还原Edge浏览器SmartScreen
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /f >nul 2>&1
echo [√] 已恢复Edge浏览器SmartScreen

:: 还原文件资源管理器SmartScreen
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
echo [√] 已恢复文件资源管理器SmartScreen

:: 还原Store应用SmartScreen
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
echo [√] 已恢复Microsoft Store应用SmartScreen

:: 还原UAC设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /f >nul 2>&1
echo [√] 已恢复UAC默认设置

:: 还原防火墙
netsh advfirewall set allprofiles state on >nul
echo [√] 已恢复防火墙

:: 还原默认共享
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer" /f >nul 2>&1
echo [√] 已恢复默认共享

:: 还原远程协助
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /f >nul 2>&1
echo [√] 已恢复远程协助

:: 还原硬件加速GPU计划
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f >nul 2>&1
echo [√] 已恢复硬件加速GPU计划默认设置

:: 还原处理器性能和内存设置
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /f >nul 2>&1
echo [√] 已恢复处理器性能和内存默认设置

:: 还原Cortana性能
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
echo [√] 已恢复Cortana默认性能

:: 还原广告ID
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /f >nul 2>&1
echo [√] 已恢复广告ID

:: 还原应用启动跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /f >nul 2>&1
echo [√] 已恢复应用启动跟踪

:: 还原搜索页面信息流
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /f >nul 2>&1
echo [√] 已恢复搜索页面信息流和热搜

:: 还原高精度事件定时器
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\hpet" /v "Start" /f >nul 2>&1
echo [√] 已恢复高精度事件定时器

:: 还原Game Bar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f >nul 2>&1
echo [√] 已恢复Game Bar

:: 还原远程注册表修改
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurePipeServers\winreg" /v "RemoteRegAccess" /f >nul 2>&1
echo [√] 已恢复远程注册表修改权限

:: 还原保留空间
DISM.exe /Online /Set-ReservedStorageState /State:Enabled >nul 2>&1
echo [√] 已恢复保留空间

:: 还原上下文菜单延迟
reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /f >nul 2>&1
echo [√] 已恢复上下文菜单显示延迟

:: 还原蓝屏自动重启
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /f >nul 2>&1
echo [√] 已恢复蓝屏后自动重启

:: 还原Installer detection
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /f >nul 2>&1
echo [√] 已恢复Installer detection

:: 还原功能更新安全措施
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /f >nul 2>&1
echo [√] 已恢复功能更新安全措施

:: 还原交付优化
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /f >nul 2>&1
echo [√] 已恢复交付优化

:: 还原客户体验改进计划
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f >nul 2>&1
echo [√] 已恢复微软客户体验改进计划

:: 还原遥测服务
sc config "DiagTrack" start= auto >nul
sc start "DiagTrack" >nul 2>&1
echo [√] 已恢复遥测服务

:: 还原错误报告
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /f >nul 2>&1
echo [√] 已恢复错误报告

:: 还原语音激活
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /f >nul 2>&1
echo [√] 已恢复语音激活

:: 还原位置服务
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /f >nul 2>&1
echo [√] 已恢复位置服务

:: 还原搜索数据收集
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f >nul 2>&1
echo [√] 已恢复搜索数据收集

:: 还原定向广告
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /f >nul 2>&1
echo [√] 已恢复定向广告

:: 还原Wi-Fi感知
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /f >nul 2>&1
echo [√] 已恢复Wi-Fi感知

:: 还原步骤记录器
reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\ProblemReports" /v "DisableProblemReports" /f >nul 2>&1
echo [√] 已恢复步骤记录器

:: 还原写入调试信息
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v "DEFAULT" /f >nul 2>&1
echo [√] 已恢复写入调试信息

:: 还原Windows欢迎体验
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableFirstRunAnimate" /f >nul 2>&1
echo [√] 已恢复Windows欢迎体验

:: 还原反馈频率
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /f >nul 2>&1
echo [√] 已恢复反馈频率

:: 还原诊断数据收集
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f >nul 2>&1
echo [√] 已恢复诊断数据收集

:: 还原写作习惯跟踪
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /f >nul 2>&1
echo [√] 已恢复写作习惯跟踪

:: 还原设置应用建议
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /f >nul 2>&1
echo [√] 已恢复设置应用建议

:: 还原Bing搜索结果
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f >nul 2>&1
echo [√] 已恢复Bing搜索结果

:: 还原搜索历史
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /f >nul 2>&1
echo [√] 已恢复搜索历史

:: 还原赞助商应用安装
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /f >nul 2>&1
echo [√] 已恢复赞助商应用安装

:: 还原自动连接热点
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v "fBlockNonDomain" /f >nul 2>&1
echo [√] 已恢复自动连接热点

:: 还原输入数据个性化
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "RestrictImplicitTextCollection" /f >nul 2>&1
echo [√] 已恢复输入数据个性化

:: 还原键入见解
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "EnableTypingInsights" /f >nul 2>&1
echo [√] 已恢复键入见解

:: 还原预安装应用
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisablePreInstalledApps" /f >nul 2>&1
echo [√] 已恢复预安装应用

:: 还原.NET遥测
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DisableNetFrameworkTelemetry" /f >nul 2>&1
echo [√] 已恢复.NET遥测

:: 还原PowerShell遥测
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnablePowerShellTelemetry" /f >nul 2>&1
echo [√] 已恢复PowerShell遥测

:: 还原自动安装推荐的应用程序
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /f >nul 2>&1
echo [√] 已恢复自动安装推荐的应用程序

:: 还原大版本更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /f >nul 2>&1
echo [√] 已恢复Windows大版本更新

:: 还原恶意软件删除工具
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
echo [√] Windows更新已恢复包括恶意软件删除工具

:: 还原商店应用自动更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul 2>&1
echo [√] 已恢复自动更新商店应用

:: 还原地图自动更新
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /f >nul 2>&1
echo [√] 已恢复自动更新地图

:: 还原IP助手服务
sc config "iphlpsvc" start= auto >nul
sc start "iphlpsvc" >nul 2>&1
echo [√] 已恢复IP助手服务

:: 还原SMS路由器服务
sc config "SmsRouter" start= auto >nul
sc start "SmsRouter" >nul 2>&1
echo [√] 已恢复SMS路由器服务

:: 还原Shell硬件检测
sc config "ShellHWDetection" start= auto >nul
sc start "ShellHWDetection" >nul 2>&1
echo [√] 已恢复Shell硬件检测

:: 还原任务计划服务
sc config "Schedule" start= auto >nul
sc start "Schedule" >nul 2>&1
echo [√] 已恢复任务计划服务

:: 还原Windows事件收集服务
sc config "Wecsvc" start= auto >nul
sc start "Wecsvc" >nul 2>&1
echo [√] 已恢复Windows事件收集服务

:: 还原诊断中心收集器
sc config "diagnosticshub.standardcollector.service" start= auto >nul
sc start "diagnosticshub.standardcollector.service" >nul 2>&1
echo [√] 已恢复诊断中心收集器

:: 还原LSA保护
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "RunAsPPL" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPLBoot" /f >nul 2>&1
bcdedit /deletevalue hypervisorlaunchtype >nul 2>&1
echo [√] 已恢复LSA保护

:: 还原驱动程序阻止列表
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /f >nul 2>&1
echo [√] 已恢复驱动程序阻止列表

:: 还原攻击面减少规则
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR" /v "ExploitGuard_ASR_Rules" /f >nul 2>&1
echo [√] 已恢复攻击面减少规则

:: 还原虚拟化安全
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "HypervisorEnforcedCodeIntegrity" /f >nul 2>&1
bcdedit /set hypervisorlaunchtype auto >nul 2>&1
echo [√] 已恢复虚拟化安全

:: 还原凭证保护
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /f >nul 2>&1
echo [√] 已恢复凭证保护

:: 还原受控文件夹访问
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /f >nul 2>&1
echo [√] 已恢复受控文件夹访问

:: 还原网络保护
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /f >nul 2>&1
echo [√] 已恢复网络保护

:: 还原AMSI
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableAmsi" /f >nul 2>&1
echo [√] 已恢复AMSI

:: 还原代码完整性
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CI" /v "Enabled" /f >nul 2>&1
echo [√] 已恢复代码完整性

:: 还原来宾登录
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /f >nul 2>&1
echo [√] 已恢复安全来宾登录

:: 还原处理器幽灵和熔断补丁
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /f >nul 2>&1
echo [√] 已恢复处理器幽灵和熔断补丁

:: 还原Exploit Protection
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "MitigationOptions" /f >nul 2>&1
echo [√] 已恢复Exploit Protection

:: 还原TSX漏洞补丁
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DisableTsx" /f >nul 2>&1
echo [√] 已恢复TSX漏洞补丁

:: 还原进程数量
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /f >nul 2>&1
echo [√] 已恢复进程数量默认设置

:: 还原诊断策略服务
sc config "DPS" start= auto >nul
sc start "DPS" >nul 2>&1
echo [√] 已恢复诊断策略服务

:: 还原程序兼容性助手
sc config "PcaSvc" start= auto >nul
sc start "PcaSvc" >nul 2>&1
echo [√] 已恢复程序兼容性助手

:: 还原Edge浏览器设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /f >nul 2>&1
echo [√] 已恢复Edge浏览器所有默认设置

:: 还原页面预测功能
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AllowPagePrediction" /f >nul 2>&1
echo [√] 已恢复页面预测功能

:: 还原活动收集
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /f >nul 2>&1
echo [√] 已恢复活动收集

:: 还原应用访问权限
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sync" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chatMessage" /f >nul 2>&1
echo [√] 已恢复所有应用访问权限默认设置

:: 还原网站语言跟踪
reg delete "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /f >nul 2>&1
echo [√] 已恢复网站语言跟踪

:: 还原通讯录收集
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /f >nul 2>&1
echo [√] 已恢复通讯录收集

:: 还原键入文本收集
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Input\Settings" /v "Inking&TypingPersonalization" /f >nul 2>&1
echo [√] 已恢复键入文本收集

:: 还原日志设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-CBS/Debug" /v "Enabled" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Logging" /v "EnableLog" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows" /v "NoEventLog" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLogonCacheDisplay" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Diagnostics" /v "EnableLog" /f >nul 2>&1
echo [√] 已恢复所有日志默认设置

:: 还原Windows更新设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
echo [√] 已恢复Windows更新默认设置

:: 还原安全健康服务
sc config "SecurityHealthService" start= auto >nul
sc start "SecurityHealthService" >nul 2>&1
echo [√] 已恢复安全健康服务

:: 还原Windows更新服务
sc config "UsoSvc" start= auto >nul
sc start "UsoSvc" >nul 2>&1
echo [√] 已恢复Windows更新服务

:: 还原Windows Defender服务
sc config "WinDefend" start= auto >nul
sc start "WinDefend" >nul 2>&1
echo [√] 已恢复Windows Defender服务

:: 还原诊断服务
sc config "diagsvc" start= auto >nul
sc start "diagsvc" >nul 2>&1
echo [√] 已恢复诊断服务

:: 还原系统防护服务
sc config "SgrmBroker" start= auto >nul
sc start "SgrmBroker" >nul 2>&1
echo [√] 已恢复系统防护服务

echo.  ========================================
echo 极限优化已还原! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 系统更新还原
::-------------------------------------------------------------------------------------------
:recover_update

cls
echo.===============================================================================
echo.                          Windows 更新功能完全恢复工具
echo.===============================================================================
echo.
echo.  正在恢复Windows更新功能...
echo.
echo.  注意：此过程可能需要几分钟时间，请勿关闭窗口
echo.
echo.  ==============================================================================

:: 1. 恢复Windows更新服务设置
sc config "wuauserv" start= auto >nul
sc config "UsoSvc" start= auto >nul
sc config "BITS" start= auto >nul
sc config "CryptSvc" start= auto >nul
sc config "DcomLaunch" start= auto >nul
sc config "TrustedInstaller" start= auto >nul
net start wuauserv >nul 2>&1
net start UsoSvc >nul 2>&1
net start BITS >nul 2>&1
net start CryptSvc >nul 2>&1
net start TrustedInstaller >nul 2>&1

echo [√] Windows更新相关服务已恢复并启动

:: 2. 恢复Windows更新相关注册表设置
:: 删除更新暂停设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1

:: 恢复自动更新设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "AUOptions" /t REG_DWORD /d 3 /f >nul

:: 恢复更新服务器设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /f >nul 2>&1

:: 恢复更新通知设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /f >nul 2>&1

:: 恢复驱动程序更新设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /f >nul 2>&1

:: 恢复功能更新设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /v "IsConvergedUpdateStackEnabled" /f >nul 2>&1

:: 恢复交付优化设置
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /f >nul 2>&1

echo [√] Windows更新注册表设置已恢复

:: 完成提示
echo.
echo.  ==============================================================================
echo   Windows更新功能已完全恢复!
echo.
echo   建议操作:
echo   1. 重启计算机使所有更改生效
echo   2. 打开Windows更新检查更新状态
echo   3. 如有问题可运行Windows更新疑难解答
echo.  ==============================================================================

:: 打开Windows更新设置
echo 正在打开Windows更新设置...
start ms-settings:windowsupdate >nul

pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - Defender 还原
::-------------------------------------------------------------------------------------------
:recover_defender

cls
echo.===============================================================================
echo.                          ZyperWin++ - Defender 还原
echo.===============================================================================
echo.
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "SecurityHealthService" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "SecurityHealthService" >nul 2>&1
        echo [√] 已启用: SecurityHealthService 安全健康服务
"%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc config "WinDefend" start= auto >nul
        "%~dp0NSudoLG.exe" -U:T -P:E -ShowWindowMode:Hide sc start "WinDefend" >nul 2>&1
"%~dp0Defender_Control.exe"
        echo [√] 已启用: Windows Defender服务
        echo [i]请手动启动Windows Defender（Enable）

echo.  ========================================
echo Defender 还原已完成! 
echo 建议重启计算机使所有更改生效
pause
goto MainMenu


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 其他功能
::-------------------------------------------------------------------------------------------
:others

cls
echo.===============================================================================
echo.                          ZyperWin++ - 其 他 功 能
echo.===============================================================================
echo.
echo.
echo.  [1]   垃圾清理
echo.
echo.  [2]   Office安装（需联网）
echo.
echo.  [3]   系统激活（部分需联网）
echo.
echo.  [4]   Appx管理（测试实验性）
echo.
echo.
echo.                           
echo.                           
echo.                             
echo.                           
echo.                             
echo.
echo.  [X]   退      出
echo.
echo.===============================================================================
choice /C:1234X /N /M "请输入你的选项 ："
if errorlevel 5 goto :MainMenu
if errorlevel 4 goto :AppX_Manager
if errorlevel 3 goto :System_activation
if errorlevel 2 goto :Office_install
if errorlevel 1 goto :Clean
::-------------------------------------------------------------------------------------------


::-------------------------------------------------------------------------------------------
:: ZyperWin++ - 垃圾清理
::-------------------------------------------------------------------------------------------
:Clean

cls
echo.===============================================================================
echo.                ZyperWin++ - 垃圾清理
echo.===============================================================================
echo.
echo 确定要垃圾清理吗？这会清理掉您创建的系统还原点
echo.
choice /C:YN /N /M " [Y]确定  [N]取消  请输入选项："
echo.

if errorlevel 2 goto :MainMenu
if errorlevel 1 goto :cleaning

:cleaning
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
goto MainMenu

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - APPX 管理
::-------------------------------------------------------------------------------------------
@echo off
setlocal enabledelayedexpansion

:AppX_Manager
cls
echo ===============================================================================
echo                 APPX 管理（测试实验性）
echo ===============================================================================
echo 提示：当列出包名时选择你需要卸载的程序复制
echo 例如：“Microsoft.Windows.Photos_版本号_架构__8wekyb3d8bbwe”，复制这个粘贴后回车就能卸载了
echo 正在检测可卸载的APPX包...
echo.

:: 创建临时文件存储包列表
set "tempFile=%temp%\appx_list_%random%.tmp"

:: 获取可卸载的APPX包列表并保存到临时文件
powershell -Command "Get-AppxPackage | Where-Object {!$_.IsFramework -and !$_.NonRemovable} | Select-Object PackageFullName | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1 | ForEach-Object { $_ -replace '\""', '' }" > "%tempFile%"

:: 读取临时文件并显示带序号的包列表
set "count=0"
for /f "usebackq tokens=*" %%a in ("%tempFile%") do (
    set /a count+=1
    call echo [%%count%%] %%a
)

if %count% equ 0 (
    echo 未找到可卸载的APPX包
    echo.
    del "%tempFile%" 2>nul
    pause
    exit /b
)

echo.
echo 请直接输入要卸载的完整包名
echo   [L]重新列出包名
echo   [X]退出
echo.
set /p "package=请输入包名: "

:: 处理输入
if "%package%"=="" goto AppX_Manager
if /i "%package%"=="x" (
    del "%tempFile%" 2>nul
    goto MainMenu
)
if /i "%package%"=="l" (
    del "%tempFile%" 2>nul
    goto AppX_Manager
)

:: 验证包名是否存在
findstr /c:"%package%" "%tempFile%" >nul
if errorlevel 1 (
    echo 错误：未找到匹配的包名！
    pause
    goto AppX_Manager
)

:: 显示确认信息
echo.
echo 准备卸载: %package%
choice /c YN /n /m "确定要卸载吗? (Y/N): "
if %errorlevel% equ 1 (
    echo 正在卸载...
    
    powershell -Command "Remove-AppxPackage -Package '%package%'"
    
    if errorlevel 1 (
        echo 卸载失败！可能需要管理员权限。
    ) else (
        echo 成功卸载: %package%
    )
) else (
    echo 取消卸载。
)

echo.
pause
del "%tempFile%" 2>nul
goto AppX_Manager

::-------------------------------------------------------------------------------------------
:: ZyperWin++ - Office 安装
::-------------------------------------------------------------------------------------------
:Office_install

cls
echo.===============================================================================
echo.                ZyperWin++ - Office 安装
echo.===============================================================================
echo.
setlocal enabledelayedexpansion

:: 引导用户选择 Office 版本
:choose_version
echo 1. 您需要安装哪个版本？
echo    1. Office365
echo    2. Office2024
echo    3. Office2021
echo    4. Office2019
echo    X. 返回主菜单
set /p versionChoice=请输入您的选择 (1/2/3/4/X):

if /i "%versionChoice%"=="X" goto MainMenu
if "%versionChoice%"=="1" set productCode=O365ProPlusRetail& goto choose_arch
if "%versionChoice%"=="2" set productCode=ProPlus2024Retail& goto choose_arch
if "%versionChoice%"=="3" set productCode=ProPlus2021Retail& goto choose_arch
if "%versionChoice%"=="4" set productCode=ProPlus2019Retail& goto choose_arch
echo 无效的选择，请重新输入。
goto choose_version

:: 引导用户选择体系结构
:choose_arch
echo.
echo 2. 您需要安装哪个体系结构？
echo    1. 64位
echo    2. 32位
echo    X. 返回主菜单
set /p archChoice=请输入您的选择 (1/2/X):

if /i "%archChoice%"=="X" goto MainMenu
if "%archChoice%"=="1" set architecture=64 & goto choose_type
if "%archChoice%"=="2" set architecture=32 & goto choose_type
echo 无效的选择，请重新输入。
goto choose_arch

:: 引导用户选择安装类型
:choose_type
echo.
echo 3. 您需要安装完整版还是常用三件套？
echo    1. 完整版
echo    2. 常用三件套
echo    X. 返回主菜单
set /p typeChoice=请输入您的选择 (1/2/X):

if /i "%typeChoice%"=="X" goto MainMenu
if "%typeChoice%"=="1" (
    set excludeApps=
) else if "%typeChoice%"=="2" (
    set "excludeApps=&exclude_apps=%productCode%:Access,Bing,Groove,Lync,Outlook,OneNote,Publisher,Teams"
) else (
    echo 无效的选择，请重新输入。
    goto choose_type
)

:: 构建最终的模板
:build_template
set "template=https://www.coolhub.top/get/?prod_to_add=%productCode%_zh-cn%excludeApps%^&arch=%architecture%"

:: 确认安装
echo.
set /p confirmInstall=您确定要继续安装吗？(Y/N/X - X返回主菜单):
if /i "%confirmInstall%"=="X" goto MainMenu
if /i not "%confirmInstall%"=="Y" (
    echo 安装已取消。
    pause
    goto MainMenu
)

:: 执行安装命令
:execute_install
start powershell.exe -Command "irm '%template%' | iex"
echo 安装已经开始，将在新窗口中执行。
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
echo 正在调用MAS激活，稍等片刻...
echo.
start %~dp0MAS_AIO_CN.cmd
echo 新窗口已调用，根据界面提示激活系统
echo 按任意键返回
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
echo.                             ZyperWin++ v2.2
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