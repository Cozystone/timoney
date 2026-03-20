param(
[string]$Branch = "main",
[int]$SyncSeconds = 20
)

Set-Location C:\dev\TIMONEY
Write-Host "== Timevest Dev Auto =="

git checkout $Branch | Out-Null
git pull origin $Branch

# 포트 충돌 방지: web-port 0 (자동 포트)
Start-Process powershell -ArgumentList "-NoExit","-Command","cd C:\dev\TIMONEY; flutter clean; flutter pub get; flutter run -d web-server --web-hostname 127.0.0.1 --web-port 0"

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
