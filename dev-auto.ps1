param(
[string]$Branch = "main",
[int]$Port = 7401,
[int]$SyncSeconds = 20
)

Set-Location C:\dev\TIMONEY

Write-Host "== Timevest Dev Auto =="
git checkout $Branch | Out-Null
git pull origin $Branch

Start-Process powershell -ArgumentList "-NoExit","-Command","cd C:\dev\TIMONEY; flutter clean; flutter pub get; flutter run -d web-server --web-hostname 127.0.0.1 --web-port $Port"

while ($true) {
Set-Location C:\dev\TIMONEY
git add -A
$status = git status --porcelain
if ($status) {
$msg = "auto: local sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $msg | Out-Null
git push origin $Branch
Write-Host "[AUTO PUSH] $msg"
}
Start-Sleep -Seconds $SyncSeconds
}
