import os
import re

# Read the YAML file
with open('data/redirects.yaml', 'r', encoding='utf-8') as f:
    content = f.read()

print('First few lines of YAML:')
for i, line in enumerate(content.split('\n')[:5]):
    print(f'{i+1}: {repr(line)}')

# Parse YAML and create markdown files
count = 0
for line in content.split('\n'):
    match = re.match(r'^(\w+.*):\s*(.+)$', line.strip())
    if match:
        slug = match.group(1)
        url = match.group(2)

        # Create the markdown content
        md_content = f'''---
title: "{slug}"
layout: redirect
slug: {slug}
---
'''

        # Write the file
        filename = f'content/go/{slug}.md'
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(md_content)
        count += 1

print(f'Generated {count} redirect pages')