@echo off
setlocal DisableDelayedExpansion
set "WG_BUNDLE_PATH=%~dp0"
powershell.exe -NoLogo -NoProfile -Command "$ErrorActionPreference='Stop'; try { function Find-Browser { foreach($base in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) { if($base) { foreach($relative in @('Microsoft\Edge\Application\msedge.exe','Google\Chrome\Application\chrome.exe')) { $candidate=Join-Path $base $relative; if(Test-Path -LiteralPath $candidate -PathType Leaf) { return $candidate } } } }; throw 'Microsoft Edge or Google Chrome is required.' }; $browser=Find-Browser; $html=Join-Path $env:WG_BUNDLE_PATH 'Wheatstone-Gronsfeld.html'; if(-not (Test-Path -LiteralPath $html -PathType Leaf)) { throw 'Wheatstone-Gronsfeld.html is missing. Extract the entire ZIP first.' }; $html=(Get-Item -LiteralPath $html).FullName; $uri=([System.Uri]$html).AbsoluteUri; $arg='--app='+[char]34+$uri+[char]34; Start-Process -FilePath $browser -ArgumentList $arg; exit 0 } catch { Write-Host ('Error: '+$_.Exception.Message); exit 1 }"
if errorlevel 1 (
  echo.
  echo The operation could not be completed. See the message above.
  pause
  exit /b 1
)
exit /b 0
