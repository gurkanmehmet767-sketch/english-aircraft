import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/vocabulary_data_fixed.dart';
import '../data/word_dictionary.dart';
// dart:math import removed - not used

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

enum ReviewMode { turkishToEnglish, englishToTurkish }

class _ReviewScreenState extends State<ReviewScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> _reviewWords = [];
  int _currentIndex = 0;
  bool _showAnswer = false;
  // Note: _isCorrect was removed as it was set but never read
  bool _sessionComplete = false;
  int _correctCount = 0;
  int _wrongCount = 0;
  ReviewMode? _selectedMode;

  late AnimationController _cardController;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _cardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeInOut),
    );
    _loadReviewWords();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  void _loadReviewWords() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final langCode = provider.targetLanguage;

    // Tekrar gereken kelimeler + zayıf kelimeler
    final wordsToReview = provider.getWordsNeedingReview(limit: 20);
    final weakWordsList = provider.weakWords;

    // Tüm kelimeleri birleştir
    final allWords = <String>{...wordsToReview, ...weakWordsList.take(10)};

    // Her kelime için çeviri bul
    _reviewWords = [];
    for (final word in allWords) {
      String? translation;

      // vocabulary_data'dan çeviri bul
      for (var category in vocabulary.values) {
        for (var term in category.terms) {
          if (term.english.toLowerCase() == word.toLowerCase()) {
            translation = term.getTranslation(langCode);
            break;
          }
        }
        if (translation != null) break;
      }

      // word_dictionary'den çeviri bul
      translation ??= getWordTranslation(word, langCode);

      if (translation != null && translation.isNotEmpty) {
        _reviewWords.add({
          'english': word,
          'translation': translation,
          'strength': provider.getWordStrength(word),
        });
      }
    }

    // Karıştır
    _reviewWords.shuffle();

    // Limit 20
    if (_reviewWords.length > 20) {
      _reviewWords = _reviewWords.take(20).toList();
    }

    setState(() {});
  }

  void _showAnswerCard() {
    _cardController.forward();
    setState(() {
      _showAnswer = true;
    });
  }

  void _answerCorrect() {
    if (!_showAnswer) return;

    final provider = Provider.of<AppProvider>(context, listen: false);
    final word = _reviewWords[_currentIndex]['english'];
    provider.wordAnsweredCorrectly(word);
    provider.addXP(5);

    setState(() {
      _correctCount++;
    });

    Future.delayed(const Duration(milliseconds: 500), _nextWord);
  }

  void _answerWrong() {
    if (!_showAnswer) return;

    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentWord = _reviewWords[_currentIndex];
    final word = currentWord['english'];
    provider.wordAnsweredWrongly(word);

    // Yanlış cevaplanan kelimeyi 2 kez daha ekle (tekrar için)
    final repeatCount = (currentWord['repeatCount'] ?? 0) as int;
    if (repeatCount < 2) {
      // Kelimeyi listeye geri ekle (birkaç kelime sonra tekrar göster)
      final insertIndex = (_currentIndex + 3).clamp(0, _reviewWords.length);
      _reviewWords.insert(insertIndex, {
        'english': currentWord['english'],
        'translation': currentWord['translation'],
        'strength': currentWord['strength'],
        'repeatCount': repeatCount + 1,
      });
    }

    setState(() {
      _wrongCount++;
    });

    Future.delayed(const Duration(milliseconds: 500), _nextWord);
  }

  void _nextWord() {
    if (_currentIndex < _reviewWords.length - 1) {
      _cardController.reset();
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    } else {
      setState(() {
        _sessionComplete = true;
      });
    }
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStrengthName(int strength) {
    switch (strength) {
      case 0:
        return 'Yeni';
      case 1:
        return 'Öğreniliyor';
      case 2:
        return 'Tanıdık';
      case 3:
        return 'İyi';
      case 4:
        return 'Güçlü';
      case 5:
        return 'Ustalaşmış';
      default:
        return 'Yeni';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Provider.of<AppProvider>(context); // Keep listening for changes

    // Mod seçilmemişse seçim ekranı göster
    if (_selectedMode == null) {
      return _buildModeSelectionScreen(isDark);
    }

    if (_reviewWords.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('🔄 TEKRAR'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Harika! 🎉',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Şu an tekrar edilecek kelime yok.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ders çalışarak yeni kelimeler öğren!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Geri Dön'),
              ),
            ],
          ),
        ),
      );
    }

    if (_sessionComplete) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('🔄 TEKRAR'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _correctCount > _wrongCount
                    ? Icons.emoji_events
                    : Icons.refresh,
                size: 80,
                color: _correctCount > _wrongCount ? Colors.amber : Colors.blue,
              ),
              const SizedBox(height: 24),
              Text(
                _correctCount > _wrongCount ? 'Tebrikler! 🎉' : 'Devam Et! 💪',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatCard('Doğru', _correctCount, Colors.green),
                  const SizedBox(width: 20),
                  _buildStatCard('Yanlış', _wrongCount, Colors.red),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                        _correctCount = 0;
                        _wrongCount = 0;
                        _sessionComplete = false;
                        _showAnswer = false;
                      });
                      _loadReviewWords();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Et'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check),
                    label: const Text('Bitir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final currentWord = _reviewWords[_currentIndex];
    final strength = currentWord['strength'] as int;
    final provider = Provider.of<AppProvider>(context);
    final targetFlag = provider.currentFlag;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '🔄 ${provider.getString('review')} ${_currentIndex + 1}/${_reviewWords.length}'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: _getStrengthColor(strength).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _getStrengthColor(strength)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fitness_center,
                    size: 16, color: _getStrengthColor(strength)),
                const SizedBox(width: 4),
                Text(
                  _getStrengthName(strength),
                  style: TextStyle(
                    color: _getStrengthColor(strength),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _reviewWords.length,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark ? Colors.cyan : Colors.blue,
                ),
              ),
              const SizedBox(height: 32),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 18),
                        const SizedBox(width: 4),
                        Text('$_correctCount',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.close, color: Colors.red, size: 18),
                        const SizedBox(width: 4),
                        Text('$_wrongCount',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Word Card
              GestureDetector(
                onTap: _showAnswer ? null : _showAnswerCard,
                child: AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    final isFrontVisible = _cardAnimation.value < 0.5;
                    final rotationAngle = _cardAnimation.value * 3.14159;

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(rotationAngle),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isFrontVisible
                                ? [Colors.blue.shade400, Colors.blue.shade700]
                                : [
                                    Colors.green.shade400,
                                    Colors.green.shade700
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (isFrontVisible ? Colors.blue : Colors.green)
                                      .withValues(alpha: 0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: isFrontVisible
                              ? Matrix4.identity()
                              : (Matrix4.identity()..rotateY(3.14159)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isFrontVisible
                                    ? (_selectedMode ==
                                            ReviewMode.englishToTurkish
                                        ? '🇬🇧'
                                        : targetFlag)
                                    : (_selectedMode ==
                                            ReviewMode.englishToTurkish
                                        ? targetFlag
                                        : '🇬🇧'),
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                isFrontVisible
                                    ? (_selectedMode ==
                                            ReviewMode.englishToTurkish
                                        ? currentWord['english']
                                        : currentWord['translation'])
                                    : (_selectedMode ==
                                            ReviewMode.englishToTurkish
                                        ? currentWord['translation']
                                        : currentWord['english']),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (isFrontVisible && !_showAnswer) ...[
                                const SizedBox(height: 24),
                                const Text(
                                  'Tıkla ve cevabı gör',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              // Answer buttons
              if (_showAnswer)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _answerWrong,
                        icon: const Icon(Icons.close, size: 28),
                        label: const Text('Bilmedim',
                            style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _answerCorrect,
                        icon: const Icon(Icons.check, size: 28),
                        label: const Text('Bildim',
                            style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                ElevatedButton.icon(
                  onPressed: _showAnswerCard,
                  icon: const Icon(Icons.visibility, size: 24),
                  label: const Text('Cevabı Göster',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.cyan : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelectionScreen(bool isDark) {
    final provider = Provider.of<AppProvider>(context);
    final targetFlag = provider.currentFlag;
    final targetLangName = provider.currentLanguageName;

    return Scaffold(
      appBar: AppBar(
        title: Text('🔄 ${provider.getString('review')} MODU'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hangi yönde çalışmak istiyorsun?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // [Hedef Dil] → İngilizce
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMode = ReviewMode.turkishToEnglish;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red.shade400, Colors.red.shade700],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(targetFlag,
                              style: const TextStyle(fontSize: 40)),
                          const SizedBox(width: 16),
                          const Icon(Icons.arrow_forward,
                              color: Colors.white, size: 32),
                          const SizedBox(width: 16),
                          const Text('🇬🇧', style: TextStyle(fontSize: 40)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$targetLangName\'den İngilizce\'ye',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$targetLangName kelimeyi gör, İngilizce\'sini tahmin et',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // İngilizce → [Hedef Dil]
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMode = ReviewMode.englishToTurkish;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🇬🇧', style: TextStyle(fontSize: 40)),
                          const SizedBox(width: 16),
                          const Icon(Icons.arrow_forward,
                              color: Colors.white, size: 32),
                          const SizedBox(width: 16),
                          Text(targetFlag,
                              style: const TextStyle(fontSize: 40)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'İngilizce\'den $targetLangName\'ye',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'İngilizce kelimeyi gör, $targetLangName\'sini tahmin et',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
