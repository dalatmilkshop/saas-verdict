# Script tự động tải và cài đặt Hugo trên Windows
# 1. Tải Hugo bản mới nhất (extended) cho Windows 64-bit
# 2. Giải nén vào C:\Hugo
# 3. Thêm C:\Hugo vào PATH

$hugoUrl = "https://github.com/gohugoio/hugo/releases/latest/download/hugo_extended_windows-amd64.zip"
$hugoZip = "$env:TEMP\hugo.zip"
$hugoDir = "C:\Hugo"

Write-Host "Đang tải Hugo..."
Invoke-WebRequest -Uri $hugoUrl -OutFile $hugoZip

Write-Host "Đang giải nén..."
Expand-Archive -Path $hugoZip -DestinationPath $hugoDir -Force

Write-Host "Thêm Hugo vào PATH..."
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($envPath -notlike "*$hugoDir*") {
    [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$hugoDir", "User")
    Write-Host "Đã thêm $hugoDir vào PATH. Hãy khởi động lại terminal."
} else {
    Write-Host "Đường dẫn đã có trong PATH."
}

Write-Host "Xong! Bạn hãy mở lại terminal và kiểm tra bằng lệnh: .\install-hugo.ps1"