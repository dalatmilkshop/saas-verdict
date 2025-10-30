import os
import re

# Read the YAML file
with open('data/redirects.yaml', 'r', encoding='utf-8') as f:
    content = f.read()

print('YAML content length:', len(content))
print('First 10 lines:')
for i, line in enumerate(content.split('\n')[:10]):
    print(f'{i+1}: {repr(line)}')

# Test regex
test_line = 'nordvpn: https://nordvpn.sjv.io/coupons'
match = re.match(r'^(\w+.*):\s*(.+)$', test_line.strip())
if match:
    print('Regex works:', match.groups())
else:
    print('Regex failed')

# Try to find nordvpn
for line in content.split('\n'):
    if 'nordvpn' in line:
        print('Found nordvpn line:', repr(line))
        match = re.match(r'^(\w+.*):\s*(.+)$', line.strip())
        if match:
            print('Match groups:', match.groups())
        break