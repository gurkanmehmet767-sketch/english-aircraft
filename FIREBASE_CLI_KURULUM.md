# 🔧 Firebase CLI Kurulum Sorunu Çözümü

Firebase CLI kurulumu izin hatası verdi. İşte alternatif çözümler:

## Çözüm 1: PowerShell'i Yönetici Olarak Çalıştır (Önerilen)

1. Windows Arama'dan "PowerShell" yazın
2. Sağ tıklayıp **"Yönetici olarak çalıştır"** seçin
3. Aşağıdaki komutu çalıştırın:

```powershell
npm install -g firebase-tools
```

## Çözüm 2: Standalone Firebase CLI (npm Olmadan)

Firebase CLI'ı npm olmadan standalone binary olarak kurabilirsiniz:

1. [Firebase CLI İndirme Sayfası](https://firebase.google.com/docs/cli#windows-standalone-binary) açın
2. Windows Standalone Binary'yi indirin
3. İndirilen dosyayı PATH'e ekleyin veya doğrudan kullanın

## Çözüm 3: Manuel Deployment (Web Console)

Firebase CLI olmadan manuel olarak deploy edebilirsiniz:

### Adımlar:

1. **Build Alın:**
   ```powershell
   .\build_secure_web.bat
   ```

2. **Firebase Console'a Gidin:**
   - [Firebase Console](https://console.firebase.google.com/) açın
   - Projenizi oluşturun
   - Hosting bölümüne gidin

3. **Manuel Upload:**
   - "Get Started" tıklayın
   - `build/web` klasöründeki **tüm dosyaları** sürükle-bırak ile yükleyin

## Kurulum Sonrası Test

Kurulum başarılı olduğunda kontrol edin:

```powershell
firebase --version
```

Başarılı kurulum örnek çıktı:
```
13.0.0
```

---

**Şu anda ne yapmalısınız:**

PowerShell'i **yönetici modunda** açıp tekrar deneyin:

```powershell
npm install -g firebase-tools
```

Ardından `FIREBASE_DEPLOYMENT.md` dosyasındaki talimatları takip edin.
