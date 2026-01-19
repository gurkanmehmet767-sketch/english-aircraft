# 📚 İçerik Yazarı Rehberi - Alien English Aircraft

Bu doküman, Alien English Aircraft uygulamasına yeni içerik ekleyecek içerik yazarları için hazırlanmıştır.

---

## 🎯 Uygulama Amacı

Bu uygulama, **havacılık sektöründe çalışan Türk teknisyenlerin teknik İngilizce öğrenmesini** sağlamak için tasarlanmıştır. Uçak bakımı, güvenlik protokolleri, aviyonik sistemler ve havacılık operasyonları gibi konularda mesleki İngilizce becerisi kazandırır.

---

## 📊 Zorluk Seviyesi Sistemi

Her terim (kelime) ve okuma metni bir zorluk seviyesine sahiptir. Seviyeler **1'den 4'e** kadar gider:

### 🟢 Seviye 1 - Temel (Beginner)
**Hedef Kitle:** İngilizce'ye yeni başlayanlar

| Özellik | Açıklama |
|---------|----------|
| **Kelime uzunluğu** | Kısa, 1-2 heceli kelimeler |
| **Kullanım sıklığı** | Günlük sık kullanılan terimler |
| **Kavram zorluğu** | Somut, görsel olarak anlaşılabilir |
| **Örnek kelimeler** | safety helmet, wrench, wing, battery |

**Yazım İpuçları:**
- Temel fiiller kullanın (is, has, uses, protects)
- Basit cümle yapıları
- Görsel olarak tanımlanabilir nesneler

---

### 🟡 Seviye 2 - Orta-Kolay (Elementary)
**Hedef Kitle:** Temel İngilizce bilgisi olanlar

| Özellik | Açıklama |
|---------|----------|
| **Kelime uzunluğu** | 2-3 heceli kelimeler |
| **Kavram zorluğu** | Biraz teknik ama yaygın |
| **Kullanım alanı** | Atölye ve bakım ortamında sık duyulan |
| **Örnek kelimeler** | hearing protection, hydraulic pump, electrical hazard |

**Yazım İpuçları:**
- Birleşik kelimeler kullanılabilir (compound words)
- Temel teknik terimler eklenebilir
- Eylem odaklı tanımlamalar

---

### 🟠 Seviye 3 - Orta-Zor (Intermediate)
**Hedef Kitle:** Teknik İngilizce temeli olanlar

| Özellik | Açıklama |
|---------|----------|
| **Kelime uzunluğu** | 3-4 heceli, teknik terimler |
| **Kavram zorluğu** | Özel bilgi gerektiren konular |
| **Kullanım alanı** | Teknik dokümantasyonda geçen |
| **Örnek kelimeler** | angular contact bearings, pneumatic riveters, calibration certificate |

**Yazım İpuçları:**
- Sektöre özgü teknik terimler
- Mekanizma ve süreç açıklamaları
- Bileşenlerin işlevleri

---

### 🔴 Seviye 4 - İleri (Advanced)
**Hedef Kitle:** Uzman seviyesinde teknik İngilizce hedefleyenler

| Özellik | Açıklama |
|---------|----------|
| **Kelime uzunluğu** | Uzun, çok heceli teknik terimler |
| **Kavram zorluğu** | Derin teknik bilgi gerektiren |
| **Kullanım alanı** | Havacılık yönetmelikleri, standartlar |
| **Örnek kelimeler** | airworthiness directive, non-conformance report, bonding and grounding tests |

**Yazım İpuçları:**
- Mevzuat ve standart terimleri (FAA, EASA, ICAO)
- Karmaşık sistemlerin detaylı bileşenleri
- Soyut kavramlar ve prosedürler

---

## 📁 İçerik Yapısı

### Kategoriler (CategoryData)

Her kategori şu bilgileri içerir:

