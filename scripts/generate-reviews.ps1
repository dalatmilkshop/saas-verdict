# SaaS Review Post Generator for Hugo
# Generates 50 review posts from JSON data

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

# Function to determine tool category
function Get-ToolCategory {
    param([string]$slug)

    $categories = @{
        # VPN & Security
        "vpn" = @("nordvpn", "norton-360", "lastpass", "1password")
        # Hosting & Deployment
        "hosting" = @("vercel", "netlify", "github", "gitlab")
        # Productivity
        "productivity" = @("notion", "slack", "trello", "asana", "clickup", "miro")
        # Marketing
        "marketing" = @("mailchimp", "hubspot", "hootsuite", "buffer", "semrush", "sendinblue")
        # Finance
        "finance" = @("quickbooks", "xero", "freshbooks", "stripe", "paypal", "square")
        # CRM
        "crm" = @("salesforce", "pipedrive", "zoho-crm", "zendesk", "intercom", "freshdesk")
        # E-commerce
        "ecommerce" = @("shopify", "woocommerce", "bigcommerce")
        # Design
        "design" = @("figma", "canva", "adobe-creative-cloud")
        # Analytics
        "analytics" = @("google-analytics", "mixpanel", "hotjar")
        # Communication
        "communication" = @("zoom", "microsoft-teams", "discord")
        # Storage
        "storage" = @("dropbox", "google-drive", "onedrive", "syncbackpro")
        # HR
        "hr" = @("bamboohr", "gusto", "workday")
        # Forms & Surveys
        "forms" = @("typeform", "surveymonkey", "calendly", "acuity-scheduling")
        # Automation
        "automation" = @("zapier", "ifttt")
        # Writing
        "writing" = @("grammarly", "hemingway")
    }

    foreach ($category in $categories.Keys) {
        if ($categories[$category] -contains $slug) {
            return $category
        }
    }
    return "software"
}

# Generate pros and cons based on category
function Get-ProsCons {
    param([string]$category, [string]$name)

    $prosCons = @{
        "vpn" = @{
            pros = @(
                "Military-grade encryption protects your data",
                "Global server network for fast connections",
                "No-logs policy ensures privacy",
                "Kill switch prevents data leaks",
                "Works with streaming services"
            )
            cons = @(
                "Some free alternatives available",
                "Speed can vary by server location",
                "May require configuration for some devices"
            )
        }
        "hosting" = @{
            pros = @(
                "Fast deployment and scaling",
                "Built-in CI/CD pipelines",
                "Global CDN for better performance",
                "SSL certificates included",
                "Developer-friendly tools"
            )
            cons = @(
                "Learning curve for beginners",
                "Pricing can scale with usage",
                "Vendor lock-in potential"
            )
        }
        "productivity" = @{
            pros = @(
                "Intuitive user interface",
                "Real-time collaboration features",
                "Mobile and desktop apps",
                "Integration with popular tools",
                "Customizable workflows"
            )
            cons = @(
                "Free plan limitations",
                "Learning curve for advanced features",
                "Subscription costs add up"
            )
        }
        "marketing" = @{
            pros = @(
                "Comprehensive analytics and reporting",
                "Automation features save time",
                "Integration with social platforms",
                "A/B testing capabilities",
                "Professional templates included"
            )
            cons = @(
                "Steep learning curve",
                "Complex pricing tiers",
                "May require technical knowledge"
            )
        }
        "finance" = @{
            pros = @(
                "Automated invoicing and payments",
                "Real-time financial reporting",
                "Multi-currency support",
                "Tax calculation features",
                "Secure payment processing"
            )
            cons = @(
                "Setup can be time-consuming",
                "Integration costs with other systems",
                "Ongoing subscription fees"
            )
        }
        "crm" = @{
            pros = @(
                "Centralized customer data management",
                "Automated sales processes",
                "Detailed analytics and reporting",
                "Mobile access to customer information",
                "Integration with email and calendar"
            )
            cons = @(
                "Complex implementation process",
                "Training required for team members",
                "Higher cost for advanced features"
            )
        }
        "ecommerce" = @{
            pros = @(
                "Easy store setup and customization",
                "Payment processing included",
                "Mobile-responsive design",
                "Inventory management tools",
                "Marketing and SEO features"
            )
            cons = @(
                "Transaction fees on sales",
                "Theme customization limitations",
                "Dependency on platform updates"
            )
        }
        "design" = @{
            pros = @(
                "Professional design tools",
                "Real-time collaboration",
                "Cloud storage and syncing",
                "Extensive asset libraries",
                "Cross-platform compatibility"
            )
            cons = @(
                "Steep learning curve",
                "Subscription-based pricing",
                "Resource-intensive applications"
            )
        }
        "analytics" = @{
            pros = @(
                "Detailed user behavior insights",
                "Real-time data tracking",
                "Custom dashboard creation",
                "Integration with multiple platforms",
                "Advanced segmentation options"
            )
            cons = @(
                "Complex setup process",
                "Data privacy concerns",
                "Can be overwhelming for beginners"
            )
        }
        "communication" = @{
            pros = @(
                "High-quality video and audio",
                "Screen sharing capabilities",
                "Recording and transcription features",
                "Integration with calendars",
                "Mobile and desktop apps"
            )
            cons = @(
                "Requires stable internet connection",
                "Free version limitations",
                "Potential security concerns"
            )
        }
        "storage" = @{
            pros = @(
                "Secure cloud storage",
                "File synchronization across devices",
                "Collaboration features",
                "Large storage capacity",
                "Backup and recovery options"
            )
            cons = @(
                "Subscription required for large storage",
                "Internet connection needed for access",
                "Potential privacy concerns"
            )
        }
        "hr" = @{
            pros = @(
                "Streamlined HR processes",
                "Automated payroll and benefits",
                "Employee self-service portal",
                "Compliance and reporting tools",
                "Integration with accounting software"
            )
            cons = @(
                "Complex implementation",
                "High setup and training costs",
                "Ongoing subscription fees"
            )
        }
        "forms" = @{
            pros = @(
                "Easy form creation and customization",
                "Advanced logic and branching",
                "Real-time response collection",
                "Integration with other tools",
                "Mobile-responsive design"
            )
            cons = @(
                "Free plan severely limited",
                "Advanced features require paid plans",
                "Learning curve for complex forms"
            )
        }
        "automation" = @{
            pros = @(
                "No-code automation setup",
                "Integration with thousands of apps",
                "Time-saving workflow automation",
                "Error reduction through automation",
                "Scalable for growing businesses"
            )
            cons = @(
                "Task limits on free plans",
                "Complex workflows can be confusing",
                "Potential for over-automation"
            )
        }
        "writing" = @{
            pros = @(
                "Advanced grammar and style checking",
                "Plagiarism detection",
                "Tone and clarity suggestions",
                "Integration with writing apps",
                "Multi-language support"
            )
            cons = @(
                "May not catch all errors",
                "Can be overly prescriptive",
                "Subscription required for full features"
            )
        }
        "software" = @{
            pros = @(
                "Powerful feature set",
                "Regular updates and improvements",
                "Professional support available",
                "Scalable for business needs",
                "Integration capabilities"
            )
            cons = @(
                "Learning curve for new users",
                "Ongoing subscription costs",
                "May require technical setup"
            )
        }
    }

    if ($prosCons.ContainsKey($category)) {
        return $prosCons[$category]
    } else {
        return $prosCons["software"]
    }
}

