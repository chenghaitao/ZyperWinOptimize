@echo 正在将此目录添加Defender白名单……
@powershell "try {$null = icim MSFT_MpPreference @{ExclusionPath = @('%~dp0'); Force = $True} Add -Namespace root/Microsoft/Windows/Defender -EA 1} catch {$host.SetShouldExit($_.Exception.HResult)}"
@echo 添加完毕！请关闭Defender里面4个选项
@%~dp0bin\1.vbs
@pause
@echo 请手动操作禁用Defender
@start /b "Defender_Control - TrustedInstaller" "%~dp0Bin\NSudoLG.exe" -U:T -P:E "%~dp0Bin\Defender_Control.exe"
@echo 禁用完后请执行下一操作：
@pause
@%~dp0Start.cmd