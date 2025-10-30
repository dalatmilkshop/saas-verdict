# PowerShell script to generate shortlink for Pawns App
param(
    [string]$CsvFile = "saasverdict-links.csv",
    [string]$Slug = "pawns-app"
)

# Import links data
$links = Import-Csv -Path $CsvFile

# Find the Pawns App entry
$pawnsAppLink = $links | Where-Object { $_.Slug -eq $slug }

if ($pawnsAppLink) {
    $siteUrl = "https://saasverdict.com/posts/$slug-review-2026-best-software-tools/"
    $affiliateUrl = "https://saasverdict.com/go/$slug"

    Write-Host ""
    Write-Host "=== PAWNS APP SHORTLINK GENERATED ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Review Page:" -ForegroundColor Green
    Write-Host $siteUrl -ForegroundColor White
    Write-Host ""
    Write-Host "Affiliate Link:" -ForegroundColor Green
    Write-Host $affiliateUrl -ForegroundColor White
    Write-Host ""
    Write-Host "Original Affiliate URL:" -ForegroundColor Green
    Write-Host $pawnsAppLink.AffiliateURL -ForegroundColor White
    Write-Host ""
    Write-Host "Shortlink for sharing:" -ForegroundColor Yellow
    Write-Host "$siteUrl ($affiliateUrl)" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "Error: Pawns App link not found in CSV file" -ForegroundColor Red
}