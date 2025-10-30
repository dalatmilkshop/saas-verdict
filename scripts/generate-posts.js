const fs = require('fs');
const path = require('path');

// Function to convert object to YAML string
function objectToYAML(obj) {
  const lines = [];
  for (const [key, value] of Object.entries(obj)) {
    if (typeof value === 'string') {
      lines.push(`${key}: "${value}"`);
    } else {
      lines.push(`${key}: ${value}`);
    }
  }
  return lines.join('\n');
}

// Function to categorize tools based on keywords
function categorizeTool(slug, url) {
  const lowerSlug = slug.toLowerCase();
  const lowerUrl = url.toLowerCase();

  // VPN & Security
  if (lowerSlug.includes('vpn') || lowerSlug.includes('security') || lowerSlug.includes('antivirus') ||
      lowerSlug.includes('firewall') || lowerSlug.includes('encryption') || lowerSlug.includes('privacy')) {
    return 'VPN & Security';
  }

  // Productivity & Business
  if (lowerSlug.includes('crm') || lowerSlug.includes('project') || lowerSlug.includes('task') ||
      lowerSlug.includes('calendar') || lowerSlug.includes('email') || lowerSlug.includes('business') ||
      lowerSlug.includes('workflow') || lowerSlug.includes('automation')) {
    return 'Productivity & Business';
  }

  // Marketing & SEO
  if (lowerSlug.includes('seo') || lowerSlug.includes('marketing') || lowerSlug.includes('analytics') ||
      lowerSlug.includes('social') || lowerSlug.includes('content') || lowerSlug.includes('advertising') ||
      lowerSlug.includes('email') || lowerSlug.includes('campaign')) {
    return 'Marketing & SEO';
  }

  // Development & Design
  if (lowerSlug.includes('code') || lowerSlug.includes('dev') || lowerSlug.includes('design') ||
      lowerSlug.includes('editor') || lowerSlug.includes('ide') || lowerSlug.includes('programming') ||
      lowerSlug.includes('web') || lowerSlug.includes('app')) {
    return 'Development & Design';
  }

  // Cloud & Hosting
  if (lowerSlug.includes('cloud') || lowerSlug.includes('hosting') || lowerSlug.includes('server') ||
      lowerSlug.includes('storage') || lowerSlug.includes('database') || lowerSlug.includes('aws') ||
      lowerSlug.includes('azure') || lowerSlug.includes('digitalocean')) {
    return 'Cloud & Hosting';
  }

  // E-commerce
  if (lowerSlug.includes('shop') || lowerSlug.includes('store') || lowerSlug.includes('commerce') ||
      lowerSlug.includes('payment') || lowerSlug.includes('cart') || lowerSlug.includes('woocommerce')) {
    return 'E-commerce';
  }

  // Communication
  if (lowerSlug.includes('chat') || lowerSlug.includes('messenger') || lowerSlug.includes('video') ||
      lowerSlug.includes('call') || lowerSlug.includes('meeting') || lowerSlug.includes('slack') ||
      lowerSlug.includes('teams') || lowerSlug.includes('zoom')) {
    return 'Communication';
  }

  // Finance & Accounting
  if (lowerSlug.includes('finance') || lowerSlug.includes('accounting') || lowerSlug.includes('invoice') ||
      lowerSlug.includes('billing') || lowerSlug.includes('tax') || lowerSlug.includes('payroll')) {
    return 'Finance & Accounting';
  }

  // Education & Learning
  if (lowerSlug.includes('learn') || lowerSlug.includes('course') || lowerSlug.includes('education') ||
      lowerSlug.includes('training') || lowerSlug.includes('tutorial') || lowerSlug.includes('skill')) {
    return 'Education & Learning';
  }

  // Health & Fitness
  if (lowerSlug.includes('health') || lowerSlug.includes('fitness') || lowerSlug.includes('medical') ||
      lowerSlug.includes('wellness') || lowerSlug.includes('diet') || lowerSlug.includes('exercise')) {
    return 'Health & Fitness';
  }

  // Gaming & Entertainment
  if (lowerSlug.includes('game') || lowerSlug.includes('gaming') || lowerSlug.includes('entertainment') ||
      lowerSlug.includes('music') || lowerSlug.includes('video') || lowerSlug.includes('stream')) {
    return 'Gaming & Entertainment';
  }

  // Hardware & Gadgets
  if (lowerSlug.includes('hardware') || lowerSlug.includes('gadget') || lowerSlug.includes('device') ||
      lowerSlug.includes('laptop') || lowerSlug.includes('phone') || lowerSlug.includes('tablet')) {
    return 'Hardware & Gadgets';
  }

  // Default category
  return 'Software Tools';
}

