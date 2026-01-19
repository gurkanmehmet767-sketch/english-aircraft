from PIL import Image
import os

# İkon dosyasını yükle
source_icon = r"C:/Users/Casper/.gemini/antigravity/brain/254296e5-8192-44ff-8614-53e26788a00e/aircraft_app_icon_1767118095472.png"
img = Image.open(source_icon)

# Android için gerekli boyutlar ve klasörler
sizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192
}

# Her boyut için ikon oluştur
base_path = r"android\app\src\main\res"
for folder, size in sizes.items():
    folder_path = os.path.join(base_path, folder)
    os.makedirs(folder_path, exist_ok=True)
    
    # İkonu yeniden boyutlandır
    resized = img.resize((size, size), Image.Resampling.LANCZOS)
    
    # Kaydet
    output_path = os.path.join(folder_path, "ic_launcher.png")
    resized.save(output_path, "PNG")
    print(f"✓ {folder}/ic_launcher.png oluşturuldu ({size}x{size})")

print("\nTüm ikonlar başarıyla oluşturuldu!")