```dart
CategoryData(
  title: 'Kategori Adı İngilizce / Türkçe Çeviri',
  icon: '🔧',  // Emoji ikonu
  section: '1. KISIM',  // Ana bölüm
  unit: '1. ÜNİTE Açıklama',  // Alt ünite
  terms: [...],  // Kelime listesi
  readings: [...],  // Okuma metinleri
)
```

### Terimler (Term)

Her terim şu formatta olmalıdır:

```dart
Term('İngilizce terim', 'Türkçe çeviri', zorluk_seviyesi),
```

**Örnek:**
```dart
Term('safety helmet', 'emniyet kaskı', 1),
Term('fall protection harness', 'düşme koruma kemeri', 3),
```

### Okuma Metinleri (Reading)

Her okuma metni şu formatta olmalıdır:

```dart
Reading(
  passage: 'İngilizce metin paragrafı...',
  question: 'Soru metni?',
  correctAnswer: 'Doğru cevap',
  options: ['Yanlış 1', 'Doğru cevap', 'Yanlış 2', 'Yanlış 3'],
),
```

---

## 📐 Ana Bölümler (Sections)

Uygulama 6 ana bölümden oluşur:

| Bölüm | İngilizce Başlık | Konu Alanı |
|-------|------------------|------------|
| 1. KISIM | Workshop Safety & Maintenance Fundamentals | İş güvenliği, PPE, atölye |
| 2. KISIM | Maintenance & Inspection | Bakım, test, muayene |
| 3. KISIM | Aircraft Structure & Systems | Uçak yapısı, sistemler |
| 4. KISIM | Safety Procedures | Güvenlik prosedürleri |
| 5. KISIM | Emergency Response | Acil durum müdahale |
| 6. KISIM | Aviation Operations | Havacılık operasyonları |

---

## ✍️ İçerik Yazım Kuralları

### 1. Kelime Seçimi

✅ **DOĞRU:**
- Havacılık sektöründe gerçekten kullanılan terimler
- EASA/FAA dokümantasyonundaki standart terimler
- Türk teknisyenlerin gerçekten ihtiyaç duyacağı kelimeler

❌ **YANLIŞ:**
- Günlük konuşma İngilizcesi (sektör dışı)
- Çok nadir kullanılan arkaik terimler
- Yalnızca akademik ortamda geçen kelimeler

### 2. Türkçe Çeviriler

✅ **DOĞRU:**
- Sivil Havacılık Genel Müdürlüğü terminolojisi
- Türk Standartları Enstitüsü (TSE) terimleri
- Sektörde yaygın kullanılan karşılıklar

❌ **YANLIŞ:**
- Kelimesi kelimesine literal çeviriler
- Uydurma veya yapay Türkçeler
- Anlaşılmaz akademik çeviriler

### 3. Okuma Metinleri

**İdeal Uzunluk:** 2-4 cümle (50-100 kelime)

**Yapı:**
1. Konuyu tanıtan giriş cümlesi
2. Teknik detay veya açıklama
3. (Opsiyonel) Örnek veya uygulama

**Soru Türleri:**
- "What...?" (En yaygın - %60)
- "Which...?" (Karşılaştırmalı sorular için)
- "What type/kind...?" (Sınıflandırma soruları)

### 4. Çoktan Seçmeli Şıklar

- Toplam 4 şık olmalı
- Doğru cevap rastgele konumda olmalı
- Yanlış şıklar mantıklı ama yanlış olmalı (absürt değil)
- Şıklar benzer uzunlukta olmalı

---

## 📋 Yeni Kategori Ekleme Adımları

### Adım 1: Konuyu Belirle
```
Hangi KISIM'a ait?
Ne kadar zorluk seviyesi dağılımı?
Kaç kelime olacak? (İdeal: 14-20)
```

### Adım 2: Kelime Listesi Oluştur
```
Seviye 1: %25 (3-5 kelime) - Temel terimler
Seviye 2: %25 (3-5 kelime) - Orta-kolay
Seviye 3: %25 (3-5 kelime) - Orta-zor
Seviye 4: %25 (3-5 kelime) - İleri
```

