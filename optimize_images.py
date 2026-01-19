import os
import subprocess
from pathlib import Path

assets_dir = Path("assets/images")
optimized_count = 0
saved_bytes = 0

# Find all PNG and JPG files
for img_path in list(assets_dir.glob("*.png")) + list(assets_dir.glob("*.jpg")):
    original_size = img_path.stat().st_size
    webp_path = img_path.with_suffix(".webp")
    
    # Skip if already has webp version
    if webp_path.exists():
        print(f"Skipping {img_path.name} (WebP exists)")
        continue
    
    # Convert using sharp-cli
    try:
        result = subprocess.run(
            ["npx", "sharp-cli", "-i", str(img_path), "-o", str(webp_path), "-f", "webp", "-q", "80"],
            capture_output=True,
            text=True,
            shell=True
        )
        
        if webp_path.exists():
            new_size = webp_path.stat().st_size
            savings = original_size - new_size
            saved_bytes += savings
            optimized_count += 1
            print(f"✓ {img_path.name} -> {webp_path.name} ({original_size//1024}KB -> {new_size//1024}KB, saved {savings//1024}KB)")
        else:
            print(f"✗ Failed to convert {img_path.name}")
    except Exception as e:
        print(f"✗ Error converting {img_path.name}: {e}")

print(f"\n=== Summary ===")
print(f"Optimized: {optimized_count} images")
print(f"Total saved: {saved_bytes / (1024*1024):.2f} MB")
