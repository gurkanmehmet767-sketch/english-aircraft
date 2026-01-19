import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../data/vocabulary_data_fixed.dart' as vocab_data;
import '../models/vocabulary_models.dart';
import '../models/user_model.dart';
import '../services/sync_service.dart';
import '../services/local_storage_service.dart';

class AppProvider with ChangeNotifier {
  // App version
  static const String appVersion = '1.0.0';

  // Seviye (A1–C2)
  static const List<String> levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
  String _level = 'A1';
  bool _isFirstLogin = true;
  bool _isLoading = false; // Loading ekranını kaldır

  int _xp = 0;
  int _lives = 5;
  static const int maxLives = 5;
  static const int regenDurationMinutes = 30; // 30 dakika bekleme
  DateTime? _livesRegenTime; // Can yenileme başlangıç zamanı
  int _streak = 0;
  List<String> _completedLessons = [];
  ThemeMode _themeMode = ThemeMode.light; // Direkt light mode başlasın
  final List<Map<String, String>> _mistakes = [];
  final List<String> _learnedWords = [];
  String _targetLanguage = 'tr'; // Hedef dil: tr, nl, de, fr, es

  // Background selection
  String _selectedLightBg = 'palm_beach'; // palm_beach_bg.png, ocean_bg.png
  String _selectedDarkBg = 'space'; // space.png, space.jpg

  // Background options
  static const List<String> lightBackgrounds = ['palm_beach', 'ocean'];
  static const List<String> darkBackgrounds = ['space', 'earth_sun'];

  // Notification settings
  bool _notificationsEnabled = true;
  int _reminderHour = 20;
  int _reminderMinute = 0;

  // Sound settings
  bool _soundEffectsEnabled = true;
  bool _speechEnabled = true;
  double _volume = 0.8; // 0.0 to 1.0

  // Statistics display
  bool _detailedStats = false; // false = simple, true = detailed

  // ===== USER & SYNC MANAGEMENT =====
  UserModel? _currentUser;
  bool _isOnline = false;
  bool _isSyncing = false;
  DateTime? _lastSyncTime;
  StreamSubscription<bool>? _connectivitySubscription;
  final SyncService _syncService = SyncService();
  final LocalStorageService _localStorage = LocalStorageService();

  // ===== MASTERY LEARNING SYSTEM =====
  // Mastery levels: 0=Not Started, 1=Bronze, 2=Silver, 3=Gold, 4=Master
  Map<String, int> _masteryLevels = {};

  // Last completion timestamps for spaced repetition
  Map<String, DateTime> _lastCompletionTime = {};

  // Current learning cycle (starts at 1, increases when all units reach Gold)
  int _currentCycle = 1;

  // Mastery level names and icons
  static const Map<int, String> masteryNames = {
    0: 'Not Started',
    1: 'Bronze',
    2: 'Silver',
    3: 'Gold',
    4: 'Master',
  };

  static const Map<int, String> masteryIcons = {
    0: '⚪',
    1: '🥉',
    2: '🥈',
    3: '🥇',
    4: '👑',
  };

  static const Map<int, List<String>> masteryColors = {
    0: ['#9E9E9E', '#757575'],
    1: ['#CD7F32', '#8B4513'],
    2: ['#C0C0C0', '#808080'],
    3: ['#FFD700', '#DAA520'],
    4: ['#9C27B0', '#7B1FA2'],
  };

  // Dil bayrakları
  static const Map<String, String> languageFlags = {
    'tr': '🇹🇷',
    'nl': '🇳🇱',
    'de': '🇩🇪',
    'fr': '🇫🇷',
    'es': '🇪🇸',
  };

  static const Map<String, String> languageNames = {
    'tr': 'Türkçe',
    'nl': 'Flemenkçe',
    'de': 'Almanca',
    'fr': 'Fransızca',
    'es': 'İspanyolca',
  };

