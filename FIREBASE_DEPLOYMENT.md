# Firebase Deployment Rehberi

## 🚀 Hızlı Başlangıç

Bu rehber, Alien Aviation uygulamanızı Firebase Hosting'e deploy etmeniz için adım adım talimatlar içerir.

## ✅ Hazırlık Tamamlandı

Aşağıdakiler uygulamanıza eklenmiştir:
- ✅ `firebase.json` - Firebase Hosting konfigürasyonu
- ✅ `.firebaserc` - Firebase proje ayarları
- ✅ `manifest.json` - PWA ayarları güncellendi
- ✅ `build_secure_web.bat` - Build scripti Firebase için hazırlandı

## 📋 Deployment Adımları

### 1. Firebase CLI Kurulumu

PowerShell'i açın ve Firebase CLI'ı yükleyin:

```powershell
npm install -g firebase-tools
```

Firebase CLI versiyonunu kontrol edin:

```powershell
firebase --version
```

### 2. Firebase'e Giriş

Firebase hesabınızla login olun:

```powershell
firebase login
```

Tarayıcı açılacak ve Google hesabınızla giriş yapacaksınız.

### 3. Firebase Projesi Oluşturma

İki yol var:

**A) Firebase Console'dan (Önerilen):**

1. [Firebase Console](https://console.firebase.google.com/) açın
2. "Proje Ekle" tıklayın
3. Proje adı: `english-aircraft` (veya istediğiniz isim)
4. Google Analytics: İsteğe bağlı (daha sonra ekleyebilirsiniz)
5. "Proje Oluştur" tıklayın

**B) CLI'dan:**

```powershell
firebase projects:create english-aircraft
```

### 4. Firebase Projesini Bağlama

Projenizin klasöründe `.firebaserc` dosyasını güncelleyin. Eğer farklı bir proje adı kullandıysanız:

```json
{
  "projects": {
    "default": "BURAYA-PROJE-ADINIZ"
  }
}
```

Projeyi bağlayın:

```powershell
cd C:\Users\Casper\Desktop\english_aircraft
firebase use --add
```

Listeden projenizi seçin.

### 5. Production Build

Build scriptini çalıştırın:

```powershell
.\build_secure_web.bat
```

Veya manuel olarak:

```powershell
flutter build web --release --obfuscate --split-debug-info=./debug_info
```

`build/web` klasörü oluşturulacak.

### 6. Firebase'e Deploy

Deploy komutunu çalıştırın:

```powershell
firebase deploy --only hosting
```

İlk deployment tamamlandığında size iki URL verilecek:

```
✔ Deploy complete!

Hosting URL: https://english-aircraft.web.app
             https://english-aircraft.firebaseapp.com
```

🎉 **Tebrikler!** Uygulamanız artık canlıda!

## 🌐 Özel Domain Bağlama

Domain satın aldıktan sonra Firebase'e bağlamak için:

### Firebase Console Adımları

1. [Firebase Console](https://console.firebase.google.com/) → Projeniz → Hosting
2. "Özel domain ekle" tıklayın
3. Domain adınızı girin (örn: `myapp.com`)
4. "Devam Et"

### DNS Ayarları

Firebase size DNS kayıtları verecek. Domain sağlayıcınızda (GoDaddy, Namecheap, vs.) şu kayıtları ekleyin:

**A Kayıtları:**
```
Tip: A
Host: @
Değer: [Firebase'in verdiği IP]

Tip: A
Host: www
Değer: [Firebase'in verdiği IP]
```

**Veya TXT Doğrulama (Alternatif):**
Firebase size TXT kaydı da verebilir, talimatları izleyin.

### SSL Sertifikası

Firebase otomatik olarak **ücretsiz Let's Encrypt SSL sertifikası** sağlar. Domain bağlandıktan sonra 24 saat içinde aktif olur.

## 🔄 Güncellemeler

Gelecekte değişiklik yaptığınızda:

```powershell
# Build
.\build_secure_web.bat

# Deploy
firebase deploy --only hosting
```

## 🌟 Ekstra Komutlar

**Preview Deployment (Test):**
```powershell
firebase hosting:channel:deploy preview
```

**Deployment Geçmişi:**
```powershell
firebase hosting:clone SOURCE_SITE_ID:SOURCE_CHANNEL_ID TARGET_SITE_ID:TARGET_CHANNEL_ID
```

**Rollback (Geri Alma):**
Firebase Console → Hosting → Release History → "Rollback" tıklayın

## ❓ Sorun Giderme

**Build Hatası:**
```powershell
flutter clean
flutter pub get
flutter build web --release
```

**Firebase Login Sorunu:**
```powershell
firebase logout
firebase login --reauth
```

**Firebase Proje Bulunamıyor:**
```powershell
firebase projects:list
firebase use PROJE_ADI
```

## 📝 Sonraki Adımlar

- [ ] Domain satın alın
- [ ] Domain'i Firebase'e bağlayın
- [ ] SSL sertifikasının aktif olmasını bekleyin
- [ ] `index.html` ve `sitemap.xml` dosyalarındaki URL'leri kendi domain'inize güncelleyin
- [ ] Google Analytics ekleyin (isteğe bağlı)
- [ ] Performance Monitoring aktifleyin (isteğe bağlı)

---

**Hazır!** 🚀 Sorularınız için benimle iletişime geçebilirsiniz.
