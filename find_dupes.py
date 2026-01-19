import re
from collections import Counter

with open('lib/data/word_dictionary.dart', 'r', encoding='utf-8') as f:
    content = f.read()

keys = re.findall(r"^\s*'([^']+)':", content, re.MULTILINE)
dupes = [(k, v) for k, v in Counter(keys).items() if v > 1]

if dupes:
    print("Duplicates found:")
    for key, count in sorted(dupes):
        print(f"  '{key}': {count} times")
else:
    print("No duplicates found!")
