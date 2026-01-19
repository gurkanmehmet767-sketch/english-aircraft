import 'package:flutter/material.dart';

class PlacementScreen extends StatefulWidget {
  final void Function(String level) onLevelSelected;
  const PlacementScreen({super.key, required this.onLevelSelected});

  @override
  State<PlacementScreen> createState() => _PlacementScreenState();
}

class _PlacementScreenState extends State<PlacementScreen> {
  String? _selectedLevel;

  // Kullanıcıya sormak için seçenekler
  final List<Map<String, dynamic>> _options = [
    {
      'icon': '🆕',
      'title': 'Hiç bilmiyorum',
      'subtitle': 'Uçak terimlerini ilk defa öğreneceğim',
      'level': 'A1',
      'color': Colors.blue,
    },
    {
      'icon': '📚',
      'title': 'Biraz biliyorum',
      'subtitle': 'Temel bazı terimleri duydum',
      'level': 'A2',
      'color': Colors.green,
    },
    {
      'icon': '✈️',
      'title': 'Orta düzey bilgim var',
      'subtitle': 'Havacılık terimleriyle az çok haşır neşirim',
      'level': 'B1',
      'color': Colors.orange,
    },
    {
      'icon': '🔧',
      'title': 'İyi derecede biliyorum',
      'subtitle': 'Teknik terimlerin çoğunu biliyorum',
      'level': 'B2',
      'color': Colors.deepPurple,
    },
    {
      'icon': '🎓',
      'title': 'Uzman seviyesindeyim',
      'subtitle': 'Havacılıkta profesyonel deneyimim var',
      'level': 'C1',
      'color': Colors.red,
    },
  ];

  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  void _continueWithLevel() {
    if (_selectedLevel != null) {
      widget.onLevelSelected(_selectedLevel!);
      // Navigator.pop() kaldırıldı - main.dart içinde setState ile yönetiliyor
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF000000), const Color(0xFF001A00)]
                : [const Color(0xFF1E88E5), const Color(0xFF42A5F5)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Başlık
                const Text(
                  '✈️',
                  style: TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Hos Geldiniz!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Havacilik terimleri hakkindaki\nbilgi seviyeniz nedir?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),

                // Seçenekler
                Expanded(
                  child: ListView.builder(
                    itemCount: _options.length,
                    itemBuilder: (context, index) {
                      final option = _options[index];
                      final isSelected = _selectedLevel == option['level'];

                      return GestureDetector(
                        onTap: () => _selectLevel(option['level']),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (option['color'] as Color).withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? option['color'] as Color
                                  : Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: (option['color'] as Color)
                                          .withValues(alpha: 0.4),
                                      blurRadius: 12,
                                      spreadRadius: 0,
                                    )
                                  ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              // İkon
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    option['icon'],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Metin
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option['subtitle'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Seçim işareti
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: option['color'] as Color,
                                  size: 28,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Devam butonu
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedLevel != null ? _continueWithLevel : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: isDark ? Colors.green : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.white.withValues(alpha: 0.3),
                      disabledForegroundColor: Colors.white54,
                    ),
                    child: Text(
                      _selectedLevel != null ? 'Basla' : 'Bir secenek secin',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
