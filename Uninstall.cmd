@echo off
setlocal DisableDelayedExpansion
set "WG_BUNDLE_PATH=%~dp0"
powershell.exe -NoLogo -NoProfile -Command "$ErrorActionPreference='Stop'; try { if(-not $env:LOCALAPPDATA) { throw 'LOCALAPPDATA is unavailable.' }; $target=Join-Path $env:LOCALAPPDATA 'WheatstoneGronsfeld'; $marker=Join-Path $target 'install.marker'; $tag='wheatstone-gronsfeld-offline-v1'; if(-not (Test-Path -LiteralPath $target)) { Write-Host 'The app is not installed for this user.'; exit 0 }; if(-not (Test-Path -LiteralPath $marker -PathType Leaf)) { throw 'The folder is not marked as this app. Nothing was removed.' }; if([IO.File]::ReadAllText($marker).Trim() -ne $tag) { throw 'The folder belongs to another app. Nothing was removed.' }; foreach($folder in @([Environment]::GetFolderPath('DesktopDirectory'),[Environment]::GetFolderPath('Programs'))) { if($folder) { $shortcut=Join-Path $folder 'Wheatstone-Gronsfeld.lnk'; if(Test-Path -LiteralPath $shortcut -PathType Leaf) { Remove-Item -LiteralPath $shortcut -Force } } }; Remove-Item -LiteralPath $target -Recurse -Force; Write-Host 'Wheatstone-Gronsfeld was removed for this user.'; exit 0 } catch { Write-Host ('Error: '+$_.Exception.Message); exit 1 }"
if errorlevel 1 (
  echo.
  echo The operation could not be completed. See the message above.
  pause
  exit /b 1
)
echo.
echo Uninstall finished. The extracted ZIP folder is kept.
pause
exit /b 0
