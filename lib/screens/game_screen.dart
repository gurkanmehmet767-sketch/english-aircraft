import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/vocabulary_data_fixed.dart' as vocab_data;
import 'dart:math';

// 🎮 Uçan XP animasyonu için yardımcı sınıf
class _FloatingXP {
  final String text;
  final Offset position;
  final DateTime createdAt;
  final Color color;

  _FloatingXP({
    required this.text,
    required this.position,
    required this.createdAt,
    this.color = Colors.green,
  });

  bool get isExpired =>
      DateTime.now().difference(createdAt).inMilliseconds > 1500;
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  // Word Galaxy - Vocabulary Data'dan kelimeler
  late List<String> _allWords;

  @override
  void initState() {
    super.initState();
    _loadWordsFromVocabulary();
    _initAnimations();
    _setupLetterListener(); // Harf dinleyici ekle
  }

  void _loadWordsFromVocabulary() {
    // Vocabulary data'dan tüm İngilizce kelimeleri çek
    final Set<String> wordSet = {};

    for (final category in vocab_data.vocabulary.values) {
      for (final term in category.terms) {
        // Sadece tek kelimeli terimleri al (boşluk içermeyenler)
        final word = term.english.toUpperCase().trim();
        if (!word.contains(' ') && word.length >= 3 && word.length <= 12) {
          wordSet.add(word);
        }
      }
    }

    _allWords = wordSet.toList()..shuffle();
  }

  late String _currentWord;
  late String _scrambledWord;
  final TextEditingController _controller = TextEditingController();
  bool _isCorrect = false;
  bool _isWrong = false;

  // Game Settings
  int _difficulty =
      1; // 0: Easy (3-5 chars), 1: Medium (6-8 chars), 2: Hard (9+ chars)
  int _score = 0;
  int _wordsPlayed = 0;
  int _correctAnswers = 0;
  bool _showHint = false;
  int _lastXPGain = 0; // Son kazanılan XP miktarı

  // 🎮 HARF BAZLI XP SİSTEMİ
  int _correctLetterCount = 0; // Şu ana kadar doğru yazılan harf sayısı
  int _letterXPEarned = 0; // Bu kelime için kazanılan harf XP'si
  final List<_FloatingXP> _floatingXPs = []; // Uçan XP animasyonları

  // Timer
  late AnimationController _timerController;
  int _timeLeft = 30; // seconds per word
  final bool _timerEnabled = true;

