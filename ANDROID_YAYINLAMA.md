# Android Yayınlama Kılavuzu

Bu kılavuz English Aircraft uygulamasını Google Play Store'da yayınlamak için gereken tüm adımları içerir.

## ✅ Tamamlanan Hazırlıklar

- ✅ Uygulama kimliği: `com.englishaircraft.app`
- ✅ Uygulama adı: "English Aircraft"
- ✅ Production keystore oluşturuldu
- ✅ Release signing yapılandırıldı
- ✅ Code optimization aktif
- ✅ Uygulama ikonu güncellendi
- ✅ İzinler ayarlandı

## 📱 1. APK/AAB Oluşturma

### Debug APK (Test için)
```bash
flutter build apk --debug
```
Çıktı: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK
```bash
flutter build apk --release
```
Çıktı: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Play Store için **ÖNERİLEN**)
```bash
flutter build appbundle --release  
```
Çıktı: `build/app/outputs/bundle/release/app-release.aab`

> **Not:** Google Play Store AAB formatını tercih eder çünkü cihaza optimize edilmiş APK'lar oluşturur ve daha küçük indirme boyutu sağlar.

## 🔐 2. Keystore Bilgileri

**ÖNEMLİ: Bu bilgileri güvenli bir yerde saklayın!**

```
Keystore dosyası: android/app/upload-keystore.jks
Alias: upload
Store Password: EnglishAircraft2025!
Key Password: EnglishAircraft2025!
```

> ⚠️ **UYARI:** Bu keystore'u ve şifreleri kaybederseniz uygulamanızı asla güncelleyemezsiniz!

## 🧪 3. Test Etme

### Android Cihazda Test
1. APK dosyasını cihaza kopyalayın
2. "Bilinmeyen kaynaklar"dan yüklemeye izin verin
3. Uygulamayı yükleyin ve test edin

### Test Edilmesi Gerekenler
- [ ] Uygulama açılışı sorunsuz
- [ ] Firebase bağlantısı çalışıyor
- [ ] Tüm dersler yükleniyor
- [ ] TTS (sesli okuma) çalışıyor
- [ ] İlerleme kaydediliyor
- [ ] Lives sistemi çalışıyor
- [ ] Çıkış ve giriş düzgün

## 🏪 4. Google Play Console Kurulumu

### Play Console Hesabı
1. https://play.google.com/console adresine gidin
2. Google hesabınızla giriş yapın
3. **25 USD** tek seferlik kayıt ücreti ödemeniz gerekir

### Yeni Uygulama Oluşturma
1. "Create app" butonuna tıklayın
2. Uygulama detaylarını doldurun:
   - **Uygulama adı:** English Aircraft
   - **Varsayılan dil:** Türkçe
   - **Uygulama türü:** App
   - **Ücretsiz/Ücretli:** Ücretsiz (veya tercihinize göre)

## 📝 5. Store Listing Hazırlama

### Uygulama Detayları

**Kısa Açıklama** (80 karakter max):
```
İngilizce öğrenmek için eğlenceli ve etkili uygulama. Kelime, dilbilgisi ve daha fazlası!
```

**Uzun Açıklama** (4000 karakter max):
```
🛫 English Aircraft ile İngilizce Öğrenin!

English Aircraft, İngilizce öğrenmeyi eğlenceli ve kolay hale getiren kapsamlı bir öğrenme uygulamasıdır.

✨ ÖZELLİKLER:

📚 Kapsamlı İçerik
• 600+ kelime ve kelime grupları
• Dilbilgisi dersleri ve kurallar
• Reading (okuma) pasajları
• İnteraktif quizler

🎮 Eğlenceli Öğrenme
• Word Galaxy oyunu ile kelime pratıği
• İlerleme takibi ve XP sistemi
• Lives (can) sistemi
• Hata tekrarı özelliği

🎯 Kişiselleştirilmiş Deneyim
• Seviye bazlı öğrenme
• İlerleme kaydı
• İstatistik takibi
• Koyu/Açık tema

🔊 Sesli Öğrenme
• Text-to-speech desteği
• Doğru telaffuz

📱 Offline Çalışma
• İnternet bağlantısı olmadan kullanabilirsiniz

English Aircraft ile İngilizce öğrenmek hiç bu kadar kolay olmamıştı! Hemen indirin ve öğrenme yolculuğunuza başlayın! 🚀
```

### Grafikler

#### Gerekli Grafikler:

**1. Uygulama İkonu** ✅ (Tamamlandı)
- 512×512 px
- PNG format

**2. Feature Graphic** 
- 1024×500 px
- JPG veya PNG
- Uygulamanızı temsil eden yatay bir banner

**3. Ekran Görüntüleri** (En az 2, maksimum 8)
- Telefon: 320×3040 px min
- Ana ekran, ders ekranı, quiz ekranı vb.

