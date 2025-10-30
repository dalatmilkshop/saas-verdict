# PowerShell script to generate Hugo review posts from redirects.yaml
# Usage: .\generate-posts.ps1

param(
    [string]$OutputPath = "content\en\posts"
)

# Function to categorize tools based on keywords
function Get-ToolCategory {
    param([string]$Slug, [string]$Url)

    $lowerSlug = $Slug.ToLower()
    $lowerUrl = $Url.ToLower()

    # VPN & Security
    if ($lowerSlug -match 'vpn|security|antivirus|firewall|encryption|privacy') {
        return 'VPN & Security'
    }

    # Productivity & Business
    if ($lowerSlug -match 'crm|project|task|calendar|email|business|workflow|automation') {
        return 'Productivity & Business'
    }

    # Marketing & SEO
    if ($lowerSlug -match 'seo|marketing|analytics|social|content|advertising|campaign') {
        return 'Marketing & SEO'
    }

    # Development & Design
    if ($lowerSlug -match 'code|dev|design|editor|ide|programming|web|app') {
        return 'Development & Design'
    }

    # Cloud & Hosting
    if ($lowerSlug -match 'cloud|hosting|server|storage|database|aws|azure|digitalocean') {
        return 'Cloud & Hosting'
    }

    # E-commerce
    if ($lowerSlug -match 'shop|store|commerce|payment|cart|woocommerce') {
        return 'E-commerce'
    }

    # Communication
    if ($lowerSlug -match 'chat|messenger|video|call|meeting|slack|teams|zoom') {
        return 'Communication'
    }

    # Finance & Accounting
    if ($lowerSlug -match 'finance|accounting|invoice|billing|tax|payroll') {
        return 'Finance & Accounting'
    }

    # Education & Learning
    if ($lowerSlug -match 'learn|course|education|training|tutorial|skill') {
        return 'Education & Learning'
    }

    # Health & Fitness
    if ($lowerSlug -match 'health|fitness|medical|wellness|diet|exercise') {
        return 'Health & Fitness'
    }

    # Gaming & Entertainment
    if ($lowerSlug -match 'game|gaming|entertainment|music|stream') {
        return 'Gaming & Entertainment'
    }

    # Hardware & Gadgets
    if ($lowerSlug -match 'hardware|gadget|device|laptop|phone|tablet') {
        return 'Hardware & Gadgets'
    }

    # Default category
    return 'Software Tools'
}

# Function to convert string to title case
function Convert-ToTitleCase {
    param([string]$Text)
    return (Get-Culture).TextInfo.ToTitleCase($Text.ToLower())
}

# Function to generate post content
function New-PostContent {
    param([string]$Slug, [string]$Category)

    $titleCaseSlug = Convert-ToTitleCase ($Slug -replace '-', ' ')

    return @"
# ${titleCaseSlug} Review 2026: Is It Worth Your Investment?

${titleCaseSlug} has been making waves in the ${Category.ToLower()} space, promising innovative solutions for modern businesses and individuals. In this comprehensive review, we'll dive deep into what makes ${titleCaseSlug} stand out from the competition.

## What is ${titleCaseSlug}?

${titleCaseSlug} is a powerful ${Category.ToLower()} tool designed to streamline workflows and enhance productivity. Whether you're a small business owner, freelancer, or enterprise user, ${titleCaseSlug} offers features that can transform how you work.

## Key Features & Benefits

### Advanced Functionality
${titleCaseSlug} comes packed with advanced features that set it apart from basic alternatives. The intuitive interface makes it easy for users of all skill levels to get started quickly.

### Seamless Integration
One of the standout features of ${titleCaseSlug} is its ability to integrate seamlessly with popular tools and platforms. This ensures a smooth workflow without unnecessary complications.

### Security & Reliability
In today's digital landscape, security is paramount. ${titleCaseSlug} prioritizes data protection with robust security measures and reliable performance.

## ${titleCaseSlug} Pricing & Plans

${titleCaseSlug} offers flexible pricing options to suit different needs and budgets. From individual users to large enterprises, there's a plan that fits.

## Pros & Cons

### Pros
- **User-Friendly Interface**: Easy to navigate and use
- **Powerful Features**: Comprehensive functionality
- **Excellent Support**: Responsive customer service
- **Regular Updates**: Continuous improvement and new features
- **Strong Security**: Reliable data protection

### Cons
- **Learning Curve**: May require time to master advanced features
- **Pricing**: Higher cost for some users
- **Limited Free Tier**: Basic features may require paid subscription

## Who Should Use ${titleCaseSlug}?

${titleCaseSlug} is ideal for:
- Small to medium-sized businesses
- Freelancers and consultants
- Teams requiring collaboration tools
- Organizations focused on productivity
- Users seeking reliable ${Category.ToLower()} solutions

## Getting Started with ${titleCaseSlug}

Setting up ${titleCaseSlug} is straightforward. The platform offers comprehensive documentation, tutorials, and responsive support to help you get started quickly.

## ${titleCaseSlug} vs Competitors

When compared to similar tools, ${titleCaseSlug} stands out with its unique combination of features, ease of use, and excellent value proposition.

## Final Verdict

${titleCaseSlug} proves to be a reliable and feature-rich solution in the ${Category.ToLower()} category. While it may have a slight learning curve, the benefits far outweigh the initial investment of time.

{{< aff-button slug="${Slug}" text="Get ${titleCaseSlug} Deal →" >}}

## Frequently Asked Questions

**Is ${titleCaseSlug} easy to use?**
Yes, ${titleCaseSlug} features an intuitive interface that makes it accessible to users of all skill levels.

**What kind of support does ${titleCaseSlug} offer?**
${titleCaseSlug} provides comprehensive support including documentation, tutorials, and responsive customer service.

**Can ${titleCaseSlug} integrate with other tools?**
Absolutely! ${titleCaseSlug} offers seamless integration with many popular platforms and tools.

**Is ${titleCaseSlug} secure?**
Security is a top priority for ${titleCaseSlug}, with robust measures to protect your data.

**What are the pricing options?**
${titleCaseSlug} offers flexible pricing plans to suit different needs and budgets.

---

*This ${titleCaseSlug} review was last updated in 2026. Prices and features may vary. Always check the official website for the most current information.*
"@
}