### Adım 3: Okuma Metni Yaz
```
- Kategorinin ana konusunu özetleyen kısa paragraf
- Metinden cevaplanabilir bir soru
- 4 seçenekli çoktan seçmeli yanıt
```

### Adım 4: Kodu Düzenle
`lib/data/vocabulary_data.dart` dosyasına ekle

---

## 🎮 Seviye Sistemi (League)

Kullanıcı XP kazandıkça lig atlar. NATO Fonetik Alfabesi kullanılır:

| Lig | XP Gerekli | Seviye | Renk |
|-----|------------|--------|------|
| Zulu | 0 | Beginner | Bronz |
| Yankee - X-ray | 500-1000 | Bronze | Bronz |
| Whiskey - Tango | 1500-3000 | Silver | Gümüş |
| Sierra - Papa | 3500-5000 | Gold | Altın |
| Oscar - Lima | 5500-7000 | Platinum | Platin |
| Kilo - Hotel | 7500-9000 | Diamond | Elmas |
| Golf - Delta | 9500-11000 | Master | Mor |
| Charlie - Alpha | 11500-12500 | Grandmaster | Yeşil |

---

## 📝 Örnek Kategori Şablonu

```dart
'Yeni Kategori Adı / Türkçe Adı': CategoryData(
  title: 'Yeni Kategori Adı / Türkçe Adı',
  icon: '🔧',
  section: 'X. KISIM',
  unit: 'Y. ÜNİTE Açıklama',
  terms: [
    // Seviye 1 - Temel
    Term('basic term one', 'temel terim bir', 1),
    Term('basic term two', 'temel terim iki', 1),
    Term('basic term three', 'temel terim üç', 1),
    Term('basic term four', 'temel terim dört', 1),
    
    // Seviye 2 - Orta-Kolay
    Term('elementary term one', 'orta terim bir', 2),
    Term('elementary term two', 'orta terim iki', 2),
    Term('elementary term three', 'orta terim üç', 2),
    Term('elementary term four', 'orta terim dört', 2),
    
    // Seviye 3 - Orta-Zor
    Term('intermediate term one', 'orta-zor terim bir', 3),
    Term('intermediate term two', 'orta-zor terim iki', 3),
    Term('intermediate term three', 'orta-zor terim üç', 3),
    Term('intermediate term four', 'orta-zor terim dört', 3),
    
    // Seviye 4 - İleri
    Term('advanced term one', 'ileri terim bir', 4),
    Term('advanced term two', 'ileri terim iki', 4),
    Term('advanced term three', 'ileri terim üç', 4),
    Term('advanced term four', 'ileri terim dört', 4),
  ],
  readings: [
    Reading(
      passage: 'Ana konu hakkında açıklayıcı bir paragraf. '
               'Teknik detaylar ve önemli bilgiler içermeli. '
               'Soru bu paragraftan cevaplanabilmeli.',
      question: 'Paragraftan anlaşılan önemli bir bilgiyi soran soru?',
      correctAnswer: 'Doğru yanıt metni',
      options: [
        'Yanlış seçenek A', 
        'Doğru yanıt metni', 
        'Yanlış seçenek B', 
        'Yanlış seçenek C'
      ],
    ),
  ],
),
```

---

## ⚠️ Önemli Notlar

1. **Kod Söz Dizimi:** Dart dilinde yazılmış, virgül ve parantezlere dikkat edin
2. **Türkçe Karakterler:** ğ, ü, ş, ı, ö, ç harflerini doğru kullanın
3. **Test:** Değişikliklerden sonra `flutter analyze` çalıştırın
4. **Yedekleme:** Değişiklik yapmadan önce dosyayı yedekleyin

---

## 📞 İletişim

İçerik sorularınız için proje yöneticisiyle iletişime geçin.

---

*Bu doküman güncellenebilir. Son güncelleme: Ocak 2026*
