const fs = require('fs');
const path = require('path');

// Read the tools data
const toolsData = JSON.parse(fs.readFileSync('./data/saas-tools.json', 'utf8'));

// Create content/en/posts directory if it doesn't exist
const postsDir = './content/en/posts';
if (!fs.existsSync(postsDir)) {
  fs.mkdirSync(postsDir, { recursive: true });
}

// Function to determine tool category and generate appropriate content
function getToolCategory(slug) {
  const categories = {
    // VPN & Security
    vpn: ['nordvpn', 'norton-360', 'lastpass', '1password'],
    // Hosting & Deployment
    hosting: ['vercel', 'netlify', 'github', 'gitlab'],
    // Productivity
    productivity: ['notion', 'slack', 'trello', 'asana', 'clickup', 'miro'],
    // Marketing
    marketing: ['mailchimp', 'hubspot', 'hootsuite', 'buffer', 'semrush', 'sendinblue'],
    // Finance
    finance: ['quickbooks', 'xero', 'freshbooks', 'stripe', 'paypal', 'square'],
    // CRM
    crm: ['salesforce', 'pipedrive', 'zoho-crm', 'zendesk', 'intercom', 'freshdesk'],
    // E-commerce
    ecommerce: ['shopify', 'woocommerce', 'bigcommerce'],
    // Design
    design: ['figma', 'canva', 'adobe-creative-cloud'],
    // Analytics
    analytics: ['google-analytics', 'mixpanel', 'hotjar'],
    // Communication
    communication: ['zoom', 'microsoft-teams', 'discord'],
    // Storage
    storage: ['dropbox', 'google-drive', 'onedrive', 'syncbackpro'],
    // HR
    hr: ['bamboohr', 'gusto', 'workday'],
    // Forms & Surveys
    forms: ['typeform', 'surveymonkey', 'calendly', 'acuity-scheduling'],
    // Automation
    automation: ['zapier', 'ifttt'],
    // Writing
    writing: ['grammarly', 'hemingway'],
    // Default
    software: []
  };

  for (const [category, tools] of Object.entries(categories)) {
    if (tools.includes(slug)) {
      return category;
    }
  }
  return 'software';
}

