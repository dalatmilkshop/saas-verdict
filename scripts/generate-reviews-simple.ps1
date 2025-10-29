# SaaS Review Post Generator (Simplified)
# Generates review posts from JSON data

param(
    [string]$InputFile = ".\data\saas-tools.json",
    [string]$OutputDir = ".\content\en\posts"
)

# Create output directory if it doesn't exist
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# Read the tools data
$toolsData = Get-Content $InputFile -Raw | ConvertFrom-Json

Write-Host "Generating $($toolsData.Count) review posts..." -ForegroundColor Green

for ($i = 0; $i -lt $toolsData.Count; $i++) {
    $tool = $toolsData[$i]

    # Simple front matter
    $frontMatter = @"
+++
title = "$($tool.name) Review 2025"
description = "$($tool.name) review 2025: Features, pricing, and $($tool.rating)/5 rating."
date = "$(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz')"
draft = false
rating = $($tool.rating)
price = "$($tool.price)"
affiliate = "$($tool.affiliate)"
categories = ["reviews"]
tags = ["$($tool.slug)", "review", "saas"]
+++
"@

    # Simple content
    $content = @"
# $($tool.name) Review 2025

$($tool.name) is a comprehensive software solution with powerful features.

## Overview

$($tool.name) provides excellent functionality for users.

## Pricing

$($tool.name) offers pricing starting at **$($tool.price)**.

## User Reviews

Based on user feedback, $($tool.name) receives a **$($tool.rating)/5** rating.

## Final Verdict

$($tool.name) is an excellent choice with its strong performance.

{{< affiliate-button url="$($tool.affiliate)" text="Get $($tool.name) Deal →" >}}

*Disclaimer: This review is based on testing and user feedback.*
"@

    $fileName = "$($tool.slug)-review-2025.md"
    $filePath = Join-Path $OutputDir $fileName

    $fullContent = "$frontMatter`n`n$content"

    $fullContent | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "✓ Generated: $fileName ($($i + 1)/$($toolsData.Count))" -ForegroundColor Cyan
}

Write-Host "`n🎉 Successfully generated $($toolsData.Count) review posts!" -ForegroundColor Green
Write-Host "📁 Files saved to: $OutputDir" -ForegroundColor Yellow
Write-Host "🚀 Run 'hugo --gc --minify' to build the site" -ForegroundColor Magenta