  // Çeviriler
  static const Map<String, Map<String, String>> _translations = {
    'tr': {
      'learn': 'ÖĞREN',
      'points': 'PUAN',
      'words': 'KELİMELER',
      'grammar': 'GRAMER',
      'practice': 'ALIŞTIRMA',
      'league': 'LİG',
      'game': 'OYUN',
      'profile': 'PROFİL',
      'light_mode': '☀️ Açık Mod',
      'dark_mode': '🌙 Koyu Mod',
      'daily_missions': 'Günlük Görevler',
      'gain_xp': 'Puan kazan',
      'complete_lessons': 'ders tamamla',
      'daily_streak': 'gün streak',
      'mistakes_title': '🎯 Alıştırma - Hatalar',
      'words_title': '📝 Kelimeler',
      'total_words': 'Toplam Kelime',
      'learned': 'Öğrenilen',
      'search_words': 'Kelime ara...',
      'all_sections': 'Tümü',
      'total': 'Toplam',
      'sections': 'Kısımlar',
      'no_mistakes': 'Harika! Hiç hatan yok!',
      'continue_lessons': 'Derslere devam et',
      'mistakes_count': 'Hata',
      'check_mistakes': 'Bu kelimeleri tekrar çalış!',
      'your_answer': 'Senin cevabın',
      'correct_answer': 'Doğru cevap',
      'clear_all': 'Tüm Hataları Temizle',
      'reading_time': 'Okuma Süresi',
      'check': 'KONTROL ET',
      'continue': 'DEVAM ET',
      'correct_feedback': 'Mükemmel!',
      'wrong_feedback': 'Doğru cevap:',
      'select_correct': 'Doğru seçeneği seçin',
      'translate': 'Çevirin',
      'fill_blank': 'Boşluğu doldurun',
      'write_task': 'Bu konu hakkında en az 25 kelime yazın',
      'write_hint': 'Buraya yazın...',
      'listening': 'Dinleyin ve seçin',
      'section': 'KISIM',
      'unit': 'ÜNİTE',
      'aviation_english': 'Havacılık İngilizcesi',
      'guide': 'REHBER',
      // Settings translations
      'settings': 'AYARLAR',
      'notifications': 'Bildirimler',
      'daily_reminder': 'Günlük Hatırlatıcı',
      'reminder_time': 'Hatırlatıcı Saati',
      'theme': 'Tema',
      'sound': 'Ses',
      'sound_effects': 'Ses Efektleri',
      'speech': 'Konuşma',
      'volume': 'Ses Seviyesi',
      'language': 'Dil',
      'statistics': 'İstatistikler',
      'stats_mode': 'Görünüm Modu',
      'simple_stats': 'Basit',
      'detailed_stats': 'Detaylı',
      'backgrounds': 'Arkaplanlar',
      'data_management': 'Veri Yönetimi',
      'reset_progress': 'İlerlemeyi Sıfırla',
      'export_data': 'Verileri Dışa Aktar',
      'about': 'Hakkında',
      'app_version': 'Uygulama Sürümü',
      'privacy_policy': 'Gizlilik Politikası',
      'terms_of_service': 'Kullanım Şartları',
      'reset_confirm_title': 'İlerleme Sıfırla?',
      'reset_confirm_message':
          'Tüm ilerlemeniz (XP, streak, tamamlanan dersler) silinecek. Bu işlem geri alınamaz!',
      'reset_confirm_button': 'Evet, Sıfırla',
      'cancel': 'İptal',
      'data_exported': 'Veriler dışa aktarıldı',
      'progress_reset': 'İlerleme sıfırlandı',
      'review': 'TEKRAR',
    },
    'nl': {
      'learn': 'LEREN',
      'points': 'PUNTEN',
      'words': 'WOORDEN',
      'grammar': 'GRAMMATICA',
      'practice': 'OEFENEN',
      'league': 'COMPETITIE',
      'game': 'SPEL',
      'profile': 'PROFIEL',
      'light_mode': '☀️ Lichte Modus',
      'dark_mode': '🌙 Donkere Modus',
      'daily_missions': 'Dagelijkse Missies',
      'gain_xp': 'Punten verdienen',
      'complete_lessons': 'lessen voltooien',
      'daily_streak': 'dagen streak',
      'mistakes_title': '🎯 Oefenen - Fouten',
      'words_title': '📝 Woorden',
      'total_words': 'Totaal Woorden',
      'learned': 'Geleerd',
      'search_words': 'Zoek woorden...',
      'all_sections': 'Allemaal',
      'total': 'Totaal',
      'sections': 'Secties',
      'no_mistakes': 'Geweldig! Geen fouten!',
      'continue_lessons': 'Ga door met lessen',
      'mistakes_count': 'Fouten',
      'check_mistakes': 'Oefen deze woorden opnieuw!',
      'your_answer': 'Jouw antwoord',
      'correct_answer': 'Juist antwoord',
      'clear_all': 'Alles Wissen',
      'reading_time': 'Leestijd',
      'check': 'CONTROLEREN',
      'continue': 'DOORGAAN',
      'correct_feedback': 'Uitstekend!',
      'wrong_feedback': 'Juist antwoord:',
      'select_correct': 'Selecteer het juiste antwoord',
      'translate': 'Vertaal',
      'fill_blank': 'Vul het gat in',
      'write_task': 'Schrijf minstens 25 woorden over dit onderwerp',
      'write_hint': 'Schrijf hier...',
      'listening': 'Luister en kies',
      'section': 'SECTIE',
      'unit': 'EENHEID',
      'aviation_english': 'Luchtvaart Engels',
      'guide': 'GIDS',
      'review': 'HERHALEN',
    },
    'de': {
      'learn': 'LERNEN',
      'points': 'PUNKTE',
      'words': 'WÖRTER',
      'grammar': 'GRAMMATIK',
      'practice': 'ÜBEN',
      'league': 'LIGA',
      'game': 'SPIEL',
      'profile': 'PROFIL',
      'light_mode': '☀️ Heller Modus',
      'dark_mode': '🌙 Dunkler Modus',
      'daily_missions': 'Tägliche Missionen',
      'gain_xp': 'Punkte sammeln',
      'complete_lessons': 'Lektionen abschließen',
      'daily_streak': 'Tage Streak',
      'mistakes_title': '🎯 Üben - Fehler',
      'words_title': '📝 Wörter',
      'total_words': 'Gesamtwörter',
      'learned': 'Gelernt',
      'search_words': 'Wörter suchen...',
      'all_sections': 'Alle',
      'total': 'Gesamt',
      'sections': 'Abschnitte',
      'no_mistakes': 'Super! Keine Fehler!',
      'continue_lessons': 'Weiter mit Lektionen',
      'mistakes_count': 'Fehler',
      'check_mistakes': 'Übe diese Wörter nochmal!',
      'your_answer': 'Deine Antwort',
      'correct_answer': 'Richtige Antwort',
      'clear_all': 'Alles Löschen',
      'reading_time': 'Lesezeit',
      'check': 'ÜBERPRÜFEN',
      'continue': 'WEITER',
      'correct_feedback': 'Ausgezeichnet!',
      'wrong_feedback': 'Richtige Antwort:',
      'select_correct': 'Wähle die richtige Antwort',
      'translate': 'Übersetzen',
      'fill_blank': 'Fülle die Lücke',
      'write_task': 'Schreibe mindestens 25 Wörter zu diesem Thema',
      'write_hint': 'Hier schreiben...',
      'listening': 'Hören und auswählen',
      'section': 'ABSCHNITT',
      'unit': 'EINHEIT',
      'aviation_english': 'Luftfahrt Englisch',
      'guide': 'FÜHRER',
      'review': 'WIEDERHOLEN',
    },
    'fr': {
      'learn': 'APPRENDRE',
      'points': 'POINTS',
      'words': 'MOTS',
      'grammar': 'GRAMMAIRE',
      'practice': 'PRATIQUE',
      'league': 'LIGUE',
      'game': 'JEU',
      'profile': 'PROFIL',
      'light_mode': '☀️ Mode Clair',
      'dark_mode': '🌙 Mode Sombre',
      'daily_missions': 'Missions Quotidiennes',
      'gain_xp': 'Gagner des points',
      'complete_lessons': 'leçons terminées',
      'daily_streak': 'jours streak',
      'mistakes_title': '🎯 Pratique - Erreurs',
      'words_title': '📝 Mots',
      'total_words': 'Total Mots',
      'learned': 'Appris',
      'search_words': 'Rechercher des mots...',
      'all_sections': 'Tous',
      'total': 'Total',
      'sections': 'Sections',
      'no_mistakes': 'Super! Aucune erreur!',
      'continue_lessons': 'Continuer les leçons',
      'mistakes_count': 'Erreurs',
      'check_mistakes': 'Révisez ces mots!',
      'your_answer': 'Votre réponse',
      'correct_answer': 'Bonne réponse',
      'clear_all': 'Tout Effacer',
      'reading_time': 'Temps de lecture',
      'check': 'VÉRIFIER',
      'continue': 'CONTINUER',
      'correct_feedback': 'Excellent!',
      'wrong_feedback': 'Bonne réponse:',
      'select_correct': 'Choisissez la bonne réponse',
      'translate': 'Traduire',
      'fill_blank': 'Remplissez le vide',
      'write_task': 'Écrivez au moins 25 mots sur ce sujet',
      'write_hint': 'Écrivez ici...',
      'listening': 'Écoutez et choisissez',
      'section': 'SECTION',
      'unit': 'UNITÉ',
      'aviation_english': 'Anglais Aéronautique',
      'guide': 'GUIDE',
      'review': 'RÉVISION',
    },
    'es': {
      'learn': 'APRENDER',
      'points': 'PUNTOS',
      'words': 'PALABRAS',
      'grammar': 'GRAMÁTICA',
      'practice': 'PRÁCTICA',
      'league': 'LIGA',
      'game': 'JUEGO',
      'profile': 'PERFIL',
      'light_mode': '☀️ Modo Claro',
      'dark_mode': '🌙 Modo Oscuro',
      'daily_missions': 'Misiones Diarias',
      'gain_xp': 'Ganar puntos',
      'complete_lessons': 'lecciones completadas',
      'daily_streak': 'días racha',
      'mistakes_title': '🎯 Práctica - Errores',
      'words_title': '📝 Palabras',
      'total_words': 'Total Palabras',
      'learned': 'Aprendido',
      'search_words': 'Buscar palabras...',
      'all_sections': 'Todos',
      'total': 'Total',
      'sections': 'Secciones',
      'no_mistakes': '¡Genial! ¡Sin errores!',
      'continue_lessons': 'Continuar lecciones',
      'mistakes_count': 'Errores',
      'check_mistakes': '¡Practica estas palabras!',
      'your_answer': 'Tu respuesta',
      'correct_answer': 'Respuesta correcta',
      'clear_all': 'Borrar Todo',
      'reading_time': 'Tiempo de lectura',
      'check': 'COMPROBAR',
      'continue': 'CONTINUAR',
      'correct_feedback': '¡Excelente!',
      'wrong_feedback': 'Respuesta correcta:',
      'select_correct': 'Elige la respuesta correcta',
      'translate': 'Traducir',
      'fill_blank': 'Llena el espacio',
      'write_task': 'Escribe al menos 25 palabras sobre este tema',
      'write_hint': 'Escribe aquí...',
      'listening': 'Escucha y elige',
      'section': 'SECCIÓN',
      'unit': 'UNIDAD',
      'aviation_english': 'Inglés Aeronáutico',
      'guide': 'GUÍA',
      'review': 'REPASAR',
    },
  };