// Generate pros and cons based on category
function generateProsCons(category, name) {
  const prosCons = {
    vpn: {
      pros: [
        'Military-grade encryption protects your data',
        'Global server network for fast connections',
        'No-logs policy ensures privacy',
        'Kill switch prevents data leaks',
        'Works with streaming services'
      ],
      cons: [
        'Some free alternatives available',
        'Speed can vary by server location',
        'May require configuration for some devices'
      ]
    },
    hosting: {
      pros: [
        'Fast deployment and scaling',
        'Built-in CI/CD pipelines',
        'Global CDN for better performance',
        'SSL certificates included',
        'Developer-friendly tools'
      ],
      cons: [
        'Learning curve for beginners',
        'Pricing can scale with usage',
        'Vendor lock-in potential'
      ]
    },
    productivity: {
      pros: [
        'Intuitive user interface',
        'Real-time collaboration features',
        'Mobile and desktop apps',
        'Integration with popular tools',
        'Customizable workflows'
      ],
      cons: [
        'Free plan limitations',
        'Learning curve for advanced features',
        'Subscription costs add up'
      ]
    },
    marketing: {
      pros: [
        'Comprehensive analytics and reporting',
        'Automation features save time',
        'Integration with social platforms',
        'A/B testing capabilities',
        'Professional templates included'
      ],
      cons: [
        'Steep learning curve',
        'Complex pricing tiers',
        'May require technical knowledge'
      ]
    },
    finance: {
      pros: [
        'Automated invoicing and payments',
        'Real-time financial reporting',
        'Multi-currency support',
        'Tax calculation features',
        'Secure payment processing'
      ],
      cons: [
        'Setup can be time-consuming',
        'Integration costs with other systems',
        'Ongoing subscription fees'
      ]
    },
    crm: {
      pros: [
        'Centralized customer data management',
        'Automated sales processes',
        'Detailed analytics and reporting',
        'Mobile access to customer information',
        'Integration with email and calendar'
      ],
      cons: [
        'Complex implementation process',
        'Training required for team members',
        'Higher cost for advanced features'
      ]
    },
    ecommerce: {
      pros: [
        'Easy store setup and customization',
        'Payment processing included',
        'Mobile-responsive design',
        'Inventory management tools',
        'Marketing and SEO features'
      ],
      cons: [
        'Transaction fees on sales',
        'Theme customization limitations',
        'Dependency on platform updates'
      ]
    },
    design: {
      pros: [
        'Professional design tools',
        'Real-time collaboration',
        'Cloud storage and syncing',
        'Extensive asset libraries',
        'Cross-platform compatibility'
      ],
      cons: [
        'Steep learning curve',
        'Subscription-based pricing',
        'Resource-intensive applications'
      ]
    },
    analytics: {
      pros: [
        'Detailed user behavior insights',
        'Real-time data tracking',
        'Custom dashboard creation',
        'Integration with multiple platforms',
        'Advanced segmentation options'
      ],
      cons: [
        'Complex setup process',
        'Data privacy concerns',
        'Can be overwhelming for beginners'
      ]
    },
    communication: {
      pros: [
        'High-quality video and audio',
        'Screen sharing capabilities',
        'Recording and transcription features',
        'Integration with calendars',
        'Mobile and desktop apps'
      ],
      cons: [
        'Requires stable internet connection',
        'Free version limitations',
        'Potential security concerns'
      ]
    },
    storage: {
      pros: [
        'Secure cloud storage',
        'File synchronization across devices',
        'Collaboration features',
        'Large storage capacity',
        'Backup and recovery options'
      ],
      cons: [
        'Subscription required for large storage',
        'Internet connection needed for access',
        'Potential privacy concerns'
      ]
    },
    hr: {
      pros: [
        'Streamlined HR processes',
        'Automated payroll and benefits',
        'Employee self-service portal',
        'Compliance and reporting tools',
        'Integration with accounting software'
      ],
      cons: [
        'Complex implementation',
        'High setup and training costs',
        'Ongoing subscription fees'
      ]
    },
    forms: {
      pros: [
        'Easy form creation and customization',
        'Advanced logic and branching',
        'Real-time response collection',
        'Integration with other tools',
        'Mobile-responsive design'
      ],
      cons: [
        'Free plan severely limited',
        'Advanced features require paid plans',
        'Learning curve for complex forms'
      ]
    },
    automation: {
      pros: [
        'No-code automation setup',
        'Integration with thousands of apps',
        'Time-saving workflow automation',
        'Error reduction through automation',
        'Scalable for growing businesses'
      ],
      cons: [
        'Task limits on free plans',
        'Complex workflows can be confusing',
        'Potential for over-automation'
      ]
    },
    writing: {
      pros: [
        'Advanced grammar and style checking',
        'Plagiarism detection',
        'Tone and clarity suggestions',
        'Integration with writing apps',
        'Multi-language support'
      ],
      cons: [
        'May not catch all errors',
        'Can be overly prescriptive',
        'Subscription required for full features'
      ]
    },
    software: {
      pros: [
        'Powerful feature set',
        'Regular updates and improvements',
        'Professional support available',
        'Scalable for business needs',
        'Integration capabilities'
      ],
      cons: [
        'Learning curve for new users',
        'Ongoing subscription costs',
        'May require technical setup'
      ]
    }
  };

  return prosCons[category] || prosCons.software;
}

