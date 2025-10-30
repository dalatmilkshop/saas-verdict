# PowerShell script to generate site links for saasverdict.com
# Usage: .\generate-site-links.ps1

param(
    [string]$RedirectsFile = "..\data\redirects.yaml",
    [string]$Domain = "https://saasverdict.com"
)

# Function to generate post URL slug
function Get-PostSlug {
    param([string]$Slug)

    # Convert slug to title case and create URL-friendly format
    $titleCase = (Get-Culture).TextInfo.ToTitleCase(($Slug -replace '-', ' ').ToLower())
    $urlSlug = $Slug.ToLower() -replace '[^a-z0-9]+', '-'
    return "$urlSlug-review-2026-best-software-tools"
}

# Function to generate site links
function Generate-SiteLinks {
    param([string]$FilePath, [string]$BaseDomain)

    try {
        # Read redirects file
        $content = Get-Content $FilePath -Raw

        # Parse YAML
        $redirects = @{}
        $lines = $content -split "`n"
        foreach ($line in $lines) {
            if ($line -match '^(\w+[^:]*):\s*(.+)$') {
                $slug = $matches[1].Trim()
                $url = $matches[2].Trim()
                $redirects[$slug] = $url
            }
        }

        Write-Host "=== SAASVERDICT.COM LINKS ===" -ForegroundColor Cyan
        Write-Host "Domain: $BaseDomain" -ForegroundColor White
        Write-Host ""

        # Generate links for each tool
        $links = @()
        foreach ($slug in ($redirects.Keys | Sort-Object)) {
            $postSlug = Get-PostSlug -Slug $slug
            $postUrl = "$BaseDomain/posts/$postSlug/"
            $affUrl = "$BaseDomain/go/$slug"

            $link = [PSCustomObject]@{
                Slug = $slug
                PostURL = $postUrl
                AffiliateURL = $affUrl
                AffiliateTarget = $redirects[$slug]
            }

            $links += $link

            Write-Host "=== $slug ===" -ForegroundColor Yellow
            Write-Host "Post: $postUrl" -ForegroundColor Green
            Write-Host "Affiliate: $affUrl" -ForegroundColor Cyan
            Write-Host "Target: $($redirects[$slug])" -ForegroundColor Gray
            Write-Host ""
        }

        # Export to CSV for easy sharing
        $csvPath = Join-Path $PSScriptRoot "saasverdict-links.csv"
        $links | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

        Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
        Write-Host "Total tools: $($links.Count)" -ForegroundColor White
        Write-Host "CSV exported: $csvPath" -ForegroundColor Green
        Write-Host ""
        Write-Host "Copy these links to share on forums:" -ForegroundColor White
        Write-Host "1. Post URLs: For linking to reviews" -ForegroundColor Green
        Write-Host "2. Affiliate URLs: For monetization (/go/ redirects)" -ForegroundColor Cyan

    } catch {
        Write-Host "Error generating links: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Run the generation
Generate-SiteLinks -FilePath (Join-Path $PSScriptRoot $RedirectsFile) -BaseDomain $Domain