// Function to capitalize first letter of each word
function titleCase(str) {
  return str.replace(/\w\S*/g, (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase());
}

// Function to generate placeholder content
function generateContent(slug, category) {
  const titleCaseSlug = titleCase(slug.replace(/-/g, ' '));

  return `# ${titleCaseSlug} Review 2026: Is It Worth Your Investment?

${titleCaseSlug} has been making waves in the ${category.toLowerCase()} space, promising innovative solutions for modern businesses and individuals. In this comprehensive review, we'll dive deep into what makes ${titleCaseSlug} stand out from the competition.

## What is ${titleCaseSlug}?

${titleCaseSlug} is a powerful ${category.toLowerCase()} tool designed to streamline workflows and enhance productivity. Whether you're a small business owner, freelancer, or enterprise user, ${titleCaseSlug} offers features that can transform how you work.

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
- Users seeking reliable ${category.toLowerCase()} solutions

## Getting Started with ${titleCaseSlug}

Setting up ${titleCaseSlug} is straightforward. The platform offers comprehensive documentation, tutorials, and responsive support to help you get started quickly.

## ${titleCaseSlug} vs Competitors

When compared to similar tools, ${titleCaseSlug} stands out with its unique combination of features, ease of use, and excellent value proposition.

## Final Verdict

${titleCaseSlug} proves to be a reliable and feature-rich solution in the ${category.toLowerCase()} category. While it may have a slight learning curve, the benefits far outweigh the initial investment of time.

{{< aff-button slug="${slug}" text="Get ${titleCaseSlug} Deal →" >}}

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

*This ${titleCaseSlug} review was last updated in 2026. Prices and features may vary. Always check the official website for the most current information.*`;
}

// Main function
function generatePosts() {
  try {
    // Read the redirects YAML file
    const redirectsPath = path.join(__dirname, '..', 'data', 'redirects.yaml');
    const redirectsContent = fs.readFileSync(redirectsPath, 'utf8');
    const redirects = parseSimpleYAML(redirectsContent);

    console.log(`Found ${Object.keys(redirects).length} tools to process`);

    // Create posts directory if it doesn't exist
    const postsDir = path.join(__dirname, '..', 'content', 'en', 'posts');
    if (!fs.existsSync(postsDir)) {
      fs.mkdirSync(postsDir, { recursive: true });
    }

    let generated = 0;
    let skipped = 0;

    // Generate posts for each redirect
    for (const [slug, url] of Object.entries(redirects)) {
      const category = categorizeTool(slug, url);
      const titleCaseSlug = titleCase(slug.replace(/-/g, ' '));

      // Create frontmatter
      const frontmatter = {
        title: `${titleCaseSlug} Review 2026 – Best ${category}?`,
        date: new Date().toISOString().split('T')[0],
        draft: false,
        rating: 4.8,
        category: category,
        tags: [category.toLowerCase().replace(' & ', '-').replace(' ', '-'), 'review', '2026'],
        description: `Comprehensive ${titleCaseSlug} review 2026. Discover if this ${category.toLowerCase()} tool is the best choice for your needs.`,
        keywords: `${slug}, ${titleCaseSlug}, review, ${category.toLowerCase()}, 2026, best ${category.toLowerCase()}`
      };

      // Generate content
      const content = generateContent(slug, category);

      // Create the full post content
      const postContent = `---
${objectToYAML(frontmatter)}
---

${content}`;

      // Write the file
      const filename = `${slug}.md`;
      const filepath = path.join(postsDir, filename);

      try {
        fs.writeFileSync(filepath, postContent, 'utf8');
        console.log(`✓ Generated: ${filename}`);
        generated++;
      } catch (error) {
        console.error(`✗ Failed to write ${filename}:`, error.message);
        skipped++;
      }
    }

    console.log(`\n🎉 Generation complete!`);
    console.log(`📝 Generated: ${generated} posts`);
    console.log(`⏭️  Skipped: ${skipped} posts`);
    console.log(`📁 Posts saved to: ${postsDir}`);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

// Run the script
generatePosts();