  String getString(String key) {
    return _translations[_targetLanguage]?[key] ?? _translations['tr']![key]!;
  }

  // Getters
  String get level => _level;
  void setLevel(String newLevel) {
    if (levels.contains(newLevel)) {
      _level = newLevel;
      _isFirstLogin = false;
      notifyListeners();
      _saveState();
    }
  }

  bool get isFirstLogin => _isFirstLogin;
  bool get isLoading => _isLoading;

  int get xp => _xp;
  int get totalXP => _xp; // Alias for xp
  int get currentLevel => (_xp ~/ 100) + 1; // Her 100 XP = 1 seviye
  int get lives => _lives;
  int get streak => _streak;
  List<String> get completedLessons => _completedLessons;
  ThemeMode get themeMode => _themeMode;
  List<Map<String, String>> get mistakes => _mistakes;
  List<String> get learnedWords => _learnedWords;
  String get targetLanguage => _targetLanguage;
  String get currentFlag => languageFlags[_targetLanguage] ?? '🇹🇷';
  String get currentLanguageName => languageNames[_targetLanguage] ?? 'Türkçe';

  // Background getters
  String get selectedLightBg => _selectedLightBg;
  String get selectedDarkBg => _selectedDarkBg;
  String get currentBackground =>
      _themeMode == ThemeMode.dark ? _selectedDarkBg : _selectedLightBg;