  late AnimationController _pulseController;
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  void _initAnimations() {
    // Timer controller - 30 seconds countdown
    _timerController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _timerController.addListener(() {
      final newTimeLeft = (30 * (1 - _timerController.value)).round();
      if (newTimeLeft != _timeLeft) {
        setState(() {
          _timeLeft = newTimeLeft;
        });
      }
    });

    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.completed && _timerEnabled) {
        // Time's up! Load new word
        _loadNewWord();
      }
    });

    // Pulse animation for the question box
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Glow animation
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _loadNewWord();
  }

  // 🎮 HARF BAZLI XP - Her doğru harf için XP ver ve animasyon göster
  void _setupLetterListener() {
    _controller.addListener(_onTextChanged);

    // Expired animasyonları temizle (her 100ms)
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return false;
      setState(() {
        _floatingXPs.removeWhere((xp) => xp.isExpired);
      });
      return mounted;
    });
  }

  void _onTextChanged() {
    if (_isCorrect || !mounted) return; // Zaten doğru cevaplandıysa çık

    final typed = _controller.text.toUpperCase();
    final target = _currentWord;

    // Kaç harf doğru yazılmış say
    int correctCount = 0;
    for (int i = 0; i < typed.length && i < target.length; i++) {
      if (typed[i] == target[i]) {
        correctCount++;
      } else {
        break; // İlk yanlış harfte dur
      }
    }

    // Yeni doğru harf yazıldıysa XP ver ve animasyon göster
    if (correctCount > _correctLetterCount) {
      int newCorrectLetters = correctCount - _correctLetterCount;
      int xpPerLetter = 2;
      int earnedXP = newCorrectLetters * xpPerLetter;

      // XP ekle
      Provider.of<AppProvider>(context, listen: false).addXP(earnedXP);
      _letterXPEarned += earnedXP;

      // Uçan XP animasyonu ekle
      setState(() {
        _correctLetterCount = correctCount;

        // Her yeni doğru harf için floating XP ekle
        for (int i = 0; i < newCorrectLetters; i++) {
          final random = Random();
          _floatingXPs.add(_FloatingXP(
            text: '+$xpPerLetter XP',
            position: Offset(
              150 + random.nextDouble() * 100, // Rastgele X pozisyonu
              200 + random.nextDouble() * 50, // Rastgele Y pozisyonu
            ),
            createdAt: DateTime.now().add(Duration(milliseconds: i * 100)),
            color: Colors.green,
          ));
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _timerController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<String> _getFilteredWords() {
    switch (_difficulty) {
      case 0: // Easy: 3-5 characters
        return _allWords.where((w) => w.length >= 3 && w.length <= 5).toList();
      case 1: // Medium: 6-8 characters
        return _allWords.where((w) => w.length >= 6 && w.length <= 8).toList();
      case 2: // Hard: 9+ characters
        return _allWords.where((w) => w.length >= 9).toList();
      default:
        return _allWords;
    }
  }

  void _loadNewWord() {
    // Reset and start timer
    if (_timerEnabled) {
      _timerController.reset();
      _timeLeft = 30;
      _timerController.forward();
    }

    setState(() {
      final filteredWords = _getFilteredWords();
      if (filteredWords.isEmpty) {
        _currentWord = _allWords[Random().nextInt(_allWords.length)];
      } else {
        _currentWord = filteredWords[Random().nextInt(filteredWords.length)];
      }
      List<String> chars = _currentWord.split('');
      chars.shuffle();
      // Make sure scrambled word is different from original
      while (chars.join('') == _currentWord && _currentWord.length > 1) {
        chars.shuffle();
      }
      _scrambledWord = chars.join('');
      _controller.clear();
      _isCorrect = false;
      _isWrong = false;
      _showHint = false;
      _wordsPlayed++;

      // 🎮 Harf XP sayaçlarını sıfırla
      _correctLetterCount = 0;
      _letterXPEarned = 0;
      _floatingXPs.clear();
    });
  }

  void _checkWord() {
    if (_controller.text.toUpperCase() == _currentWord) {
      // Stop timer on correct answer
      _timerController.stop();

      setState(() {
        _isCorrect = true;
        _isWrong = false;
        _correctAnswers++;
        // Score based on difficulty + time bonus + hint penalty
        int basePoints = (_difficulty + 1) * 10;
        int timeBonus = _timeLeft; // Bonus for remaining time
        int hintPenalty = _showHint ? 10 : 0;
        _score += basePoints + timeBonus - hintPenalty;
      });

      // 🎮 TAMAMLAMA BONUSU - Harf XP'si zaten verildi, sadece bonus ekle
      int difficultyBonus =
          (_difficulty + 1) * 5; // Kolay: 5, Orta: 10, Zor: 15
      int timeBonus = (_timeLeft ~/ 5); // Kalan süre bonusu
      int completionBonus = difficultyBonus + timeBonus;

      if (_showHint)
        completionBonus = (completionBonus * 0.7).round(); // Hint penalty

      // Toplam XP = harf bazlı XP + tamamlama bonusu
      _lastXPGain = _letterXPEarned + completionBonus;
      Provider.of<AppProvider>(context, listen: false).addXP(completionBonus);

      // Büyük "TAMAMLANDI" animasyonu ekle
      _floatingXPs.add(_FloatingXP(
        text: '🎉 +$_lastXPGain XP',
        position: const Offset(120, 150),
        createdAt: DateTime.now(),
        color: Colors.amber,
      ));

      Future.delayed(const Duration(seconds: 1), _loadNewWord);
    } else {
      setState(() {
        _isWrong = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isWrong = false;
        });
      });
    }
  }

  void _useHint() {
    setState(() {
      _showHint = true;
    });
  }

  String get _difficultyText {
    switch (_difficulty) {
      case 0:
        return 'KOLAY';
      case 1:
        return 'ORTA';
      case 2:
        return 'ZOR';
      default:
        return 'ORTA';
    }
  }

  Color _getDifficultyColor(bool isDark) {
    switch (_difficulty) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define cockpit colors
    final primaryNeon =
        isDark ? const Color(0xFF00D4FF) : const Color(0xFF0099CC);
    final secondaryNeon =
        isDark ? const Color(0xFF00FF88) : const Color(0xFF00CC66);
    final warningNeon = const Color(0xFFFF6B35);
    final bgColor = isDark ? const Color(0xFF0A1628) : const Color(0xFFF0F4F8);

    Color currentGlow =
        _isCorrect ? secondaryNeon : (_isWrong ? warningNeon : primaryNeon);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flight, color: primaryNeon, size: 24),
            const SizedBox(width: 8),
            Text(
              'WORD GALAXY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: primaryNeon,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Ana içerik
          Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Stats Bar - Score, Words Played, Difficulty
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: primaryNeon.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Score
                        Column(
                          children: [
                            Icon(Icons.stars, color: Colors.amber, size: 20),
                            const SizedBox(height: 4),
                            Text(
                              '$_score',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'PUAN',
                              style: TextStyle(
                                color: primaryNeon.withValues(alpha: 0.6),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // XP Display
                        Consumer<AppProvider>(
                          builder: (context, provider, _) => Column(
                            children: [
                              Icon(Icons.bolt, color: Colors.purple, size: 20),
                              const SizedBox(height: 4),
                              Text(
                                '${provider.totalXP}',
                                style: const TextStyle(
                                  color: Colors.purple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'XP',
                                style: TextStyle(
                                  color: primaryNeon.withValues(alpha: 0.6),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Correct / Total
                        Column(
                          children: [
                            Icon(Icons.check_circle,
                                color: secondaryNeon, size: 20),
                            const SizedBox(height: 4),
                            Text(
                              '$_correctAnswers/$_wordsPlayed',
                              style: TextStyle(
                                color: secondaryNeon,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'DOĞRU',
                              style: TextStyle(
                                color: primaryNeon.withValues(alpha: 0.6),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        // Difficulty Selector
                        Column(
                          children: [
                            Icon(Icons.speed,
                                color: _getDifficultyColor(isDark), size: 20),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _difficulty = (_difficulty + 1) % 3;
                                });
                                _loadNewWord();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(isDark)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _difficultyText,
                                  style: TextStyle(
                                    color: _getDifficultyColor(isDark),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'SEVİYE',
                              style: TextStyle(
                                color: primaryNeon.withValues(alpha: 0.6),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        // ⏱️ SÜRE GİZLİ - Arka planda çalışıyor ama kullanıcı görmüyor
                        // XP hesaplaması için hala kullanılıyor
                      ],
                    ),
                  ),

                  // Instruction text with cockpit style
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: primaryNeon.withValues(alpha: 0.3), width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.radar, color: primaryNeon, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'UNSCRAMBLE THE AVIATION TERM',
                          style: TextStyle(
                            color: primaryNeon.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hint display
                  if (_showHint)
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lightbulb,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'İlk harf: ${_currentWord[0]}',
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Main question box with neon glow effect
                  AnimatedBuilder(
                    animation:
                        Listenable.merge([_pulseAnimation, _glowAnimation]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 20),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.4)
                                : Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: currentGlow,
                              width: 2,
                            ),
                            boxShadow: [
                              // Outer glow
                              BoxShadow(
                                color: currentGlow.withValues(
                                    alpha: _glowAnimation.value * 0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                              // Inner glow
                              BoxShadow(
                                color: currentGlow.withValues(
                                    alpha: _glowAnimation.value * 0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Decorative top line
                              Container(
                                width: 60,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      currentGlow,
                                      Colors.transparent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Scrambled word
                              Text(
                                _scrambledWord,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 8,
                                  color: isDark ? Colors.white : Colors.black87,
                                  shadows: [
                                    Shadow(
                                      color: currentGlow.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Decorative bottom line
                              Container(
                                width: 60,
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      currentGlow,
                                      Colors.transparent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Input field with cockpit style
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: primaryNeon.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryNeon.withValues(alpha: 0.1),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.characters,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'TYPE ANSWER',
                        hintStyle: TextStyle(
                          color: primaryNeon.withValues(alpha: 0.4),
                          letterSpacing: 2,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      onSubmitted: (_) => _checkWord(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Check button with neon style
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: secondaryNeon.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _checkWord,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryNeon,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 22),
                          const SizedBox(width: 10),
                          const Text(
                            'CHECK ANSWER',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Status indicators
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isCorrect
                        ? Container(
                            key: const ValueKey('correct'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: secondaryNeon.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: secondaryNeon, width: 1.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.rocket_launch,
                                    color: secondaryNeon, size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  'CORRECT! +20 XP',
                                  style: TextStyle(
                                    color: secondaryNeon,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '+$_lastXPGain XP',
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _isWrong
                            ? Container(
                                key: const ValueKey('wrong'),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                decoration: BoxDecoration(
                                  color: warningNeon.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: warningNeon, width: 1.5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.warning_amber,
                                        color: warningNeon, size: 24),
                                    const SizedBox(width: 10),
                                    Text(
                                      'TRY AGAIN!',
                                      style: TextStyle(
                                        color: warningNeon,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 48, key: ValueKey('empty')),
                  ),

                  const SizedBox(height: 16),

                  // Hint and Skip buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hint button
                      if (!_showHint)
                        TextButton.icon(
                          onPressed: _useHint,
                          icon: Icon(Icons.lightbulb_outline,
                              color: Colors.amber.withValues(alpha: 0.7)),
                          label: Text(
                            'İPUCU',
                            style: TextStyle(
                              color: Colors.amber.withValues(alpha: 0.7),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      if (!_showHint) const SizedBox(width: 16),
                      // Skip button
                      TextButton.icon(
                        onPressed: _loadNewWord,
                        icon: Icon(Icons.skip_next,
                            color: primaryNeon.withValues(alpha: 0.7)),
                        label: Text(
                          'KELİME GEÇ',
                          style: TextStyle(
                            color: primaryNeon.withValues(alpha: 0.7),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 🎮 UÇAN XP ANİMASYONLARI
          ..._floatingXPs.map((floatingXP) {
            final age =
                DateTime.now().difference(floatingXP.createdAt).inMilliseconds;
            final progress = (age / 1500).clamp(0.0, 1.0);
            final opacity = 1.0 - progress;
            final yOffset = progress * 80; // Yukarı doğru hareket
            final scale = 1.0 + (progress * 0.5); // Büyüme efekti

            return Positioned(
              left: floatingXP.position.dx,
              top: floatingXP.position.dy - yOffset,
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: floatingXP.color.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: floatingXP.color.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      floatingXP.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