# Main function
function Generate-Posts {
    try {
        # Read the redirects YAML file
        $redirectsPath = Join-Path $PSScriptRoot "..\data\redirects.yaml"
        $redirectsContent = Get-Content $redirectsPath -Raw

        # Parse YAML (simple key: value format)
        $redirects = @{}
        $lines = $redirectsContent -split "`n"
        foreach ($line in $lines) {
            $line = $line.Trim()
            if ($line -and -not $line.StartsWith('#')) {
                $colonIndex = $line.IndexOf(':')
                if ($colonIndex -gt 0) {
                    $key = $line.Substring(0, $colonIndex).Trim()
                    $value = $line.Substring($colonIndex + 1).Trim()
                    if ($key -and $value) {
                        $redirects[$key] = $value
                    }
                }
            }
        }

        Write-Host "Found $($redirects.Count) tools to process"

        # Create posts directory if it doesn't exist
        $postsDir = Join-Path $PSScriptRoot $OutputPath
        if (-not (Test-Path $postsDir)) {
            New-Item -ItemType Directory -Path $postsDir -Force | Out-Null
        }

        $generated = 0
        $skipped = 0

        # Generate posts for each redirect
        foreach ($entry in $redirects.GetEnumerator()) {
            $slug = $entry.Key
            $url = $entry.Value
            $category = Get-ToolCategory -Slug $slug -Url $url
            $titleCaseSlug = Convert-ToTitleCase ($slug -replace '-', ' ')

            # Create frontmatter
            $currentDate = Get-Date -Format "yyyy-MM-dd"
            $frontmatter = @"
title: "${titleCaseSlug} Review 2026 – Best ${category}?"
date: ${currentDate}
draft: false
rating: 4.8
category: "${category}"
tags: ["$($category.ToLower() -replace ' & ', '-' -replace ' ', '-')", "review", "2026"]
description: "Comprehensive ${titleCaseSlug} review 2026. Discover if this ${category.ToLower()} tool is the best choice for your needs."
keywords: "${slug}, ${titleCaseSlug}, review, $($category.ToLower()), 2026, best $($category.ToLower())"
"@

            # Generate content
            $content = New-PostContent -Slug $slug -Category $category

            # Create the full post content
            $postContent = @"
---
${frontmatter}
---

${content}
"@

            # Write the file
            $filename = "${slug}.md"
            $filepath = Join-Path $postsDir $filename

            try {
                $postContent | Out-File -FilePath $filepath -Encoding UTF8 -Force
                Write-Host "Generated: ${filename}"
                $generated++
            } catch {
                Write-Host "Failed to write ${filename}: $($_.Exception.Message)"
                $skipped++
            }
        }

        Write-Host ""
        Write-Host "Generation complete!"
        Write-Host "Generated: ${generated} posts"
        Write-Host "Skipped: ${skipped} posts"
        Write-Host "Posts saved to: ${postsDir}"

    } catch {
        Write-Host "Error: $($_.Exception.Message)"
        exit 1
    }
}

# Run the script
Generate-Posts