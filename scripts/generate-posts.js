const fs = require('fs');
const path = require('path');

// Read tools data
const toolsPath = path.join(__dirname, '..', 'data', 'saas-tools.json');
const tools = JSON.parse(fs.readFileSync(toolsPath, 'utf8'));

// Generate pros/cons for each tool category
function generateProsCons(tool) {
    const categories = {
        'nordvpn': {
            pros: ['Fast VPN speeds', 'Strong encryption', 'No-logs policy', 'Large server network'],
            cons: ['Occasional connection drops', 'Desktop app can be resource-intensive']
        },
        'syncbackpro': {
            pros: ['Powerful backup automation', 'Supports multiple protocols', 'Reliable scheduling', 'Good customer support'],
            cons: ['Steep learning curve', 'Windows-only interface']
        },
        'slack': {
            pros: ['Excellent team communication', 'Rich integrations', 'Mobile apps work well', 'Search functionality'],
            cons: ['Free plan limitations', 'Can become cluttered with many channels']
        },
        'trello': {
            pros: ['Simple and intuitive', 'Great for visual organization', 'Free tier available', 'Mobile apps'],
            cons: ['Limited automation', 'Basic reporting features']
        },
        'zoom': {
            pros: ['High-quality video calls', 'Easy to use', 'Large meeting capacity', 'Screen sharing works well'],
            cons: ['Recent security concerns', 'Free tier time limits']
        },
        'notion': {
            pros: ['Extremely flexible', 'All-in-one workspace', 'Beautiful interface', 'Strong community'],
            cons: ['Learning curve', 'Mobile app limitations']
        },
        'figma': {
            pros: ['Real-time collaboration', 'Web-based design', 'Component system', 'Prototyping tools'],
            cons: ['Limited bitmap editing', 'Can be slow with large files']
        },
        'canva': {
            pros: ['User-friendly interface', 'Large template library', 'Free tier available', 'Drag-and-drop design'],
            cons: ['Limited customization', 'Watermarks on free designs']
        },
        'mailchimp': {
            pros: ['Easy email creation', 'Good analytics', 'Automation features', 'Large integrations'],
            cons: ['Pricing can get expensive', 'Learning curve for advanced features']
        },
        'shopify': {
            pros: ['Easy to set up', 'Great app ecosystem', 'Reliable hosting', 'Good customer support'],
            cons: ['Transaction fees on basic plans', 'Limited customization without apps']
        }
    };

    // Default pros/cons if category not found
    const defaultPros = ['Reliable performance', 'Good user interface', 'Strong feature set', 'Responsive support'];
    const defaultCons = ['Learning curve for new users', 'Some advanced features could be improved'];

    return categories[tool.slug] || { pros: defaultPros, cons: defaultCons };
}

// Generate affiliate CTA based on tool
function generateAffiliateCTA(tool) {
    return `Ready to try ${tool.name}? Get started with our affiliate link and enjoy special offers!

[Get ${tool.name} Now](${tool.affiliate})

*Note: This is an affiliate link. By purchasing through this link, you support SaaS Verdict at no extra cost to you.*`;
}

// Generate post content
function generatePostContent(tool) {
    const { pros, cons } = generateProsCons(tool);
    const affiliateCTA = generateAffiliateCTA(tool);

    return `![${tool.name} interface](/images/${tool.slug}-1.jpg)

${tool.name} is a comprehensive solution that offers powerful features for modern businesses and individuals. With a ${tool.rating}/5 rating from our reviewers, it's clear why this tool has become a popular choice in its category.

## Key Features

${tool.name} provides an extensive range of features designed to meet the needs of both small businesses and large enterprises. The intuitive interface makes it accessible to users of all skill levels.

![${tool.name} dashboard](/images/${tool.slug}-2.jpg)

## Pricing

Starting at ${tool.price}, ${tool.name} offers competitive pricing that provides excellent value for money. Various plans are available to suit different needs and budgets.

## Pros

${pros.map(pro => `- ${pro}`).join('\n')}

## Cons

${cons.map(con => `- ${con}`).join('\n')}

## Our Verdict

Overall, ${tool.name} stands out as a ${tool.rating >= 4.5 ? 'excellent' : tool.rating >= 4.0 ? 'solid' : 'decent'} choice in its category. The combination of features, ease of use, and reliability makes it a worthwhile investment for most users.

![${tool.name} mobile app](/images/${tool.slug}-3.jpg)

${affiliateCTA}

*Last updated: October 29, 2025*`;
}

// Generate front matter
function generateFrontMatter(tool) {
    const date = new Date().toISOString().split('T')[0]; // YYYY-MM-DD format

    return `+++
date = '${date}T10:00:00-07:00'
draft = false
title = '${tool.name} Review ${new Date().getFullYear()}'
description = 'Comprehensive review of ${tool.name} - features, pricing, pros, cons, and our verdict'
tags = ['${tool.slug}', 'review', 'saas']
categories = ['Reviews']
rating = ${tool.rating}
affiliate = '${tool.affiliate}'
price = '${tool.price}'
+++

`;
}

// Main function
function generatePosts() {
    const postsDir = path.join(__dirname, '..', 'content', 'en', 'posts');

    // Ensure posts directory exists
    if (!fs.existsSync(postsDir)) {
        fs.mkdirSync(postsDir, { recursive: true });
    }

    console.log(`Generating ${tools.length} posts...`);

    tools.forEach((tool, index) => {
        const fileName = `${tool.slug}.md`;
        const filePath = path.join(postsDir, fileName);

        const frontMatter = generateFrontMatter(tool);
        const content = generatePostContent(tool);
        const fullContent = frontMatter + content;

        fs.writeFileSync(filePath, fullContent, 'utf8');
        console.log(`${index + 1}/${tools.length}: Generated ${fileName}`);
    });

    console.log('All posts generated successfully!');
}

// Run the script
generatePosts();