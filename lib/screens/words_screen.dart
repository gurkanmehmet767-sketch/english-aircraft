import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/vocabulary_data_fixed.dart' as vocab_data;
import '../models/vocabulary_models.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  String _searchQuery = '';
  String? _selectedSection;
  // Removed unused fields: _showOnlyLearned and _selectedDifficulty
  final Set<String> _expandedSections = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    // Her section için kelimeleri grupla
    final Map<String, List<MapEntry<String, CategoryData>>> sectionGroups = {};
    for (var entry in vocab_data.vocabulary.entries) {
      final section = entry.value.section ?? 'Unknown';
      sectionGroups.putIfAbsent(section, () => []).add(entry);
    }

    // Filtreleme ve arama
    Map<String, List<MapEntry<String, CategoryData>>> filteredGroups = {};
    for (var sectionEntry in sectionGroups.entries) {
      final sectionKey = sectionEntry.key;
      final categories = sectionEntry.value;

      // Section filtresi
      if (_selectedSection != null && sectionKey != _selectedSection) {
        continue;
      }

      final filteredCategories = categories.where((catEntry) {
        final category = catEntry.value;

        // Search query filtresi
        if (_searchQuery.isNotEmpty) {
          final hasMatch = category.terms.any((term) =>
              term.english.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              term.turkish.toLowerCase().contains(_searchQuery.toLowerCase()));
          if (!hasMatch) return false;
        }

        return true;
      }).toList();

      if (filteredCategories.isNotEmpty) {
        filteredGroups[sectionKey] = filteredCategories;
      }
    }

    // Toplam kelime sayısını hesapla
    int getTotalWords(List<MapEntry<String, CategoryData>> categories) {
      return categories.fold(0, (sum, entry) => sum + entry.value.terms.length);
    }

    // Öğrenilen kelime sayısı
    int getLearnedWords(List<MapEntry<String, CategoryData>> categories) {
      int count = 0;
      for (var entry in categories) {
        for (var term in entry.value.terms) {
          if (provider.learnedWords.contains(term.english)) {
            count++;
          }
        }
      }
      return count;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.getString('words_title')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Arama ve filtre alanı
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            child: Column(
              children: [
                // Arama kutusu
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: provider.getString('search_words'),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                // Filtre chip'leri
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Section filtreleri
                      ChoiceChip(
                        label: Text(provider.getString('all_sections')),
                        selected: _selectedSection == null,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSection = null;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ...vocab_data.sectionTitles.keys.map((section) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(section),
                            selected: _selectedSection == section,
                            onSelected: (selected) {
                              setState(() {
                                _selectedSection = selected ? section : null;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // İstatistik özeti
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  '📚',
                  provider.getString('total'),
                  filteredGroups.values
                      .fold(0, (sum, cats) => sum + getTotalWords(cats))
                      .toString(),
                ),
                _buildStatItem(
                  context,
                  '✅',
                  provider.getString('learned'),
                  provider.learnedWords.length.toString(),
                ),
                _buildStatItem(
                  context,
                  '📂',
                  provider.getString('sections'),
                  filteredGroups.length.toString(),
                ),
              ],
            ),
          ),

          // Kelime listesi (section bazlı)
          Expanded(
            child: ListView.builder(
              itemCount: filteredGroups.length,
              itemBuilder: (context, index) {
                final sectionKey = filteredGroups.keys.elementAt(index);
                final categories = filteredGroups[sectionKey]!;
                final isExpanded = _expandedSections.contains(sectionKey);

                final totalWords = getTotalWords(categories);
                final learnedWords = getLearnedWords(categories);

                // Section rengi
                Color getSectionColor(String section) {
                  final sectionColors = {
                    '1. KISIM': const Color(0xFF58CC02),
                    '2. KISIM': Colors.red,
                    '3. KISIM': Colors.pink,
                    '4. KISIM': Colors.orange,
                    '5. KISIM': Colors.purple,
                    '6. KISIM': Colors.blue,
                    '7. KISIM': Colors.teal,
                  };
                  return sectionColors[section] ?? Colors.blue;
                }

                final sectionColor = getSectionColor(sectionKey);

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Column(
                    children: [
                      // Section header (tıklanabilir)
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              _expandedSections.remove(sectionKey);
                            } else {
                              _expandedSections.add(sectionKey);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: sectionColor.withValues(alpha: 0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Section ikonu
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: sectionColor.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    vocab_data.sectionIcons[sectionKey] ?? '📚',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Section bilgisi
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sectionKey,
                                      style: TextStyle(
                                        color: sectionColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      vocab_data.sectionTitles[sectionKey] ??
                                          '',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$learnedWords/$totalWords ${provider.getString('words').toLowerCase()}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expand icon
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: sectionColor,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Kategoriler ve kelimeler (genişletildiğinde)
                      if (isExpanded)
                        ...categories.map((catEntry) {
                          final category = catEntry.value;

                          // Search query varsa sadece eşleşen kelimeleri göster
                          final filteredTerms = _searchQuery.isEmpty
                              ? category.terms
                              : category.terms
                                  .where((term) =>
                                      term.english.toLowerCase().contains(
                                          _searchQuery.toLowerCase()) ||
                                      term.turkish
                                          .toLowerCase()
                                          .contains(_searchQuery.toLowerCase()))
                                  .toList();

                          if (filteredTerms.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return ExpansionTile(
                            title: Row(
                              children: [
                                Text(category.icon,
                                    style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    category.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${filteredTerms.length}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            children: filteredTerms.map((term) {
                              final isLearned =
                                  provider.learnedWords.contains(term.english);

                              // Get word strength for color coding
                              final strength =
                                  provider.getWordStrength(term.english);
                              final strengthColor =
                                  AppProvider.strengthColors[strength] ??
                                      Colors.grey;
                              final strengthName =
                                  AppProvider.strengthNames[strength] ?? 'Yeni';

                              // Icon based on strength level (4 seviye: 0-3)
                              IconData strengthIcon;
                              if (strength == 0) {
                                strengthIcon = Icons.circle_outlined; // Yeni
                              } else if (strength == 1) {
                                strengthIcon = Icons.warning_amber; // Zayıf
                              } else if (strength == 2) {
                                strengthIcon = Icons.timelapse; // Öğreniliyor
                              } else {
                                strengthIcon = Icons.check_circle; // İyi
                              }

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: strengthColor,
                                  radius: 18,
                                  child: Icon(
                                    strengthIcon,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                title: Text(
                                  term.english,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        term.turkish,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    if (isLearned || strength > 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: strengthColor.withValues(
                                              alpha: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          strengthName,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: strengthColor,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