  // Settings getters
  bool get notificationsEnabled => _notificationsEnabled;
  int get reminderHour => _reminderHour;
  int get reminderMinute => _reminderMinute;
  bool get soundEffectsEnabled => _soundEffectsEnabled;
  bool get speechEnabled => _speechEnabled;
  double get volume => _volume;
  bool get detailedStats => _detailedStats;

  // ===== USER & SYNC GETTERS =====
  UserModel? get currentUser => _currentUser;
  bool get isOnline => _isOnline;
  bool get isSyncing => _isSyncing;
  bool get isSynced => _currentUser?.isSynced ?? false;
  DateTime? get lastSyncTime => _lastSyncTime;
  String get syncStatusText {
    if (_isSyncing) return 'Syncing...';
    if (!_isOnline) return 'Offline';
    if (isSynced) return 'Synced';
    return 'Not Synced';
  }

  // ===== MASTERY SYSTEM GETTERS =====
  Map<String, int> get masteryLevels => _masteryLevels;
  Map<String, DateTime> get lastCompletionTime => _lastCompletionTime;
  int get currentCycle => _currentCycle;

  // Get mastery level for a specific lesson
  int getMasteryLevel(String lessonId) {
    return _masteryLevels[lessonId] ?? 0;
  }

  // Get mastery icon for a lesson
  String getMasteryIcon(String lessonId) {
    return masteryIcons[getMasteryLevel(lessonId)] ?? '⚪';
  }

  // Get mastery name for a lesson
  String getMasteryName(String lessonId) {
    return masteryNames[getMasteryLevel(lessonId)] ?? 'Not Started';
  }

  // Check if lesson needs review (spaced repetition)
  bool needsReview(String lessonId) {
    final lastTime = _lastCompletionTime[lessonId];
    if (lastTime == null) return false;

    final mastery = getMasteryLevel(lessonId);
    if (mastery == 0) return false;

    final now = DateTime.now();
    final daysSinceCompletion = now.difference(lastTime).inDays;

    // Review intervals based on mastery level
    // Bronze: review after 1 day
    // Silver: review after 3 days
    // Gold: review after 7 days
    // Master: review after 14 days
    switch (mastery) {
      case 1:
        return daysSinceCompletion >= 1;
      case 2:
        return daysSinceCompletion >= 3;
      case 3:
        return daysSinceCompletion >= 7;
      case 4:
        return daysSinceCompletion >= 14;
      default:
        return false;
    }
  }

  // Get review urgency (0.0 to 1.0, higher = more urgent)
  double getReviewUrgency(String lessonId) {
    final lastTime = _lastCompletionTime[lessonId];
    if (lastTime == null) return 0.0;

    final mastery = getMasteryLevel(lessonId);
    if (mastery == 0) return 0.0;

    final now = DateTime.now();
    final daysSinceCompletion = now.difference(lastTime).inDays;

    // Calculate urgency based on how overdue the review is
    int reviewInterval;
    switch (mastery) {
      case 1:
        reviewInterval = 1;
        break;
      case 2:
        reviewInterval = 3;
        break;
      case 3:
        reviewInterval = 7;
        break;
      case 4:
        reviewInterval = 14;
        break;
      default:
        reviewInterval = 1;
    }

    if (daysSinceCompletion < reviewInterval) return 0.0;

    // Urgency increases as days overdue increase
    final daysOverdue = daysSinceCompletion - reviewInterval;
    return (daysOverdue / reviewInterval).clamp(0.0, 1.0);
  }

  // Get total mastered lessons count
  int get totalMasteredLessons {
    return _masteryLevels.values.where((level) => level == 4).length;
  }

  // Get total gold lessons count
  int get totalGoldLessons {
    return _masteryLevels.values.where((level) => level >= 3).length;
  }

  void setLightBackground(String bg) {
    if (lightBackgrounds.contains(bg)) {
      _selectedLightBg = bg;
      notifyListeners();
      _saveState();
    }
  }

  void setDarkBackground(String bg) {
    if (darkBackgrounds.contains(bg)) {
      _selectedDarkBg = bg;
      notifyListeners();
      _saveState();
    }
  }