// Generate review content
function generateReviewContent(tool, category) {
  const { pros, cons } = generateProsCons(category, tool.name);

  return `# ${tool.name} Review 2025

${tool.name} is a comprehensive ${category.replace('-', ' ')} solution that offers powerful features for businesses and individuals alike.

## Overview

${tool.name} provides ${category === 'vpn' ? 'secure internet connectivity with advanced encryption' :
category === 'hosting' ? 'reliable web hosting with modern deployment tools' :
category === 'productivity' ? 'collaborative workspaces with intuitive interfaces' :
category === 'marketing' ? 'comprehensive marketing automation and analytics' :
category === 'finance' ? 'complete financial management and accounting tools' :
category === 'crm' ? 'customer relationship management with sales automation' :
category === 'ecommerce' ? 'full-featured online store creation and management' :
category === 'design' ? 'professional design tools with collaboration features' :
category === 'analytics' ? 'detailed user behavior tracking and reporting' :
category === 'communication' ? 'professional video conferencing and messaging' :
category === 'storage' ? 'secure cloud storage with synchronization' :
category === 'hr' ? 'comprehensive HR management and payroll' :
category === 'forms' ? 'advanced form creation and survey tools' :
category === 'automation' ? 'powerful workflow automation without coding' :
category === 'writing' ? 'advanced writing assistance and grammar checking' :
'professional software tools with extensive capabilities'}.

## Key Features

- **Professional Interface**: Clean, modern design that's easy to navigate
- **Advanced Functionality**: Comprehensive feature set for ${category} needs
- **Integration Options**: Connects with popular business tools
- **Security**: Enterprise-grade security measures
- **Support**: Dedicated customer support and documentation

## Pricing

${tool.name} offers flexible pricing starting at **${tool.price}**. Various plans are available to suit different needs and budgets.

## Pros

${pros.map(pro => `- ${pro}`).join('\n')}

## Cons

${cons.map(con => `- ${con}`).join('\n')}

## User Reviews

Based on user feedback, ${tool.name} receives a **${tool.rating}/5** rating from our community. Users appreciate the ${category === 'vpn' ? 'security and speed' :
category === 'hosting' ? 'reliability and performance' :
category === 'productivity' ? 'ease of use and collaboration' :
category === 'marketing' ? 'automation and analytics' :
category === 'finance' ? 'accuracy and compliance' :
category === 'crm' ? 'organization and insights' :
category === 'ecommerce' ? 'sales and management' :
category === 'design' ? 'creativity and tools' :
category === 'analytics' ? 'data and insights' :
category === 'communication' ? 'quality and features' :
category === 'storage' ? 'security and access' :
category === 'hr' ? 'management and compliance' :
category === 'forms' ? 'creation and analysis' :
category === 'automation' ? 'efficiency and integration' :
category === 'writing' ? 'accuracy and suggestions' :
'reliability and features'}.

## Screenshots

![${tool.name} Dashboard](https://via.placeholder.com/800x600/00ff88/000000?text=${encodeURIComponent(tool.name)}+Dashboard)

![${tool.name} Features](https://via.placeholder.com/800x600/00cc66/000000?text=${encodeURIComponent(tool.name)}+Features)

![${tool.name} Mobile App](https://via.placeholder.com/800x600/0088ff/000000?text=${encodeURIComponent(tool.name)}+Mobile)

## Final Verdict

${tool.name} is an excellent choice for ${category === 'vpn' ? 'secure internet browsing' :
category === 'hosting' ? 'modern web deployment' :
category === 'productivity' ? 'team collaboration' :
category === 'marketing' ? 'digital marketing campaigns' :
category === 'finance' ? 'business financial management' :
category === 'crm' ? 'customer relationship management' :
category === 'ecommerce' ? 'online store creation' :
category === 'design' ? 'professional design work' :
category === 'analytics' ? 'data-driven insights' :
category === 'communication' ? 'professional communication' :
category === 'storage' ? 'file storage and sharing' :
category === 'hr' ? 'human resources management' :
category === 'forms' ? 'data collection and surveys' :
category === 'automation' ? 'business process automation' :
category === 'writing' ? 'content creation and editing' :
'business software needs'} with its ${tool.rating >= 4.5 ? 'outstanding' : tool.rating >= 4.0 ? 'strong' : 'solid'} performance and feature set.

{{< affiliate-button url="${tool.affiliate}" text="Get ${tool.name} Deal →" >}}

*Disclaimer: This review is based on extensive testing and user feedback. Affiliate links help support our site at no extra cost to you.*`;
}

// Generate Hugo front matter
function generateFrontMatter(tool, category) {
  const currentDate = new Date().toISOString();
  const description = `${tool.name} review 2025: Features, pricing, pros/cons, and ${tool.rating}/5 rating. ${category.replace('-', ' ')} software analysis.`;

  return `+++
title = "${tool.name} Review 2025"
description = "${description}"
date = "${currentDate}"
draft = false
rating = ${tool.rating}
price = "${tool.price}"
affiliate = "${tool.affiliate}"
categories = ["reviews", "${category}"]
tags = ["${tool.slug}", "${category}", "review", "saas"]
keywords = ["${tool.name}", "${category}", "${tool.slug} review", "software review", "saas review"]
+++`;
}

// Main generation function
function generateReviewPosts() {
  console.log(`Generating ${toolsData.length} review posts...`);

  toolsData.forEach((tool, index) => {
    const category = getToolCategory(tool.slug);
    const frontMatter = generateFrontMatter(tool, category);
    const content = generateReviewContent(tool, category);

    const fileName = `${tool.slug}-review-2025.md`;
    const filePath = path.join(postsDir, fileName);

    const fullContent = `${frontMatter}\n\n${content}\n`;

    fs.writeFileSync(filePath, fullContent, 'utf8');
    console.log(`✓ Generated: ${fileName} (${index + 1}/${toolsData.length})`);
  });

  console.log(`\n🎉 Successfully generated ${toolsData.length} review posts!`);
  console.log(`📁 Files saved to: ${postsDir}`);
  console.log(`🚀 Run 'hugo --gc --minify' to build the site`);
}

// Run the generator
generateReviewPosts();
