param(
[string]$Branch = "main",
[int]$SyncSeconds = 15
)

Set-Location C:\dev\TIMONEY
Write-Host "== Timevest Auto Runner =="

git checkout $Branch | Out-Null
git pull origin $Branch

# 로컬 서버 실행(포트 자동)
Start-Process powershell -ArgumentList "-NoExit","-Command","cd C:\dev\TIMONEY; flutter clean; flutter pub get; flutter run -d web-server --web-hostname 127.0.0.1 --web-port 0"

# 변경 감지 -> 자동 커밋/푸시
while ($true) {
Set-Location C:\dev\TIMONEY
git add -A
$status = git status --porcelain
if ($status) {
$msg = "auto: sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $msg | Out-Null
git push origin $Branch
Write-Host "[AUTO PUSH] $msg"
}
Start-Sleep -Seconds $SyncSeconds
}
