# PowerShell script to add Pawns App to CSV and generate shortlinks
param(
    [string]$CsvFile = "saasverdict-links.csv"
)

# Create new entry for Pawns App (matching CSV structure: Slug, PostURL, AffiliateURL, AffiliateTarget)
$newEntry = [PSCustomObject]@{
    Slug = "pawns-app"
    PostURL = "https://saasverdict.com/posts/pawns-app-review-2026-earn-money-online-passive-income/"
    AffiliateURL = "https://saasverdict.com/go/pawns-app"
    AffiliateTarget = "https://pawns.app/?r=sig"
}

# Import existing CSV
$existingData = Import-Csv -Path $CsvFile

# Add new entry
$updatedData = $existingData + $newEntry

# Export back to CSV
$updatedData | Export-Csv -Path $CsvFile -NoTypeInformation -Encoding UTF8

Write-Host ""
Write-Host "=== PAWNS APP ADDED TO CSV ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "New entry added:" -ForegroundColor Green
Write-Host "Slug: $($newEntry.Slug)" -ForegroundColor White
Write-Host "Post URL: $($newEntry.PostURL)" -ForegroundColor White
Write-Host "Affiliate URL: $($newEntry.AffiliateURL)" -ForegroundColor White
Write-Host "Affiliate Target: $($newEntry.AffiliateTarget)" -ForegroundColor White
Write-Host ""
Write-Host "Total entries in CSV: $($updatedData.Count)" -ForegroundColor Yellow
Write-Host ""

# Generate sharing links
Write-Host "=== SHARING LINKS ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Review Page:" -ForegroundColor Green
Write-Host $newEntry.PostURL -ForegroundColor White
Write-Host ""
Write-Host "Affiliate Link:" -ForegroundColor Green
Write-Host $newEntry.AffiliateURL -ForegroundColor White
Write-Host ""
Write-Host "Forum Sharing Format:" -ForegroundColor Yellow
Write-Host "$($newEntry.PostURL) ($($newEntry.AffiliateURL))" -ForegroundColor White
Write-Host ""