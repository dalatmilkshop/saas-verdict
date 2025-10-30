# SaaS Verdict - Hugo Site Development Guide

## Architecture Overview
This is a multilingual Hugo static site for SaaS product reviews using the Ananke theme. The site supports 10 languages with content organized in `content/{lang}/` directories.

**Key Files:**
- `hugo.toml` - Main Hugo configuration with multilingual settings
- `config.toml` - Additional config (pagination, theme settings)
- `go.mod` - Go modules with local theme replacement
- `.github/workflows/hugo.yml` - GitHub Actions CI/CD pipeline

## Content Structure
- **Posts**: `content/posts/` (language-agnostic) and `content/{lang}/posts/` (language-specific)
- **Front Matter**: Use TOML format with `date`, `draft`, `title`, `description`, `tags`, `categories`, `rating`, `image` fields
- **Archetypes**: `archetypes/default.md` provides post templates
- **Languages**: 10 supported languages (en, vi, fr, es, de, it, pt, ru, ja, zh)

## Build & Development
- **Hugo Version**: Extended 0.128.0 (matches CI in `.github/workflows/hugo.yml`)
- **Theme**: Ananke (vendored locally via `replace` directive in `go.mod`)
- **Commands**:
  - Local development: `hugo server`
  - Production build: `hugo --gc --minify`
  - Clean build: `hugo --gc --minify`

## Multilingual Setup
- Default language: English (`en`)
- Content directories: `content/{lang}/` (e.g., `content/fr/posts/`)
- Language switching: Automatic based on URL structure (`/fr/`, `/es/`, etc.)
- Translation files: Located in theme's `i18n/` directory

## Module Configuration
- **Theme Module**: Uses vendored Ananke theme via Go modules
- **Replace Directive**: `go.mod` replaces `github.com/theNewDynamic/gohugo-theme-ananke/v2` with `./themes/ananke`
- **Module Import**: `config.toml` must reference the exact path with `/v2` suffix to match `go.mod`
- **Build Systems**: Cloudflare Pages and similar CI systems require proper module configuration

## Content Generation Automation
- **Data Sources**: `data/saas-tools.json` (tool metadata) and `data/redirects.yaml` (affiliate links)
- **Scripts**: PowerShell scripts in `scripts/` directory for bulk post generation
- **Post Structure**: Automated reviews with pros/cons, pricing, ratings based on categories
- **Categories**: Auto-categorized based on tool keywords (VPN, productivity, marketing, etc.)

## Affiliate Link System
- **Redirect Management**: Complex system using YAML data and Hugo shortcodes
- **Shortcodes**: `{{< affiliate-button slug="tool-name" text="Get Deal →" >}}` generates affiliate links
- **URL Structure**: `/go/tool-slug` redirects to affiliate URLs via `_redirects` file
- **Data Flow**: YAML data → Hugo shortcodes → generated HTML → Netlify/Cloudflare redirects

## Development Workflow
1. Create new posts: `hugo new posts/your-post.md`
2. Set `draft: false` to publish
3. Test locally: `hugo server` (serves on http://localhost:1313)
4. Commit and push to `master` for automatic deployment

## Key Conventions
- **Front Matter**: Always use TOML format (not YAML)
- **URLs**: Pretty URLs enabled via `permalinks.posts = "/posts/:slug/"`
- **Images**: Store in `static/images/` or use page resources
- **Taxonomies**: Categories and tags auto-generated from content
- **Post Titles**: Follow pattern "ToolName Review 2025 – Best Category?"
- **Slugs**: Kebab-case naming (e.g., `tool-name-review-2025`)

## Troubleshooting
- **Module Not Found**: Ensure `config.toml` module path matches `go.mod` replace directive exactly (including `/v2`)
- **Deprecated Config**: Remove any `paginate` keys - use `pagination.pagerSize` instead
- **Build Failures**: Test locally with `hugo --gc --minify` before pushing</content>
<parameter name="filePath">c:\Users\Admin\Documents\GitHub\saas-verdict\.github\copilot-instructions.md