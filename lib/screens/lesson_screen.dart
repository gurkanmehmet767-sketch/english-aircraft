import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/vocabulary_models.dart';
import '../providers/app_provider.dart';
import '../data/vocabulary_data_fixed.dart';
import '../data/word_dictionary.dart';

// Conditional import for web speech API
import '../utils/speech_stub.dart'
    if (dart.library.html) '../utils/speech_web.dart';


class LessonScreen extends StatefulWidget {
  final CategoryData category;

  const LessonScreen({super.key, required this.category});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late List<dynamic> _questions;
  int _currentIndex = 0;
  int _correctAnswers = 0;
  bool _showFeedback = false;
  bool _isCorrect = false;
  bool _lessonComplete = false;
  late ConfettiController _confettiController;
  final TextEditingController _writingController =
      TextEditingController(); // Writing input
  int _wordCount = 0; // Track word count

  // Reading comprehension flow states
  bool _canProceedToQuestion = false;

  // Kronometre - Okuma süresi
  int _readingSeconds = 0;
  Timer? _readingTimer;

  // Ders süresi ve XP
  int _lessonSeconds = 0;
  Timer? _lessonTimer;
  int _earnedXP = 0;

  // Animation Controllers
  late AnimationController _planeController;
  late Animation<double> _planeAnimation;
  late AnimationController _takeOffController;
  
