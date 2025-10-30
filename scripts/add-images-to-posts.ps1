# PowerShell script to add placeholder images to Hugo posts
# Usage: .\add-images-to-posts.ps1

param(
    [string]$PostsPath = "..\content\en\posts"
)

# Function to get category-based image URL
function Get-CategoryImageUrl {
    param([string]$Category)

    $categoryImages = @{
        "VPN & Security" = "https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=400&fit=crop&crop=center"
        "Productivity & Business" = "https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=400&fit=crop&crop=center"
        "Marketing & SEO" = "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=400&fit=crop&crop=center"
        "Development & Design" = "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800&h=400&fit=crop&crop=center"
        "Cloud & Hosting" = "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=400&fit=crop&crop=center"
        "E-commerce" = "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&h=400&fit=crop&crop=center"
        "Communication" = "https://images.unsplash.com/photo-1577563908411-5077b6dc7624?w=800&h=400&fit=crop&crop=center"
        "Finance & Accounting" = "https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800&h=400&fit=crop&crop=center"
        "Education & Learning" = "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=400&fit=crop&crop=center"
        "Health & Fitness" = "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&h=400&fit=crop&crop=center"
        "Gaming & Entertainment" = "https://images.unsplash.com/photo-1511512578047-dfb367046420?w=800&h=400&fit=crop&crop=center"
        "Hardware & Gadgets" = "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800&h=400&fit=crop&crop=center"
        "Software Tools" = "https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=400&fit=crop&crop=center"
    }

    if ($categoryImages.ContainsKey($Category)) {
        return $categoryImages[$Category]
    } else {
        return "https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=400&fit=crop&crop=center"
    }
}

# Function to add images to post content
function Add-ImagesToPost {
    param([string]$FilePath)

    try {
        $content = Get-Content $FilePath -Raw

        # Extract category from frontmatter
        $frontmatterMatch = [regex]::Match($content, 'category:\s*"([^"]+)"')
        if ($frontmatterMatch.Success) {
            $category = $frontmatterMatch.Groups[1].Value
            $imageUrl = Get-CategoryImageUrl -Category $category

            # Extract slug from filename
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
            $titleCaseSlug = (Get-Culture).TextInfo.ToTitleCase(($fileName -replace '-', ' ').ToLower())

            # Create image markdown
            $heroImage = "![$titleCaseSlug interface]($imageUrl)"

            # Find the position after frontmatter
            $frontmatterEnd = $content.IndexOf('---', 4) + 3
            $frontmatter = $content.Substring(0, $frontmatterEnd)
            $bodyContent = $content.Substring($frontmatterEnd).Trim()

            # Add image field to frontmatter
            $frontmatterWithImage = $frontmatter.TrimEnd() -replace '---$', "image: `"$imageUrl`"`n---"

            # Add hero image at the beginning of body
            $newContent = "$frontmatterWithImage`n`n$heroImage`n`n$bodyContent"

            # Replace the content
            $newContent | Set-Content -Path $FilePath -Encoding UTF8
            Write-Host "Added images to: $fileName"
            return $true
        } else {
            Write-Host "Could not find category in: $fileName"
            return $false
        }
    } catch {
        Write-Host "Error processing $FilePath : $($_.Exception.Message)"
        return $false
    }
}

# Main function
function Add-ImagesToAllPosts {
    try {
        $postsDir = Join-Path $PSScriptRoot $PostsPath
        $postFiles = Get-ChildItem -Path $postsDir -Filter "*.md"

        Write-Host "Found $($postFiles.Count) posts to process"

        $processed = 0
        $skipped = 0

        foreach ($file in $postFiles) {
            if (Add-ImagesToPost -FilePath $file.FullName) {
                $processed++
            } else {
                $skipped++
            }
        }

        Write-Host ""
        Write-Host "Image addition complete!"
        Write-Host "Processed: $processed posts"
        Write-Host "Skipped: $skipped posts"

    } catch {
        Write-Host "Error: $($_.Exception.Message)"
        exit 1
    }
}

# Run the script
Add-ImagesToAllPosts