class Term {
  final String english;
  final String turkish;
  final String? dutch;      // Flemenkçe
  final String? german;     // Almanca
  final String? french;     // Fransızca
  final String? spanish;    // İspanyolca
  final dynamic level; // Can be int (legacy) or String like 'A1'.

  const Term(this.english, this.turkish, this.level, {
    this.dutch,
    this.german,
    this.french,
    this.spanish,
  });

  // Seçilen dile göre çeviriyi getir
  String getTranslation(String langCode) {
    switch (langCode) {
      case 'nl':
        return dutch ?? turkish; // Flemenkçe yoksa Türkçe kullan
      case 'de':
        return german ?? turkish;
      case 'fr':
        return french ?? turkish;
      case 'es':
        return spanish ?? turkish;
      case 'tr':
      default:
        return turkish;
    }
  }
}

class Reading {
  final String passage;
  final String question;
  final String correctAnswer;
  final List<String> options;
  final dynamic level; // optional: can be int or 'A1'
  final String? translation; // Türkçe çeviri (opsiyonel)
  final Map<String, String>? wordTranslations; // Türkçe kelime çevirileri (legacy)
  // Çok dilli kelime çevirileri
  final Map<String, String>? wordTranslationsDutch;
  final Map<String, String>? wordTranslationsGerman;
  final Map<String, String>? wordTranslationsFrench;
  final Map<String, String>? wordTranslationsSpanish;

  const Reading({
    required this.passage,
    required this.question,
    required this.correctAnswer,
    required this.options,
    this.level = 'A1',
    this.translation,
    this.wordTranslations,
    this.wordTranslationsDutch,
    this.wordTranslationsGerman,
    this.wordTranslationsFrench,
    this.wordTranslationsSpanish,
  });

  // Seçilen dile göre kelime çevirisi getir
  Map<String, String>? getWordTranslations(String langCode) {
    switch (langCode) {
      case 'nl':
        return wordTranslationsDutch ?? wordTranslations;
      case 'de':
        return wordTranslationsGerman ?? wordTranslations;
      case 'fr':
        return wordTranslationsFrench ?? wordTranslations;
      case 'es':
        return wordTranslationsSpanish ?? wordTranslations;
      case 'tr':
      default:
        return wordTranslations;
    }
  }
}


class CategoryData {
  final String title;
  final String icon;
  final List<Term> terms;
  final List<Reading> readings;
  final String? section; // e.g. '5. KISIM'
  final String? unit; // e.g. '114. ÜNİTE'

  const CategoryData({
    required this.title,
    required this.icon,
    required this.terms,
    this.readings = const [],
    this.section,
    this.unit,
  });
}

class League {
  final String name;
  final int xp;
  final List<String> colors; // Hex codes or similar
  final String desc;

  const League({
    required this.name,
    required this.xp,
    required this.colors,
    required this.desc,
  });
}
