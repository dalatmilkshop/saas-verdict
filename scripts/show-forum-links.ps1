# PowerShell script to show example links for forums
param(
    [string]$CsvFile = "saasverdict-links.csv",
    [int]$MaxExamples = 10
)

# Import CSV
$links = Import-Csv -Path (Join-Path $PSScriptRoot $CsvFile)

Write-Host "=== LINKS CHO DIEN DAN ===" -ForegroundColor Cyan
Write-Host "Domain: https://saasverdict.com/" -ForegroundColor White
Write-Host "Copy-paste these links to share on forums:" -ForegroundColor Yellow
Write-Host ""

# Show examples
$count = 0
foreach ($link in $links) {
    if ($count -ge $MaxExamples) { break }

    Write-Host "--- $($link.Slug.ToUpper()) ---" -ForegroundColor Green
    Write-Host "Review Link: $($link.PostURL)" -ForegroundColor White
    Write-Host "Affiliate Link: $($link.AffiliateURL)" -ForegroundColor Cyan
    Write-Host "Target: $($link.AffiliateTarget)" -ForegroundColor Gray
    Write-Host ""

    $count++
}

Write-Host "=== THONG KE ===" -ForegroundColor Cyan
Write-Host "Total tools: $($links.Count)" -ForegroundColor White
Write-Host "Examples shown: $MaxExamples" -ForegroundColor Green
Write-Host ""
Write-Host "File CSV day du: $(Join-Path $PSScriptRoot $CsvFile)" -ForegroundColor Yellow