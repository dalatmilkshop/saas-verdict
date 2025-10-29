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
- **Front Matter**: Use TOML format with `date`, `draft`, `title` fields
- **Archetypes**: `archetypes/default.md` provides post templates
- **Languages**: 10 supported languages (en, vi, fr, es, de, it, pt, ru, ja, zh)

## Build & Development
- **Hugo Version**: Extended 0.128.0 (matches CI in `.github/workflows/hugo.yml`)
- **Theme**: Ananke (vendored locally via `replace` directive in `go.mod`)
- **Commands**:
  - Local development: `hugo server`
  - Production build: `hugo --minify`
  - Clean build: `hugo --gc --minify`

## Multilingual Setup
- Default language: English (`en`)
- Content directories: `content/{lang}/` (e.g., `content/fr/posts/`)
- Language switching: Automatic based on URL structure (`/fr/`, `/es/`, etc.)
- Translation files: Located in theme's `i18n/` directory

## Theme Customization
- **CSS Framework**: Tachyons (via Ananke theme)
- **No Custom Layouts**: All layouts inherited from vendored Ananke theme
- **Assets**: Place custom CSS/JS in `assets/` directory
- **Static Files**: Use `static/` for images, documents, etc.

## Deployment
- **Platform**: GitHub Pages
- **Trigger**: Push to `master` branch
- **Build Environment**: Ubuntu with Hugo extended + Dart Sass
- **Base URL**: Set via `baseURL` in `hugo.toml` (currently placeholder)

## Development Workflow
1. Create new posts: `hugo new posts/your-post.md`
2. Set `draft: false` to publish
3. Test locally: `hugo server` (serves on http://localhost:1313)
4. Commit and push to `master` for automatic deployment

## Key Conventions
- **Front Matter**: Always use TOML format (not YAML)
- **URLs**: Pretty URLs enabled via `permalinks.posts = "/posts/:slug/"`
- **Images**: Store in `static/images/` or use page resources
- **Taxonomies**: Categories and tags auto-generated from content</content>
<parameter name="filePath">c:\Users\Admin\Documents\GitHub\saas-verdict\.github\copilot-instructions.md