İpucu: Flutter uygulamanızı çalıştırıp ekran görüntüleri alabilirsiniz.

### Kategori ve Etiketler
- **Kategori:** Education
- **Alt Kategori:** Language Learning
- **Tags:** English, Learning, Education, Language

## 🔒 6. Gizlilik Politikası

Firebase kullandığınız için gizlilik politikası **ZORUNLU**.

### Basit Template:

```markdown
# Gizlilik Politikası - English Aircraft

**Son güncelleme:** 30 Aralık 2024

## Toplanan Veriler
English Aircraft aşağıdaki verileri toplar ve saklar:
- Öğrenme ilerleme verileri
- Kullanıcı tercihleri ve ayarları
- Uygulama kullanım istatistikleri

## Veri Kullanımı
Toplanan veriler şunlar için kullanılır:
- Öğrenme ilerlemanizi kaydetme
- Kişiselleştirilmiş öğrenme deneyimi sunma
- Uygulama performansını iyileştirme

## Üçüncü Taraf Servisleri
Uygulamamız aşağıdaki üçüncü taraf servisleri kullanır:
- **Firebase (Google)**: Veri depolama ve kimlik doğrulama
  - Firebase Gizlilik Politikası: https://firebase.google.com/support/privacy

## Veri Güvenliği
Verileriniz Firebase'in güvenli sunucularında şifrelenerek saklanır.

## Kullanıcı Hakları
- Verilerinizi görüntüleme hakkına sahipsiniz
- Hesabınızı ve verilerinizi silme hakkına sahipsiniz
- İletişim: [email@example.com]

## Değişiklikler
Bu gizlilik politikasında yapılacak değişiklikler bu sayfada yayınlanacaktır.
```

Bu metni bir web sitesinde yayınlayın (GitHub Pages, Netlify vs.) ve URL'i Play Console'a ekleyin.

## 🎭 7. İçerik Derecelendirmesi

Google Play'in soru formunu doldurun:
- **Şiddet:** Yok
- **Cinsel içerik:** Yok  
- **Küfür:** Yok
- **Reklam:** (Varsa belirtin)
- **Yaş:** Tüm yaşlar (PEGI 3 / ESRB Everyone)

## 📤 8. Upload ve Yayınlama

### Internal Testing
1. Play Console'da "Internal Testing" sekmesine gidin
2. AAB dosyanızı yükleyin
3. Test kullanıcıları ekleyin (Gmail adresleri)
4. Test edin

### Production Release
1. Tüm testler başarılı olduğunda
2. "Production" sekmesine gidin
3. "Create new release" tıklayın
4. AAB dosyasını yükleyin
5. Release notes yazın:
```
🎉 English Aircraft'ın ilk sürümü!

✨ Özellikler:
• 600+ kelime
• Dilbilgisi dersleri
• İnteraktif quizler
• Word Galaxy oyunu
• İlerleme takibi
```
6. "Review release" → "Start rollout to Production"

### İnceleme Süreci
- Google incelemesi 1-7 gün sürebilir
- Email ile bildirim alacaksınız
- Onaylandıktan sonra birkaç saat içinde Play Store'da görünür

## 🎯 9. Yayın Sonrası

### ASO (App Store Optimization)
- Anahtar kelimeler optimize edin
- Ekran görüntülerini güncelleme
- Kullanıcı yorumlarına yanıt verin
- Düzenli güncellemeler yayınlayın

### Güncellemeler
Güncelleme yayınlamak için:
```bash
# pubspec.yaml'da version'ı artırın
# version: 1.0.1+2  (1.0.1 = versionName, 2 = versionCode)

flutter build appbundle --release
```
Sonra Play Console'da yeni release oluşturun.

## 📞 Yardım

**Yaygın Sorunlar:**

**Build hatası alıyorum:**
```bash
flutter clean
flutter pub get  
flutter build appbundle --release -v
```

**Keystore hatası:**
- key.properties dosyasının doğru yolda olduğundan emin olun
- Şifrelerin doğru olduğunu kontrol edin

**Play Console red:**
- Gizlilik politikası URL'i çalışıyor mu kontrol edin
- Ekran görüntüleri gerekliliklere uygun mu kontrol edin
- İçerik derecelendirmesini tamamladınız mı kontrol edin

## ✅ Son Kontrol Listesi

Upload öncesi kontrol edin:
- [ ] AAB dosyası oluşturuldu ve test edildi
- [ ] Gizlilik politikası web'de yayınlandı
- [ ] Ekran görüntüleri hazırlandı
- [ ] Store listing metinleri yazıldı
- [ ] Feature graphic oluşturuldu
- [ ] İçerik derecelendirmesi tamamlandı
- [ ] Keystore güvenli yere yedeklendi
- [ ] 25 USD kayıt ücreti ödendi

Başarılar! 🚀
