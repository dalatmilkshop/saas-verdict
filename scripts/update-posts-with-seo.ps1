# PowerShell script to update existing posts with SEO-optimized content
param(
    [string]$SeoContentDir = "seo-content",
    [string]$PostsDir = "content/posts"
)

# Get all SEO content files
$seoFiles = Get-ChildItem -Path $SeoContentDir -Filter "*-seo-content.md"

$count = 0
$updated = 0

foreach ($seoFile in $seoFiles) {
    $slug = $seoFile.Name -replace '-seo-content\.md$', ''
    $postFile = Join-Path $PostsDir "$slug.md"

    Write-Host "Updating post: $slug" -ForegroundColor Yellow

    # Read SEO content
    $seoContent = Get-Content -Path $seoFile.FullName -Raw

    # Write SEO content to post file
    $seoContent | Out-File -FilePath $postFile -Encoding UTF8

    Write-Host "Updated: $postFile" -ForegroundColor Green

    $count++
    $updated++
}

Write-Host ""
Write-Host "=== POST UPDATE COMPLETE ===" -ForegroundColor Cyan
Write-Host "Processed: $count posts" -ForegroundColor Green
Write-Host "Updated: $updated posts" -ForegroundColor Green