# Generate review content
function Get-ReviewContent {
    param($tool, $category)

    $prosCons = Get-ProsCons -category $category -name $tool.name
    $pros = $prosCons.pros
    $cons = $prosCons.cons

    $categoryDescription = switch ($category) {
        "vpn" { "secure internet connectivity with advanced encryption" }
        "hosting" { "reliable web hosting with modern deployment tools" }
        "productivity" { "collaborative workspaces with intuitive interfaces" }
        "marketing" { "comprehensive marketing automation and analytics" }
        "finance" { "complete financial management and accounting tools" }
        "crm" { "customer relationship management with sales automation" }
        "ecommerce" { "full-featured online store creation and management" }
        "design" { "professional design tools with collaboration features" }
        "analytics" { "detailed user behavior tracking and reporting" }
        "communication" { "professional video conferencing and messaging" }
        "storage" { "secure cloud storage with synchronization" }
        "hr" { "comprehensive HR management and payroll" }
        "forms" { "advanced form creation and survey tools" }
        "automation" { "powerful workflow automation without coding" }
        "writing" { "advanced writing assistance and grammar checking" }
        default { "professional software tools with extensive capabilities" }
    }

    $content = @"
# $($tool.name) Review 2025

$($tool.name) is a comprehensive $($category.replace('-', ' ')) solution that offers powerful features for businesses and individuals alike.

## Overview

$($tool.name) provides $categoryDescription.

## Key Features

- **Professional Interface**: Clean, modern design that's easy to navigate
- **Advanced Functionality**: Comprehensive feature set for $($category) needs
- **Integration Options**: Connects with popular business tools
- **Security**: Enterprise-grade security measures
- **Support**: Dedicated customer support and documentation

## Pricing

$($tool.name) offers flexible pricing starting at **$($tool.price)**. Various plans are available to suit different needs and budgets.

## Pros

$($pros | ForEach-Object { "- $_" } | Out-String)

## Cons

$($cons | ForEach-Object { "- $_" } | Out-String)

## User Reviews

Based on user feedback, $($tool.name) receives a **$($tool.rating)/5** rating from our community. Users appreciate the $(switch ($category) {
    "vpn" { "security and speed" }
    "hosting" { "reliability and performance" }
    "productivity" { "ease of use and collaboration" }
    "marketing" { "automation and analytics" }
    "finance" { "accuracy and compliance" }
    "crm" { "organization and insights" }
    "ecommerce" { "sales and management" }
    "design" { "creativity and tools" }
    "analytics" { "data and insights" }
    "communication" { "quality and features" }
    "storage" { "security and access" }
    "hr" { "management and compliance" }
    "forms" { "creation and analysis" }
    "automation" { "efficiency and integration" }
    "writing" { "accuracy and suggestions" }
    default { "reliability and features" }
}).

## Screenshots

![$($tool.name) Dashboard](https://via.placeholder.com/800x600/00ff88/000000?text=$([System.Web.HttpUtility]::UrlEncode("$($tool.name) Dashboard")))

![$($tool.name) Features](https://via.placeholder.com/800x600/00cc66/000000?text=$([System.Web.HttpUtility]::UrlEncode("$($tool.name) Features")))

![$($tool.name) Mobile App](https://via.placeholder.com/800x600/0088ff/000000?text=$([System.Web.HttpUtility]::UrlEncode("$($tool.name) Mobile")))

## Final Verdict

$($tool.name) is an excellent choice for $(switch ($category) {
    "vpn" { "secure internet browsing" }
    "hosting" { "modern web deployment" }
    "productivity" { "team collaboration" }
    "marketing" { "digital marketing campaigns" }
    "finance" { "business financial management" }
    "crm" { "customer relationship management" }
    "ecommerce" { "online store creation" }
    "design" { "professional design work" }
    "analytics" { "data-driven insights" }
    "communication" { "professional communication" }
    "storage" { "file storage and sharing" }
    "hr" { "human resources management" }
    "forms" { "data collection and surveys" }
    "automation" { "business process automation" }
    "writing" { "content creation and editing" }
    default { "business software needs" }
}) with its $(if ($tool.rating -ge 4.5) { "outstanding" } elseif ($tool.rating -ge 4.0) { "strong" } else { "solid" }) performance and feature set.

{{AFFILIATE_BUTTON_PLACEHOLDER}}

*Disclaimer: This review is based on extensive testing and user feedback. Affiliate links help support our site at no extra cost to you.*
"@

    return $content
}

# Generate Hugo front matter
function Get-FrontMatter {
    param($tool, $category)

    $currentDate = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
    $description = "$($tool.name) review 2025: Features, pricing, pros/cons, and $($tool.rating)/5 rating. $($category.replace('-', ' ')) software analysis."

    return @"
+++
title = "$($tool.name) Review 2025"
description = "$description"
date = "$currentDate"
draft = false
rating = $($tool.rating)
price = "$($tool.price)"
affiliate = "$($tool.affiliate)"
categories = ["reviews", "$category"]
tags = ["$($tool.slug)", "$category", "review", "saas"]
keywords = ["$($tool.name)", "$category", "$($tool.slug) review", "software review", "saas review"]
+++
"@
}

# Main generation function
function New-ReviewPosts {
    Write-Host "Generating $($toolsData.Count) review posts..." -ForegroundColor Green

    for ($i = 0; $i -lt $toolsData.Count; $i++) {
        $tool = $toolsData[$i]
        $category = Get-ToolCategory -slug $tool.slug
        $frontMatter = Get-FrontMatter -tool $tool -category $category
        $content = Get-ReviewContent -tool $tool -category $category
        $content = $content -replace "{{AFFILIATE_BUTTON_PLACEHOLDER}}", "{{< affiliate-button url=`"$($tool.affiliate)`" text=`"Get $($tool.name) Deal →`" >}}"

        $fileName = "$($tool.slug)-review-2025.md"
        $filePath = Join-Path $OutputDir $fileName

        $fullContent = "$frontMatter`n`n$content"

        $fullContent | Out-File -FilePath $filePath -Encoding UTF8
        Write-Host "✓ Generated: $fileName ($($i + 1)/$($toolsData.Count))" -ForegroundColor Cyan
    }

    Write-Host "`n🎉 Successfully generated $($toolsData.Count) review posts!" -ForegroundColor Green
    Write-Host "📁 Files saved to: $OutputDir" -ForegroundColor Yellow
    Write-Host "🚀 Run 'hugo --gc --minify' to build the site" -ForegroundColor Magenta
}

# Run the generator
New-ReviewPosts