  // Speech speed control (0.6 = yavaş, 0.9 = normal, 1.2 = hızlı)
  double _speechRate = 0.9;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    // Ders timer'ını başlat
    _lessonTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _lessonSeconds++);
    });

    // Smooth progress animation
    _planeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _planeAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _planeController, curve: Curves.easeInOut));

    // Take-off animation
    _takeOffController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _generateQuestions();
  }

  @override
  void dispose() {
    _writingController.dispose();
    _confettiController.dispose();
    _planeController.dispose();
    _takeOffController.dispose();
    _readingTimer?.cancel();
    _lessonTimer?.cancel();
    super.dispose();
  }

  void _startReadingTimer() {
    _readingTimer?.cancel();
    _readingSeconds = 0;
    _readingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _readingSeconds++;
      });
    });
  }

  void _stopReadingTimer() {
    _readingTimer?.cancel();
  }

  void _generateQuestions() {
    _questions = [];
    
    // Seçilen dili al
    final provider = Provider.of<AppProvider>(context, listen: false);
    final langCode = provider.targetLanguage;

    // 1. Get Terms (Need 6) - Çift yönlü sorular oluştur
    final termQuestions = <Map<String, dynamic>>[];
    final terms = List.from(widget.category.terms)..shuffle();
    
    for (var term in terms) {
      // Seçilen dile göre çeviri al
      final translation = term.getTranslation(langCode);
      
      // HER ZAMAN İngilizce soru → Hedef Dil cevap (Türkçe vb.)
      termQuestions.add({
        'type': 'term',
        'question': term.english,  // İngilizce kelime (soru)
        'correct': translation,     // Hedef dilde cevap (Türkçe vb.)
        'options': _generateOptions(
          correct: translation, 
          langCode: langCode, 
          questionInEnglish: true,
          termLevel: term.level,
        ),
        'data': term,
        'direction': 'en2target',
      });
    }

    // 2. Get Readings (Need 3)
    final readingQuestions = <Map<String, dynamic>>[];
    final readings = List.from(widget.category.readings)..shuffle();
    for (var reading in readings) {
      // Doğru cevabı bul - ünite terimlerinden
      String correctAnswer = reading.correctAnswer;
      
      // Ünite terimlerinde doğru cevabı ara (Türkçe'den başla, sonra diğer diller)
      for (var term in widget.category.terms) {
        // Tam eşleşme kontrolü - Türkçe
        if (term.turkish == reading.correctAnswer) {
          correctAnswer = term.getTranslation(langCode);
          break;
        }
        // Tam eşleşme - Diğer diller
        if (term.dutch == reading.correctAnswer ||
            term.german == reading.correctAnswer ||
            term.french == reading.correctAnswer ||
            term.spanish == reading.correctAnswer) {
          correctAnswer = term.getTranslation(langCode);
          break;
        }
        // Kısmi eşleşme kontrolü - doğru cevap terim çevirisini içeriyor mu?
        if (reading.correctAnswer.contains(term.turkish) || 
            term.turkish.contains(reading.correctAnswer)) {
          correctAnswer = term.getTranslation(langCode);
          break;
        }
      }
      
      // Eğer eşleşme bulunamadıysa, orijinal cevabı kullan (dil çevirisi yapılmaz)
      // Ancak seçenekler yine de ünite terimlerinden oluşturulacak
      
      // Seçenekleri ünite terimlerinden oluştur
      final readingOptions = _generateOptions(
        correct: correctAnswer, 
        langCode: langCode,
        questionInEnglish: true,  // Reading her zaman İngilizce
        termLevel: 'A1',
      );
      
      readingQuestions.add({
        'type': 'reading',
        'passage': reading.passage,
        'question': reading.question,
        'correct': correctAnswer,
        'options': readingOptions,
      });
    }

    // Select 6 terms + 3 readings (fallback if not enough readings)
    int readingCount =
        readingQuestions.length >= 3 ? 3 : readingQuestions.length;
    int termCount = 9 - readingCount; // 10 total - 1 writing - readingCount

    _questions.addAll(termQuestions.take(termCount));
    _questions.addAll(readingQuestions.take(readingCount));
    _questions.shuffle();

    // 3. Add Writing Question (Always last)
    _questions.add({
      'type': 'writing',
      'question':
          'Write a paragraph (at least 25 words) using the terms you learned in this lesson.',
      'correct': 'WRITING_TASK',
      'options': [],
    });
  }

  List<String> _generateOptions({
    required String correct, 
    required String langCode,
    required bool questionInEnglish,
    dynamic termLevel,
  }) {
    final options = <String>{correct};  // Doğru cevapla başla
    
    if (questionInEnglish) {
      // İngilizce → Hedef Dil sorusu
      // 1. Önce aynı level'daki kelimelerden al
      final sameLevelTerms = widget.category.terms
          .where((t) => t.level == termLevel && t.getTranslation(langCode) != correct)
          .map((t) => t.getTranslation(langCode))
          .toList();
      sameLevelTerms.shuffle();
      
      for (var term in sameLevelTerms.take(3)) {
        if (options.length >= 4) break;
        options.add(term);
      }
      
      // 2. Yetersizse aynı kategoriden al
      if (options.length < 4) {
        final categoryTerms = widget.category.terms
            .map((t) => t.getTranslation(langCode))
            .where((t) => t != correct && !options.contains(t))
            .toList();
        categoryTerms.shuffle();
        
        for (var term in categoryTerms) {
          if (options.length >= 4) break;
          options.add(term);
        }
      }
      
      // 3. Hala yetersizse tüm vocabulary'den al
      if (options.length < 4) {
        final allTerms = <String>[];
        for (var category in vocabulary.values) {
          for (var term in category.terms) {
            final trans = term.getTranslation(langCode);
            if (trans != correct && !options.contains(trans)) {
              allTerms.add(trans);
            }
          }
        }
        allTerms.shuffle();
        
        for (var term in allTerms) {
          if (options.length >= 4) break;
          options.add(term);
        }
      }
    } else {
      // Hedef Dil → İngilizce sorusu
      // 1. Önce aynı level'daki İngilizce kelimeleri al
      final sameLevelTerms = widget.category.terms
          .where((t) => t.level == termLevel && t.english != correct)
          .map((t) => t.english)
          .toList();
      sameLevelTerms.shuffle();
      
      for (var term in sameLevelTerms.take(3)) {
        if (options.length >= 4) break;
        options.add(term);
      }
      
      // 2. Yetersizse aynı kategoriden al
      if (options.length < 4) {
        final categoryTerms = widget.category.terms
            .map((t) => t.english)
            .where((t) => t != correct && !options.contains(t))
            .toList();
        categoryTerms.shuffle();
        
        for (var term in categoryTerms) {
          if (options.length >= 4) break;
          options.add(term);
        }
      }
      
      // 3. Hala yetersizse tüm vocabulary'den al
      if (options.length < 4) {
        final allTerms = <String>[];
        for (var category in vocabulary.values) {
          for (var term in category.terms) {
            if (term.english != correct && !options.contains(term.english)) {
              allTerms.add(term.english);
            }
          }
        }
        allTerms.shuffle();
        
        for (var term in allTerms) {
          if (options.length >= 4) break;
          options.add(term);
        }
      }
    }
    
    // 4 şıktan azsa tekrar ekle (döngülü - son çare)
    while (options.length < 4) {
      options.add(correct); // Aynı cevabı ekle ve shuffle ile karıştır
    }
    
    return options.toList()..shuffle();
  }

  void _checkAnswer(String selected) {
    if (_showFeedback || _lessonComplete) return;

    final question = _questions[_currentIndex];

    // Writing logic
    if (question['type'] == 'writing') {
      if (_wordCount < 25) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please write at least 25 words!'),
              backgroundColor: Colors.red),
        );
        return;
      }
      // Pass automatically if word count met
      setState(() {
        _isCorrect = true;
        _showFeedback = true;
        _correctAnswers++;
        Provider.of<AppProvider>(context, listen: false)
            .addXP(15); // Path için düşük writing XP
      });
      return;
    }

    final correct = question['correct'];
    final provider = Provider.of<AppProvider>(context, listen: false);

    setState(() {
      _isCorrect = selected == correct;
      _showFeedback = true;

      if (_isCorrect) {
        _correctAnswers++;
        
        // 📚 PATH XP SİSTEMİ - Düşük XP (Oyun daha çok XP verir)
        int baseXP = 3; // Az XP - Path için
        int bonusXP = 0;
        
        // Reading sorusu için küçük hız bonusu
        if (question['type'] == 'reading') {
          // Hızlı okuma bonusu (0-30 saniye arası)
          if (_readingSeconds <= 10) {
            bonusXP = 5; // Çok hızlı!
          } else if (_readingSeconds <= 20) {
            bonusXP = 3; // Hızlı
          } else if (_readingSeconds <= 30) {
            bonusXP = 2; // Normal
          } else if (_readingSeconds <= 45) {
            bonusXP = 1; // Yavaş
          }
          // 45+ saniye = bonus yok
        }
        
        int totalXP = baseXP + bonusXP;
        provider.addXP(totalXP);

        // Eğer bu bir kelime sorusuysa, spaced repetition sistemini güncelle
        if (question['type'] == 'term') {
          String englishWord = '';
          for (var term in widget.category.terms) {
            if (term.english == correct ||
                term.turkish == correct ||
                term.english == question['question'] ||
                term.turkish == question['question']) {
              englishWord = term.english;
              break;
            }
          }
          if (englishWord.isNotEmpty) {
            // Doğru cevap - strength artır
            provider.wordAnsweredCorrectly(englishWord);
          }
        }
      } else {
        // Yanlış cevap -> Can kaybet + Çok az XP (teşvik için 1 XP)
        provider.loseLife(); // 🔥 CAN KAYBI
        provider.addXP(1); // Path için düşük XP
        provider.addMistake(question['question'], selected, correct);
        
        // Yanlış cevaplanan kelimeyi spaced repetition'da düşür
        if (question['type'] == 'term') {
          String englishWord = '';
          for (var term in widget.category.terms) {
            if (term.english == question['question'] ||
                term.turkish == question['question']) {
              englishWord = term.english;
              break;
            }
          }
          if (englishWord.isNotEmpty) {
            provider.wordAnsweredWrongly(englishWord);
          }
        }
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _showFeedback = false;
        _writingController.clear();
        _wordCount = 0;
        _canProceedToQuestion = false;
        
        // Timer'ı sadece YENİ reading sorusu için sıfırla
        final nextQuestion = _questions[_currentIndex];
        if (nextQuestion['type'] == 'reading') {
          _readingSeconds = 0;
          _readingTimer?.cancel();
        }
        
        // Progress bar otomatik olarak _correctAnswers'a göre güncellenir
        // Yanlış cevaplarda _correctAnswers artmadığı için progress bar ilerlemez
      });
    } else {
      _finishLesson();
    }
  }

  void _finishLesson() async {
    setState(() {
      _showFeedback = false;
      _lessonComplete = true;

      // Move plane to end of runway
      _planeAnimation = Tween<double>(begin: _planeAnimation.value, end: 1.0)
          .animate(CurvedAnimation(
              parent: _planeController, curve: Curves.easeInOut));
      _planeController.forward(from: 0);
    });

    // Wait for plane to reach end
    await Future.delayed(const Duration(milliseconds: 600));

    // CHECK FOR PERFECT SCORE (10/10) FOR TAKEOFF
    if (_correctAnswers == _questions.length) {
      await _takeOffController.forward(); // Fly away!
      _confettiController.play(); // Party time
    } else {
      // Failed to take off - maybe a sound effect or small shake could go here
    }

    // Show Dialog
    if (!mounted) return;
    _showCompletionDialog();
  }

  // Kelime çevirisi bul - seçilen dile göre - TÜM kategorilere bakar
  String? _findTranslation(String word, Map<String, String>? wordTranslations) {
    // Seçilen dili al
    final provider = Provider.of<AppProvider>(context, listen: false);
    final langCode = provider.targetLanguage;
    
    // Noktalama işaretlerini temizle
    String cleanWord = word.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');

    // 1. Önce ortak kelime sözlüğüne bak (tüm dilleri destekler)
    final dictTranslation = getWordTranslation(cleanWord, langCode);
    if (dictTranslation != null && dictTranslation.isNotEmpty) {
      return dictTranslation;
    }

    // 2. TÜM kategorilerdeki terimlere bak - seçilen dile göre çeviri al
    for (var category in vocabulary.values) {
      for (var term in category.terms) {
        // Tam eşleşme
        if (term.english.toLowerCase() == cleanWord) {
          return term.getTranslation(langCode);
        }
        // Kelime başında veya içinde eşleşme (örn: "technicians" -> "technician")
        if (term.english.toLowerCase().contains(cleanWord) || 
            cleanWord.contains(term.english.toLowerCase())) {
          return term.getTranslation(langCode);
        }
      }
    }

    // 3. Seçilen dile göre wordTranslations'a bak (Türkçe legacy)
    if (wordTranslations != null && wordTranslations.containsKey(cleanWord)) {
      final trans = wordTranslations[cleanWord];
      if (trans != null && trans.isNotEmpty) return trans;
    }
    
    // 4. Reading'lerdeki çok dilli çevirilere bak
    for (var reading in widget.category.readings) {
      final langWordTranslations = reading.getWordTranslations(langCode);
      if (langWordTranslations != null && langWordTranslations.containsKey(cleanWord)) {
        final trans = langWordTranslations[cleanWord];
        if (trans != null && trans.isNotEmpty) return trans;
      }
    }

    return null;
  }

  // Hız seçimi chip'i - küçük buton
  Widget _buildSpeedChip(String emoji, double rate, String tooltip) {
    final isSelected = _speechRate == rate;
    return GestureDetector(
      onTap: () {
        setState(() {
          _speechRate = rate;
        });
      },
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }


  // Basit hover tooltip - düz cümle, tüm kelimeler beyaz, hover yapınca 2 saniye tooltip
  Widget _buildSimpleTooltip(String text, Map<String, String>? wordTranslations,
      BuildContext context) {
    final words = text.split(' ');

    return Wrap(
      children: words.asMap().entries.map((entry) {
        final index = entry.key;
        final word = entry.value;
        final isLast = index == words.length - 1;

        final translation = _findTranslation(word, wordTranslations);
        final hasTranslation = translation != null && translation.isNotEmpty;

        Widget wordWidget;

        // Tüm kelimeler beyaz, çevirisi varsa tooltip ekle
        if (hasTranslation) {
          wordWidget = Tooltip(
            message: translation,
            preferBelow: true,
            waitDuration: Duration.zero,
            showDuration: const Duration(seconds: 2),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            textStyle: const TextStyle(
              color: Colors.amber,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            child: Text(word,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          );
        } else {
          wordWidget = Text(word,
              style: const TextStyle(fontSize: 16, color: Colors.white));
        }

        // Kelimeden sonra boşluk ekle
        if (!isLast) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              wordWidget,
              const Text(' ', style: TextStyle(fontSize: 16))
            ],
          );
        }
        return wordWidget;
      }).toList(),
    );
  }

  void _showCompletionDialog() {
    bool isPerfect = _correctAnswers == _questions.length;

    // XP Hesaplama: Path için düşük XP (Oyun daha çok XP verir)
    _lessonTimer?.cancel();
    int baseXP = _correctAnswers * 3; // Düşük base XP
    int timeBonus = 0;

    // Hız bonusu: Düşürülmüş değerler
    if (_lessonSeconds < 120) {
      timeBonus = 10; // 2 dakikadan az
    } else if (_lessonSeconds < 180) {
      timeBonus = 5; // 3 dakikadan az
    } else if (_lessonSeconds < 300) {
      timeBonus = 2; // 5 dakikadan az
    }

    int perfectBonus = isPerfect ? 25 : 0; // Düşük perfect bonus
    _earnedXP = baseXP + timeBonus + perfectBonus;

    // Dakika:Saniye formatı
    String timeText =
        '${(_lessonSeconds ~/ 60).toString().padLeft(2, '0')}:${(_lessonSeconds % 60).toString().padLeft(2, '0')}';

    // Get mastery info for display
    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentMastery = provider.getMasteryLevel(widget.category.title);
    double performance = _questions.isNotEmpty ? _correctAnswers / _questions.length : 0;
    
    // Calculate expected new mastery level
    int expectedNewMastery = currentMastery;
    if (performance >= 0.8) {
      expectedNewMastery = (currentMastery + 1).clamp(0, 4);
    } else if (currentMastery == 0) {
      expectedNewMastery = 1;
    }
    
    bool willLevelUp = expectedNewMastery > currentMastery;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Text(isPerfect ? '🛫' : '🛬', style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 8),
            Text(isPerfect ? 'Ready for Takeoff!' : 'Grounded!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isPerfect
                  ? 'Perfect Score! Your aircraft has successfully departed.'
                  : 'Maintenance required! You need 100% accuracy for takeoff.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('Score: $_correctAnswers / ${_questions.length}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Text('⏱️ Süre: $timeText', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            
            // Mastery progression display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppProvider.masteryIcons[currentMastery] ?? '⚪',
                        style: const TextStyle(fontSize: 24),
                      ),
                      if (willLevelUp) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          AppProvider.masteryIcons[expectedNewMastery] ?? '🥉',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    willLevelUp 
                        ? '${AppProvider.masteryNames[currentMastery]} → ${AppProvider.masteryNames[expectedNewMastery]}!'
                        : 'Mastery: ${AppProvider.masteryNames[currentMastery]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: willLevelUp ? Colors.green : Colors.purple,
                    ),
                  ),
                  if (willLevelUp)
                    const Text(
                      'Level Up! 🎉',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  if (!willLevelUp && performance < 0.8 && currentMastery > 0)
                    Text(
                      'Get 80%+ to level up!',
                      style: TextStyle(color: Colors.orange.shade700, fontSize: 12),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                children: [
                  Text('⭐ Kazanılan XP: $_earnedXP',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber)),
                  if (timeBonus > 0)
                    Text('(+$timeBonus hız bonusu!)',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.green)),
                  if (isPerfect)
                    const Text('(+100 mükemmel bonus!)',
                        style: TextStyle(fontSize: 12, color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close screen
              
              // Use mastery-aware completion with performance data
              Provider.of<AppProvider>(context, listen: false)
                  .completeLessonWithMastery(
                    widget.category.title,
                    correctAnswers: _correctAnswers,
                    totalQuestions: _questions.length,
                  );
            },
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              widget.category.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Center(
                child: Text('✖️', style: TextStyle(fontSize: 20)),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text('✖️', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background - uçak, helikopter veya füze karma
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Builder(
                builder: (context) {
                  // 8 farklı görsel: 3 uçak, 3 helikopter, 2 füze
                  final backgrounds = [
                    'assets/images/airplane_bg_1.webp',
                    'assets/images/helicopter_bg_1.webp',
                    'assets/images/missile_bg_1.webp',
                    'assets/images/airplane_bg_2.webp',
                    'assets/images/helicopter_bg_2.webp',
                    'assets/images/missile_bg_2.webp',
                    'assets/images/airplane_bg_3.webp',
                    'assets/images/helicopter_bg_3.webp',
                  ];
                  final bgIndex = _currentIndex % backgrounds.length;
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.blue.shade700.withValues(alpha: 0.5),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      backgrounds[bgIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.transparent),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Duolingo-style Progress Bar
                Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: _correctAnswers / _questions.length,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF58CC02),
                      ),
                      minHeight: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // READING COMPREHENSION FLOW
                        if (question['type'] == 'reading') ...<Widget>[
                          // Kronometre - Okuma Süresi
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.blue.shade900
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.timer,
                                    color: Colors.white, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  '${Provider.of<AppProvider>(context).getString('reading_time')}: ${_readingSeconds ~/ 60}:${(_readingSeconds % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // İngilizce Passage - Kelime Hover ile Çeviri
                          Builder(
                            builder: (context) {
                              // Timer'ı başlat (henüz başlamadıysa VE soruya geçilmediyse)
                              if (!_canProceedToQuestion && 
                                  (_readingTimer == null ||
                                   !_readingTimer!.isActive)) {
                                _startReadingTimer();
                              }

                              return Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.1),
                                  border: Border(
                                      left: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 4)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '📖 Okuma Parçası',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber),
                                        ),
                                        Row(
                                          children: [
                                            // Hız seçimi chips
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black.withValues(alpha: 0.3),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _buildSpeedChip('🐌', 0.6, 'Yavaş'),
                                                  _buildSpeedChip('▶️', 0.9, 'Normal'),
                                                  _buildSpeedChip('⚡', 1.2, 'Hızlı'),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Ses butonu
                                            IconButton(
                                              icon: const Icon(Icons.volume_up,
                                                  color: Colors.amber, size: 28),
                                              onPressed: () =>
                                                  speakText(question['passage'], rate: _speechRate),
                                              tooltip: 'Metni Seslendir',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    _buildSimpleTooltip(question['passage'],
                                        question['wordTranslations'], context),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Soruya Geç Butonu
                          if (!_canProceedToQuestion)
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                minimumSize: const Size(double.infinity, 55),
                              ),
                              icon: const Icon(Icons.arrow_forward, size: 24),
                              onPressed: () {
                                _stopReadingTimer(); // Timer'ı durdur
                                setState(() {
                                  _canProceedToQuestion = true;
                                });
                              },
                              label: Text(
                                  Provider.of<AppProvider>(context)
                                      .getString('continue'),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),


                          // Soru ve Seçenekler (sadece kullanıcı hazır olduğunda)
                          if (_canProceedToQuestion) ...<Widget>[
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.orange, width: 2),
                              ),
                              child: Text(
                                question['question'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Cevap seçenekleri - Kompakt modern tasarım
                            ...((question['options'] as List<String>)
                                .asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final opt = entry.value;
                                  
                                  final accentColors = [
                                    const Color(0xFF3B82F6), // A - Mavi
                                    const Color(0xFF22C55E), // B - Yeşil
                                    const Color(0xFFF97316), // C - Turuncu
                                    const Color(0xFFA855F7), // D - Mor
                                  ];
                                  final accentColor = accentColors[index % accentColors.length];
                                  
                                  
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: GestureDetector(
                                      onTap: _showFeedback ? null : () => _checkAnswer(opt),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                        decoration: BoxDecoration(
                                          gradient: _showFeedback
                                              ? (opt == question['correct']
                                                  ? const LinearGradient(
                                                      colors: [Color(0xFF00b09b), Color(0xFF96c93d)],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  : LinearGradient(
                                                      colors: [Colors.grey.shade600, Colors.grey.shade800],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    ))
                                              : LinearGradient(
                                                  colors: [accentColor, accentColor.withValues(alpha: 0.7)],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                          borderRadius: BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color: accentColor.withValues(alpha: 0.4),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            // A, B, C, D Harfi
                                            Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withValues(alpha: 0.25),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  String.fromCharCode(65 + index),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            // Cevap metni
                                            Expanded(
                                              child: Text(
                                                opt,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            // Ok ikonu
                                            Icon(
                                              _showFeedback && opt == question['correct']
                                                  ? Icons.check_circle
                                                  : Icons.arrow_forward_ios,
                                              color: Colors.white.withValues(alpha: 0.8),
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                          ],
                        ],

                        // TERM QUESTIONS (Normal flow) - Kompakt & Odaklanma Odaklı
                        if (question['type'] == 'term') ...<Widget>[
                          // Question text - Minimalist tasarım
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              question['question'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Audio controls - Kompakt inline
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildSpeedChip('🐌', 0.6, 'Yavaş'),
                                    _buildSpeedChip('▶️', 0.9, 'Normal'),
                                    _buildSpeedChip('⚡', 1.2, 'Hızlı'),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () => speakText(question['question'], rate: _speechRate),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.volume_up, color: Colors.amber, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Cevap seçenekleri - Ultra kompakt modern tasarım
                          ...((question['options'] as List<String>)
                              .asMap().entries.map((entry) {
                                final index = entry.key;
                                final opt = entry.value;
                                
                                // Belirgin farklı renkler
                                final accentColors = [
                                  const Color(0xFF3B82F6), // A - Mavi
                                  const Color(0xFF22C55E), // B - Yeşil
                                  const Color(0xFFF97316), // C - Turuncu
                                  const Color(0xFFA855F7), // D - Mor
                                ];
                                final accentColor = accentColors[index % accentColors.length];
                                
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: GestureDetector(
                                    onTap: _showFeedback ? null : () => _checkAnswer(opt),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                      decoration: BoxDecoration(
                                        gradient: _showFeedback
                                            ? (opt == question['correct']
                                                ? const LinearGradient(
                                                    colors: [Color(0xFF00b09b), Color(0xFF96c93d)],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  )
                                                : LinearGradient(
                                                    colors: [Colors.grey.shade600, Colors.grey.shade800],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ))
                                            : LinearGradient(
                                                colors: [accentColor, accentColor.withValues(alpha: 0.7)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: accentColor.withValues(alpha: 0.4),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // A, B, C, D Harfi
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(alpha: 0.25),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                String.fromCharCode(65 + index),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          // Cevap metni
                                          Expanded(
                                            child: Text(
                                              opt,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // Ok ikonu
                                          Icon(
                                            _showFeedback && opt == question['correct']
                                                ? Icons.check_circle
                                                : Icons.arrow_forward_ios,
                                            color: Colors.white.withValues(alpha: 0.8),
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ],

                        // WRITING QUESTION
                        if (question['type'] == 'writing')
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _writingController,
                                  maxLines: 8,
                                  onChanged: (text) {
                                    setState(() {
                                      _wordCount = text.trim().isEmpty
                                          ? 0
                                          : text
                                              .trim()
                                              .split(RegExp(r'\s+'))
                                              .length;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: Provider.of<AppProvider>(context)
                                        .getString('write_hint'),
                                    filled: true,
                                    fillColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[900]
                                        : Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Word Count: $_wordCount / 25',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _wordCount >= 25
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 32),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () => _checkAnswer('WRITING_TASK'),
                                  child: Text(
                                      Provider.of<AppProvider>(context)
                                          .getString('check'),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Feedback Overlay - tüm ekranı karart ve ortada büyük göster
          if (_showFeedback && !_lessonComplete)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _isCorrect
                        ? [
                            const Color(0xFF00b09b).withValues(alpha: 0.95),
                            const Color(0xFF96c93d).withValues(alpha: 0.95),
                          ]
                        : [
                            const Color(0xFFeb3349).withValues(alpha: 0.95),
                            const Color(0xFFf45c43).withValues(alpha: 0.95),
                          ],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Büyük ikon
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _isCorrect ? '✓' : '✗',
                                style: const TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Başlık metni
                          Text(
                            _isCorrect
                                ? Provider.of<AppProvider>(context)
                                    .getString('correct_feedback')
                                : 'YANLIŞ!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Doğru cevabı göster (sadece yanlış cevaplarda)
                          if (!_isCorrect) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.25),
                                    Colors.white.withValues(alpha: 0.15),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lightbulb_outline,
                                        color: Colors.amber.shade300,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Doğru Cevap',
                                        style: TextStyle(
                                          color: Colors.amber.shade100,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    question['correct'] ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          
                          // Butonlar - Neon Cyberpunk Tarzı
                          Row(
                            children: [
                              // Çıkış butonu - Neon Holografik
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.cyan.withValues(alpha: 0.8),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withValues(alpha: 0.4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: Colors.cyan.withValues(alpha: 0.2),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      borderRadius: BorderRadius.circular(14),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.power_settings_new_rounded,
                                              color: Colors.cyan.shade300,
                                              size: 22,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.cyan,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'ÇIKIŞ',
                                              style: TextStyle(
                                                color: Colors.cyan.shade200,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.cyan,
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Devam Et butonu - 3D Neon Glow
                              Expanded(
                                flex: 2,
                                child: Stack(
                                  children: [
                                    // Alt gölge (3D efekt)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: _isCorrect 
                                            ? const Color(0xFF00b09b).withValues(alpha: 0.5)
                                            : const Color(0xFFeb3349).withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    // Ana buton
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: _isCorrect
                                              ? [const Color(0xFF00b09b), const Color(0xFF96c93d)]
                                              : [const Color(0xFFeb3349), const Color(0xFFf45c43)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.4),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (_isCorrect 
                                                    ? const Color(0xFF00b09b) 
                                                    : const Color(0xFFeb3349))
                                                .withValues(alpha: 0.6),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _nextQuestion,
                                          borderRadius: BorderRadius.circular(14),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 18),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.rocket_launch_rounded,
                                                  color: Colors.white,
                                                  size: 24,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black26,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  Provider.of<AppProvider>(context)
                                                      .getString('continue')
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black26,
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(
                                                  Icons.double_arrow_rounded,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ),
        ],
      ),
    );
  }
}