  void setTargetLanguage(String lang) {
    _targetLanguage = lang;
    notifyListeners();
  }

  League get currentLeague {
    for (int i = vocab_data.leagues.length - 1; i >= 0; i--) {
      if (_xp >= vocab_data.leagues[i].xp) {
        return vocab_data.leagues[i];
      }
    }
    return vocab_data.leagues[0];
  }

  League get nextLeague {
    final current = currentLeague;
    final index = vocab_data.leagues.indexWhere((l) => l.name == current.name);
    if (index < vocab_data.leagues.length - 1) {
      return vocab_data.leagues[index + 1];
    }
    return current;
  }

  AppProvider() {
    _loadState();
    _initializeUser();
  }

  // ===== USER & SYNC METHODS =====

  Future<void> _initializeUser() async {
    // Load user from local storage
    _currentUser = await _localStorage.getUser();

    // Listen to connectivity changes
    _connectivitySubscription =
        _syncService.connectivityStream.listen((online) {
      _isOnline = online;
      notifyListeners();

      // Auto-sync when coming online
      if (online && _currentUser != null && !_currentUser!.isSynced) {
        _performSync();
      }
    });

    // Check initial connectivity
    _isOnline = await _syncService.isOnline();

    notifyListeners();
  }

  Future<void> _performSync() async {
    if (_isSyncing || _currentUser == null) return;

    _isSyncing = true;
    notifyListeners();

    try {
      // Sync progress to Firebase if user is synced
      if (_currentUser!.isSynced) {
        await _syncProgressToFirebase();
      }

      // Process sync queue
      final result = await _syncService.processSyncQueue();

      if (result.success) {
        // Reload user after successful sync
        _currentUser = await _localStorage.getUser();
        _lastSyncTime = DateTime.now();
      }
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> syncNow() async {
    await _performSync();
  }

  Future<void> _syncProgressToFirebase() async {
    if (_currentUser == null || !_currentUser!.isSynced) return;

    // Update user progress in local storage
    final updatedUser = _currentUser!.copyWith(
      xp: _xp,
      streak: _streak,
      lives: _lives,
      lastActive: DateTime.now(),
    );

    await _localStorage.saveUser(updatedUser);
    _currentUser = updatedUser;

    // Add to sync queue for Firebase update
    await _localStorage.addToSyncQueue({
      'type': 'user_update',
      'uid': _currentUser!.uid,
      'data': updatedUser.toJson(),
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    _saveState();
  }

  void addXP(int amount) {
    _xp += amount;
    notifyListeners();
    _saveState();
  }

  // ===== CAN (LIVES) SİSTEMİ =====

  // Oynayabilir mi kontrol - can var mı veya bekleme süresi doldu mu?
  bool get canPlay {
    if (_lives > 0) return true;
    if (_livesRegenTime == null) return true;

    // Bekleme süresi doldu mu?
    final now = DateTime.now();
    final timePassed = now.difference(_livesRegenTime!).inMinutes;
    if (timePassed >= regenDurationMinutes) {
      // Süre doldu, canları yenile
      _refreshLives();
      return true;
    }
    return false;
  }

  // Kalan bekleme süresi (dakika cinsinden)
  int get remainingWaitTime {
    if (_lives > 0 || _livesRegenTime == null) return 0;

    final now = DateTime.now();
    final timePassed = now.difference(_livesRegenTime!).inMinutes;
    final remaining = regenDurationMinutes - timePassed;
    return remaining > 0 ? remaining : 0;
  }

  // Kalan süreyi formatla (örn: "25:30")
  String get remainingWaitTimeFormatted {
    if (_lives > 0 || _livesRegenTime == null) return "";

    final now = DateTime.now();
    final timePassed = now.difference(_livesRegenTime!).inSeconds;
    final remainingSeconds = (regenDurationMinutes * 60) - timePassed;

    if (remainingSeconds <= 0) {
      _refreshLives();
      return "";
    }

    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // Can kaybet (yanlış cevap)
  void loseLife() {
    if (_lives > 0) {
      _lives--;

      // İlk kez 0'a düştüğünde zamanlayıcıyı başlat
      if (_lives == 0) {
        _livesRegenTime = DateTime.now();
      }

      notifyListeners();
      _saveState();
    }
  }

  // Can ekle (ödül, vb.)
  void addLife() {
    if (_lives < maxLives) {
      _lives++;

      // Can geldi, zamanlayıcıyı sıfırla
      if (_lives > 0) {
        _livesRegenTime = null;
      }

      notifyListeners();
      _saveState();
    }
  }

  // Canları yenile (30 dk sonra)
  void _refreshLives() {
    _lives = maxLives;
    _livesRegenTime = null;
    notifyListeners();
    _saveState();
  }

  // Manuel can yenileme (test/debug için)
  void refillLives() {
    _refreshLives();
  }

  // Original completeLesson for backwards compatibility
  void completeLesson(String lessonId) {
    completeLessonWithMastery(lessonId);
  }

  // ===== MASTERY SYSTEM METHODS =====

  // Complete a lesson and progress mastery level
  void completeLessonWithMastery(String lessonId,
      {int correctAnswers = 0, int totalQuestions = 0}) {
    final currentMastery = getMasteryLevel(lessonId);

    // Calculate performance score (0.0 to 1.0)
    double performance =
        totalQuestions > 0 ? correctAnswers / totalQuestions : 1.0;

    // Progress mastery based on performance
    int newMastery = currentMastery;
    if (performance >= 0.8) {
      // Good performance: advance to next level
      newMastery = (currentMastery + 1).clamp(0, 4);
    } else if (performance >= 0.5) {
      // Okay performance: stay at current level or advance if first time
      newMastery = currentMastery == 0 ? 1 : currentMastery;
    } else {
      // Poor performance: stay at current level (or start at Bronze if new)
      newMastery = currentMastery == 0 ? 1 : currentMastery;
    }

    _masteryLevels[lessonId] = newMastery;
    _lastCompletionTime[lessonId] = DateTime.now();

    // Track completed lessons
    if (!_completedLessons.contains(lessonId)) {
      _completedLessons.add(lessonId);
      _streak++;
    }

    // Calculate XP based on mastery progression
    int xpGain = 50; // Base XP
    if (newMastery > currentMastery) {
      xpGain += 50 * newMastery; // Bonus for leveling up
    }
    if (needsReview(lessonId)) {
      xpGain += 25; // Bonus for completing reviews
    }

    _xp += xpGain;

    // Check if cycle should advance (all lessons at Gold or higher)
    _checkCycleAdvancement();

    notifyListeners();
    _saveState();
  }

  // Check and advance cycle if all lessons are Gold or higher
  void _checkCycleAdvancement() {
    final totalLessons = vocab_data.vocabulary.length;
    final goldOrHigher =
        _masteryLevels.values.where((level) => level >= 3).length;

    if (goldOrHigher >= totalLessons && totalLessons > 0) {
      _currentCycle++;
      // Reset all lessons to Silver for the new cycle (keep some progress)
      _masteryLevels.updateAll((key, value) => value >= 3 ? 2 : value);
    }
  }

  // Reset mastery for a specific lesson (for practice mode)
  void resetLessonMastery(String lessonId) {
    _masteryLevels[lessonId] = 0;
    _lastCompletionTime.remove(lessonId);
    _completedLessons.remove(lessonId);
    notifyListeners();
    _saveState();
  }

  // Get lessons that need review
  List<String> getLessonsNeedingReview() {
    return _masteryLevels.keys.where((id) => needsReview(id)).toList();
  }

  // Get count of lessons needing review
  int get lessonsNeedingReviewCount {
    return getLessonsNeedingReview().length;
  }

  // Hata ekle
  void addMistake(String question, String yourAnswer, String correctAnswer) {
    _mistakes.add({
      'question': question,
      'yourAnswer': yourAnswer,
      'correctAnswer': correctAnswer,
    });
    notifyListeners();
  }

  // Hata sil
  void removeMistake(int index) {
    if (index >= 0 && index < _mistakes.length) {
      _mistakes.removeAt(index);
      notifyListeners();
    }
  }

  // Tüm hataları temizle
  void clearMistakes() {
    _mistakes.clear();
    notifyListeners();
  }

  // ===== KELIME BAZLI SPACED REPETITION SİSTEMİ =====

  // Her kelime için: {strength: 0-5, lastReview: DateTime, correctCount: int, wrongCount: int}
  Map<String, Map<String, dynamic>> _wordStats = {};

  // Kelime strength seviyeleri ve tekrar aralıkları (dakika cinsinden)
  // 4 seviye: 0=Yeni, 1=Zayıf, 2=Öğreniliyor, 3=İyi
  static const Map<int, int> strengthIntervals = {
    0: 0, // Yeni - hemen tekrar
    1: 5, // 5 dakika sonra
    2: 60, // 1 saat sonra
    3: 1440, // 1 gün sonra (ustalaşmış)
  };

  static const Map<int, String> strengthNames = {
    0: 'Yeni',
    1: 'Zayıf',
    2: 'Öğreniliyor',
    3: 'İyi',
  };

  // Havacılık renkleri: 4 ana renk
  static const Map<int, Color> strengthColors = {
    0: Colors.blue, // Mavi - Yeni/Inactive
    1: Colors.red, // Kırmızı - Warning/Zayıf
    2: Colors.amber, // Amber - Caution/Öğreniliyor
    3: Colors.green, // Yeşil - Good/İyi
  };

  // Kelime istatistiklerini al
  Map<String, Map<String, dynamic>> get wordStats => _wordStats;

  // Kelime strength seviyesini al
  int getWordStrength(String word) {
    return _wordStats[word]?['strength'] ?? 0;
  }

  // Kelime son tekrar zamanını al
  DateTime? getWordLastReview(String word) {
    final timestamp = _wordStats[word]?['lastReview'];
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Kelime doğru/yanlış sayısını al
  int getWordCorrectCount(String word) =>
      _wordStats[word]?['correctCount'] ?? 0;
  int getWordWrongCount(String word) => _wordStats[word]?['wrongCount'] ?? 0;

  // Kelime tekrar zamanı geldi mi?
  bool wordNeedsReview(String word) {
    final stats = _wordStats[word];
    if (stats == null) return false;

    final strength = stats['strength'] ?? 0;
    final lastReview = stats['lastReview'];
    if (lastReview == null) return true;

    final lastReviewTime = DateTime.fromMillisecondsSinceEpoch(lastReview);
    final minutesSinceReview =
        DateTime.now().difference(lastReviewTime).inMinutes;
    final intervalMinutes = strengthIntervals[strength] ?? 0;

    return minutesSinceReview >= intervalMinutes;
  }

  // Kelimeyi doğru cevapladı - strength artır
  void wordAnsweredCorrectly(String word) {
    final stats = _wordStats[word] ??
        {
          'strength': 0,
          'lastReview': null,
          'correctCount': 0,
          'wrongCount': 0,
        };

    int currentStrength = stats['strength'] ?? 0;
    int correctCount = stats['correctCount'] ?? 0;

    // Strength'i 1 artır (max 3)
    int newStrength = (currentStrength + 1).clamp(0, 3);

    _wordStats[word] = {
      'strength': newStrength,
      'lastReview': DateTime.now().millisecondsSinceEpoch,
      'correctCount': correctCount + 1,
      'wrongCount': stats['wrongCount'] ?? 0,
    };

    // Öğrenilen kelimeler listesine ekle
    if (!_learnedWords.contains(word)) {
      _learnedWords.add(word);
    }

    notifyListeners();
    _saveState();
  }

  // Kelimeyi yanlış cevapladı - strength düşür
  void wordAnsweredWrongly(String word) {
    final stats = _wordStats[word] ??
        {
          'strength': 0,
          'lastReview': null,
          'correctCount': 0,
          'wrongCount': 0,
        };

    int currentStrength = stats['strength'] ?? 0;
    int wrongCount = stats['wrongCount'] ?? 0;

    // Strength'i 1 düşür (min 0)
    int newStrength = (currentStrength - 1).clamp(0, 3);

    _wordStats[word] = {
      'strength': newStrength,
      'lastReview': DateTime.now().millisecondsSinceEpoch,
      'correctCount': stats['correctCount'] ?? 0,
      'wrongCount': wrongCount + 1,
    };

    notifyListeners();
    _saveState();
  }

  // Tekrar edilmesi gereken kelimeleri listele (öncelik sırasına göre)
  List<String> getWordsNeedingReview({int limit = 20}) {
    final wordsToReview = <MapEntry<String, int>>[];

    for (final entry in _wordStats.entries) {
      if (wordNeedsReview(entry.key)) {
        // Öncelik: düşük strength > yüksek strength
        final strength = entry.value['strength'] ?? 0;
        wordsToReview.add(MapEntry(entry.key, strength));
      }
    }

    // Düşük strength önce gelsin
    wordsToReview.sort((a, b) => a.value.compareTo(b.value));

    return wordsToReview.take(limit).map((e) => e.key).toList();
  }

  // Toplam tekrar bekleyen kelime sayısı
  int get wordsNeedingReviewCount {
    return _wordStats.keys.where((word) => wordNeedsReview(word)).length;
  }

  // Zayıf kelimeler (strength 0-2)
  List<String> get weakWords {
    return _wordStats.entries
        .where((e) => (e.value['strength'] ?? 0) <= 2)
        .map((e) => e.key)
        .toList();
  }

  // Güçlü kelimeler (strength 4-5)
  List<String> get strongWords {
    return _wordStats.entries
        .where((e) => (e.value['strength'] ?? 0) >= 4)
        .map((e) => e.key)
        .toList();
  }

  // Kelime istatistikleri özeti
  Map<String, dynamic> get wordReviewStats {
    int total = _wordStats.length;
    int needsReview = wordsNeedingReviewCount;
    int weak = weakWords.length;
    int strong = strongWords.length;
    int mastered =
        _wordStats.entries.where((e) => (e.value['strength'] ?? 0) == 5).length;

    return {
      'total': total,
      'needsReview': needsReview,
      'weak': weak,
      'strong': strong,
      'mastered': mastered,
    };
  }

  // Legacy kelime öğrenildi metodu (geriye uyumluluk için)
  void learnWord(String word) {
    if (!_learnedWords.contains(word)) {
      _learnedWords.add(word);

      // Eğer word stats'da yoksa ekle
      if (!_wordStats.containsKey(word)) {
        _wordStats[word] = {
          'strength': 1,
          'lastReview': DateTime.now().millisecondsSinceEpoch,
          'correctCount': 1,
          'wrongCount': 0,
        };
      }

      notifyListeners();
      _saveState();
    }
  }

  // Settings methods
  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
    _saveState();
  }

  void setReminderTime(int hour, int minute) {
    _reminderHour = hour;
    _reminderMinute = minute;
    notifyListeners();
    _saveState();
  }

  void toggleSoundEffects() {
    _soundEffectsEnabled = !_soundEffectsEnabled;
    notifyListeners();
    _saveState();
  }

  void toggleSpeech() {
    _speechEnabled = !_speechEnabled;
    notifyListeners();
    _saveState();
  }

  void setVolume(double vol) {
    _volume = vol.clamp(0.0, 1.0);
    notifyListeners();
    _saveState();
  }

  void toggleStatsMode() {
    _detailedStats = !_detailedStats;
    notifyListeners();
    _saveState();
  }

  // Data management
  Future<void> resetProgress() async {
    _xp = 0;
    _lives = 5;
    _streak = 0;
    _completedLessons.clear();
    _mistakes.clear();
    _learnedWords.clear();
    _masteryLevels.clear();
    _lastCompletionTime.clear();
    _currentCycle = 1;
    notifyListeners();
    await _saveState();
  }

  String exportData() {
    final data = {
      'xp': _xp,
      'lives': _lives,
      'streak': _streak,
      'completedLessons': _completedLessons,
      'learnedWords': _learnedWords,
      'mistakes': _mistakes,
      'level': _level,
      'settings': {
        'notifications': _notificationsEnabled,
        'reminderHour': _reminderHour,
        'reminderMinute': _reminderMinute,
        'soundEffects': _soundEffectsEnabled,
        'speech': _speechEnabled,
        'volume': _volume,
        'detailedStats': _detailedStats,
        'theme': _themeMode == ThemeMode.dark ? 'dark' : 'light',
        'lightBg': _selectedLightBg,
        'darkBg': _selectedDarkBg,
      }
    };
    return data.toString();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _xp = prefs.getInt('xp') ?? 0;
    _lives = prefs.getInt('lives') ?? 5;
    final regenTimeMillis = prefs.getInt('livesRegenTime');
    _livesRegenTime = regenTimeMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(regenTimeMillis)
        : null;
    _streak = prefs.getInt('streak') ?? 0;
    _completedLessons = prefs.getStringList('completedLessons') ?? [];
    final isDark = prefs.getBool('isDark') ?? true;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _selectedLightBg = prefs.getString('lightBg') ?? 'sea';
    _selectedDarkBg = prefs.getString('darkBg') ?? 'space';

    // Load settings
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    _reminderHour = prefs.getInt('reminderHour') ?? 20;
    _reminderMinute = prefs.getInt('reminderMinute') ?? 0;
    _soundEffectsEnabled = prefs.getBool('soundEffectsEnabled') ?? true;
    _speechEnabled = prefs.getBool('speechEnabled') ?? true;
    _volume = prefs.getDouble('volume') ?? 0.8;
    _detailedStats = prefs.getBool('detailedStats') ?? false;

    // Load mastery system data
    _currentCycle = prefs.getInt('currentCycle') ?? 1;
    final masteryData = prefs.getStringList('masteryLevels') ?? [];
    _masteryLevels = {};
    for (final entry in masteryData) {
      final parts = entry.split('|');
      if (parts.length == 2) {
        _masteryLevels[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }
    final completionData = prefs.getStringList('lastCompletionTime') ?? [];
    _lastCompletionTime = {};
    for (final entry in completionData) {
      final parts = entry.split('|');
      if (parts.length == 2) {
        _lastCompletionTime[parts[0]] =
            DateTime.tryParse(parts[1]) ?? DateTime.now();
      }
    }

    if (prefs.containsKey('level')) {
      _level = prefs.getString('level')!;
      _isFirstLogin = false;
    } else {
      _level = 'A1';
      _isFirstLogin = true;
    }

    // Load word stats for spaced repetition
    final wordStatsData = prefs.getStringList('wordStats') ?? [];
    _wordStats = {};
    for (final entry in wordStatsData) {
      final parts = entry.split('|');
      if (parts.length == 5) {
        _wordStats[parts[0]] = {
          'strength': int.tryParse(parts[1]) ?? 0,
          'lastReview': int.tryParse(parts[2]),
          'correctCount': int.tryParse(parts[3]) ?? 0,
          'wrongCount': int.tryParse(parts[4]) ?? 0,
        };
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('xp', _xp);
    prefs.setInt('lives', _lives);
    if (_livesRegenTime != null) {
      prefs.setInt('livesRegenTime', _livesRegenTime!.millisecondsSinceEpoch);
    } else {
      prefs.remove('livesRegenTime');
    }
    prefs.setInt('streak', _streak);
    prefs.setStringList('completedLessons', _completedLessons);
    prefs.setBool('isDark', _themeMode == ThemeMode.dark);
    prefs.setString('level', _level);
    prefs.setString('lightBg', _selectedLightBg);
    prefs.setString('darkBg', _selectedDarkBg);

    // Save settings
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setInt('reminderHour', _reminderHour);
    prefs.setInt('reminderMinute', _reminderMinute);
    prefs.setBool('soundEffectsEnabled', _soundEffectsEnabled);
    prefs.setBool('speechEnabled', _speechEnabled);
    prefs.setDouble('volume', _volume);
    prefs.setBool('detailedStats', _detailedStats);

    // Save mastery system data
    prefs.setInt('currentCycle', _currentCycle);
    final masteryData =
        _masteryLevels.entries.map((e) => '${e.key}|${e.value}').toList();
    prefs.setStringList('masteryLevels', masteryData);
    final completionData = _lastCompletionTime.entries
        .map((e) => '${e.key}|${e.value.toIso8601String()}')
        .toList();
    prefs.setStringList('lastCompletionTime', completionData);

    // Save word stats for spaced repetition
    final wordStatsData = _wordStats.entries
        .map((e) =>
            '${e.key}|${e.value['strength']}|${e.value['lastReview'] ?? 0}|${e.value['correctCount']}|${e.value['wrongCount']}')
        .toList();
    prefs.setStringList('wordStats', wordStatsData);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
