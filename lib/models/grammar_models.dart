// Grammar Models - Aviation Technical English Grammar
// Bu dosya grammar_data.dart tarafından kullanılan model sınıflarını içerir.

/// Tek bir gramer cümlesi modeli
class GrammarSentence {
  final String text; // İngilizce cümle
  final String translation; // Türkçe çeviri

  const GrammarSentence({
    required this.text,
    required this.translation,
  });
}

/// Gramer alıştırması modeli (Quiz tarzı sorular için)
class GrammarExercise {
  final String question; // Soru metni (boşluk doldurma vb.)
  final List<String> options; // Seçenekler listesi
  final int correctIndex; // Doğru cevabın indeksi
  final String explanation; // Açıklama (neden bu cevap doğru)

  const GrammarExercise({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

/// Gramer konusu modeli
class GrammarTopic {
  final String letter; // Konu harfi (A, B, C1, C2, vb.)
  final String title; // Konu başlığı (İngilizce)
  final String titleKey; // Çeviri anahtarı
  final String description; // Konu açıklaması
  final String icon; // Emoji ikonu
  final List<GrammarSentence>? sentences; // Cümle listesi (opsiyonel)
  final List<GrammarExercise>? exercises; // Alıştırma listesi (opsiyonel)

  const GrammarTopic({
    required this.letter,
    required this.title,
    required this.titleKey,
    required this.description,
    required this.icon,
    this.sentences,
    this.exercises,
  });

  /// Toplam içerik sayısını döndürür
  int get totalItems {
    int count = 0;
    if (sentences != null) count += sentences!.length;
    if (exercises != null) count += exercises!.length;
    return count;
  }

  /// Sadece cümleleri mi içeriyor?
  bool get hasSentences => sentences != null && sentences!.isNotEmpty;

  /// Sadece alıştırmaları mı içeriyor?
  bool get hasExercises => exercises != null && exercises!.isNotEmpty;
}
