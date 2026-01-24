from PIL import Image
import os

# PNG files to convert
png_files = [
    'assets/images/ocean_bg.png',
    'assets/images/palm_beach_bg.png'
]

for png_path in png_files:
    if os.path.exists(png_path):
        # Open PNG
        img = Image.open(png_path)
        
        # Create WebP path
        webp_path = png_path.replace('.png', '.webp')
        
        # Convert to WebP with quality 85 (good balance)
        img.save(webp_path, 'webp', quality=85)
        
        # Get file sizes
        png_size = os.path.getsize(png_path) / 1024  # KB
        webp_size = os.path.getsize(webp_path) / 1024  # KB
        reduction = ((png_size - webp_size) / png_size) * 100
        
        print(f"✅ {os.path.basename(png_path)}")
        print(f"   PNG:  {png_size:.2f} KB")
        print(f"   WebP: {webp_size:.2f} KB")
        print(f"   Saved: {reduction:.1f}%\n")
    else:
        print(f"❌ File not found: {png_path}")

print("✨ Conversion complete!")
