import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/vocabulary_models.dart';
import '../data/vocabulary_data_fixed.dart' as vocab_data;
import 'lesson_screen.dart';
import 'league_screen.dart';
import 'friends_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';
import 'words_screen.dart';
import '../screens/mistakes_screen.dart';
import 'subscription_screen.dart';
import 'review_screen.dart';
import 'score_screen.dart';
import 'welcome_screen.dart';
import '../widgets/path_painter.dart';
// import '../widgets/banner_ad_widget.dart';  // Web'de çalışmaz

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  String _currentVisibleSection = '1. KISIM'; // Track visible section
  List<MapEntry<String, CategoryData>> _sortedEntries = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateVisibleSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateVisibleSection);
    _scrollController.dispose();
    super.dispose();
  }

  // Update the visible section based on scroll position
  void _updateVisibleSection() {
    if (_sortedEntries.isEmpty || !_scrollController.hasClients) return;
    
    final scrollOffset = _scrollController.offset;
    
    // Very simple approach: Calculate approximate index from scroll position
    // Average item height including both section headers and lesson nodes
    const avgItemHeight = 200.0;
    
    // Calculate approximate index
    int estimatedIndex = (scrollOffset / avgItemHeight).floor();
    
    // Clamp to valid range
    estimatedIndex = estimatedIndex.clamp(0, _sortedEntries.length - 1);
    
    // Get section from that index
    final newSection = _sortedEntries[estimatedIndex].value.section;
    
    // Update if changed
    if (newSection != null && _currentVisibleSection != newSection) {
      setState(() {
        _currentVisibleSection = newSection;
      });
    }
  }


  String _getBackgroundPath(AppProvider provider) {
    final bgName = provider.themeMode == ThemeMode.dark
        ? provider.selectedDarkBg
        : provider.selectedLightBg;
    
    // palm_beach, sea, and ocean use PNG format for daytime images
    if (bgName == 'palm_beach' || bgName == 'sea' || bgName == 'ocean') {
      return 'assets/images/${bgName}_bg.png';
    }
    // Other images use WebP format for better compression
    return 'assets/images/${bgName}_bg.webp';
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      key: _scaffoldKey,
      // Mobile drawer
      drawer: isMobile ? _buildDrawer(context, provider) : null,
      body: Row(
        children: [
          // SOL MENÜ - Sadece geniş ekranlarda göster
          if (!isMobile)
            Container(
              width: 200,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text('👽 ALIEN',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    const SizedBox(height: 20),
                    // Scrollable menu items
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _menuItem(context, '📚', provider.getString('learn'), true),
                            _menuItem(context, '⭐', provider.getString('points'), false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const ScoreScreen()))),
                            _menuItem(context, '📝', provider.getString('words'), false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const WordsScreen()))),
                            _menuItem(context, '🎯', provider.getString('practice'), false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MistakesScreen()))),
                            // Tekrar butonu - kelime sayısı ile
                            _menuItemWithBadge(
                              context, 
                              '🔄', 
                              provider.getString('review'), 
                              false,
                              badge: provider.wordsNeedingReviewCount > 0 
                                  ? '${provider.wordsNeedingReviewCount}' 
                                  : null,
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ReviewScreen())),
                            ),
                            _menuItem(context, '💎', 'Premium', false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SubscriptionScreen()))),
                            _menuItem(context, '🏆', provider.getString('league'), false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LeagueScreen()))),
                            _menuItem(context, '👥', 'Arkadaşlar', false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const FriendsScreen()))),
                            _menuItem(context, '🎮', provider.getString('game'), false,
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const GameScreen()))),
                            _menuItem(context, '⚙️', provider.getString('settings'), false,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SettingsScreen()))),
                            const SizedBox(height: 16),
                            // BAŞLA - Login/Register link
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF9800), Color(0xFFFB8C00)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                dense: true,
                                leading: const Text('🚀', style: TextStyle(fontSize: 20)),
                                title: const Text(
                                  'BAŞLA',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ORTA - YOL
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // Arka plan
                Positioned.fill(
                  child: Image.asset(
                    _getBackgroundPath(provider),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                // Overlay
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.5)),
                ),
                // İçerik
                SafeArea(
                  child: Column(
                    children: [
                      // KISIM KUTUCUĞU - Kompakt, tek satır
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            // Hamburger menu for mobile
                            if (isMobile)
                              GestureDetector(
                                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.menu, color: Colors.white, size: 24),
                                ),
                              ),
                            // Kısım bilgisi - dinamik renk kutu (Expanded - bayrağa kadar genişler)
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  // Section-based dynamic color
                                  Color getSectionColor(String section) {
                                    final sectionColors = {
                                      '1. KISIM': const Color(0xFF58CC02), // Green
                                      '2. KISIM': Colors.red,
                                      '3. KISIM': Colors.pink,
                                      '4. KISIM': Colors.orange,
                                      '5. KISIM': Colors.purple,
                                      '6. KISIM': Colors.blue,
                                    };
                                    return sectionColors[section] ?? const Color(0xFF58CC02);
                                  }
                                  
                                  final sectionColor = getSectionColor(_currentVisibleSection);
                                  
                                  return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      sectionColor,
                                      sectionColor.withValues(alpha: 0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: sectionColor.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _currentVisibleSection,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            provider.getString('aviation_english'),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.flight, color: Colors.white, size: 24),
                                  ],
                                ),
                              );  // Container close
                            }),  // Builder close
                            ),
                            const SizedBox(width: 8),
                            // Sağ taraf - İkonlar
                            // Bayrak
                            PopupMenuButton<String>(
                              onSelected: (lang) =>
                                  provider.setTargetLanguage(lang),
                              itemBuilder: (context) =>
                                  AppProvider.languageFlags.entries
                                      .map(
                                        (e) => PopupMenuItem(
                                          value: e.key,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                            child: Row(
                                              children: [
                                                Text(e.value,
                                                    style: const TextStyle(
                                                        fontSize: 24)),
                                                const SizedBox(width: 12),
                                                Text(AppProvider
                                                        .languageNames[e.key] ??
                                                    '', style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                                if (e.key == provider.targetLanguage)
                                                  const Padding(
                                                    padding: EdgeInsets.only(left: 8),
                                                    child: Icon(Icons.check, color: Colors.green, size: 20),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              child: Text(provider.currentFlag,
                                  style: const TextStyle(fontSize: 24)),
                            ),
                            const SizedBox(width: 12),
                            // Cycle indicator
                            if (provider.currentCycle > 1)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: _buildStatBadge(context, '🔄', 'Cycle ${provider.currentCycle}'),
                              ),
                            // Review count indicator
                            if (provider.lessonsNeedingReviewCount > 0)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.refresh, size: 14, color: Colors.white),
                                      const SizedBox(width: 4),
                                      Text('${provider.lessonsNeedingReviewCount}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            // Sync Status Indicator
                            _buildSyncStatusBadge(context, provider),
                            const SizedBox(width: 8),
                            // Streak
                            _buildStatBadge(context, '🔥', '${provider.streak}'),
                            const SizedBox(width: 8),
                            // Can
                            _buildStatBadge(context, '❤️', '${provider.lives}'),
                            const SizedBox(width: 8),
                            // Tema
                            GestureDetector(
                              onTap: provider.toggleTheme,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  provider.themeMode == ThemeMode.dark
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Yol
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            _sortedEntries = vocab_data.vocabulary.entries.toList()
                              ..sort((a, b) {
                                // Section numarasını çıkar (örn: "1. KISIM" -> 1)
                                int getSectionNum(String? section) {
                                  if (section == null) return 999;
                                  final match = RegExp(r'^(\d+)\.').firstMatch(section);
                                  return match != null ? int.parse(match.group(1)!) : 999;
                                }
                                final sectionA = getSectionNum(a.value.section);
                                final sectionB = getSectionNum(b.value.section);
                                if (sectionA != sectionB) return sectionA.compareTo(sectionB);
                                // Aynı section içinde unit numarasına göre sırala
                                int getUnitNum(String? unit) {
                                  if (unit == null) return 999;
                                  final match = RegExp(r'^(\d+)\.').firstMatch(unit);
                                  return match != null ? int.parse(match.group(1)!) : 999;
                                }
                                return getUnitNum(a.value.unit).compareTo(getUnitNum(b.value.unit));
                              });
                            
                            return NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification notification) {
                                if (notification is ScrollUpdateNotification) {
                                  _updateVisibleSection();
                                }
                                return false;
                              },
                              child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: _sortedEntries.length,
                          itemBuilder: (context, index) {
                            final categoryKey = _sortedEntries[index].key;
                            final category = _sortedEntries[index].value;
                            final isCompleted =
                                provider.completedLessons.contains(categoryKey);
                            final isLocked = index > 0 &&
                                !provider.completedLessons.contains(
                                    _sortedEntries[index - 1].key);

                            // Her section'ın ilk kategorisinde section header göster
                            final currentSection = category.section;
                            final isFirstInSection = index == 0 ||
                                _sortedEntries[index - 1].value.section != currentSection;

                            return LayoutBuilder(
                                builder: (context, constraints) {
                                final contentWidth = constraints.maxWidth;
                                final nodeRadius = 40.0;
                                const pathSpacing = 60.0; // Daha sıkı aralık - node'lara daha yakın
                                
                                // Calculate node positions using same alignment as _buildLessonNode
                                // Alignment: -0.4 = left, +0.4 = right (daha az salınım)
                                // Convert alignment to X position: x = (alignment + 1) / 2 * width
                                final isLeftAligned = index % 2 == 1;
                                final prevIsLeftAligned = index > 0 ? (index - 1) % 2 == 1 : false;
                                
                                double getNodeCenterX(bool leftAligned) {
                                  // alignment = -0.4 for left, +0.4 for right (daha az salınım)
                                  final alignment = leftAligned ? -0.4 : 0.4;
                                  // Align widget positions the CENTER of the node at:
                                  // x = contentWidth/2 + alignment * (contentWidth/2 - nodeRadius)
                                  // This accounts for the node needing nodeRadius space from edges
                                  final availableWidth = contentWidth - (nodeRadius * 2);
                                  return nodeRadius + (availableWidth / 2) * (1 + alignment);
                                }
                                
                                final currentNodeX = getNodeCenterX(isLeftAligned);
                                final prevNodeX = getNodeCenterX(prevIsLeftAligned);
                                
                                return Column(
                                  children: [
                                    // Section header if needed
                                    if (isFirstInSection && currentSection != null) ...[
                                      if (index > 0) ...[
                                        // Path from previous node to section header
                                        // Use PREVIOUS section's color for this path
                                        SizedBox(
                                          height: pathSpacing,
                                          child: CustomPaint(
                                            size: Size(contentWidth, pathSpacing),
                                            painter: PathPainter(
                                              startPoint: Offset(prevNodeX, nodeRadius * 0.5), // Node'un içinden çık
                                              endPoint: Offset(contentWidth / 2, pathSpacing - 30), // Section header'a yaklaş
                                              color: _getSectionColorForCategory(_sortedEntries[index - 1].value),
                                              isLocked: isLocked,
                                            ),
                                          ),
                                        ),
                                      ],
                                      _buildSectionHeader(context, currentSection, index),
                                      // Path from section header to first lesson
                                      // End the path ABOVE the node (pathSpacing - half stroke width - margin)
                                      SizedBox(
                                        height: pathSpacing,
                                        child: CustomPaint(
                                          size: Size(contentWidth, pathSpacing),
                                          painter: PathPainter(
                                            startPoint: Offset(contentWidth / 2, 30), // Section header'dan çık
                                            endPoint: Offset(currentNodeX, pathSpacing - nodeRadius * 0.5), // Node'un içine gir
                                            color: _getSectionColorForCategory(category),
                                            isLocked: isLocked,
                                          ),
                                        ),
                                      ),
                                    ] else if (index > 0) ...[
                                      // Regular path from previous node to current node
                                      // End the path ABOVE the node (not overlapping)
                                      SizedBox(
                                        height: pathSpacing,
                                        child: CustomPaint(
                                          size: Size(contentWidth, pathSpacing),
                                          painter: PathPainter(
                                            startPoint: Offset(prevNodeX, nodeRadius * 0.5), // Önceki node'dan çık
                                            endPoint: Offset(currentNodeX, pathSpacing - nodeRadius * 0.5), // Sonraki node'a gir
                                            color: _getSectionColorForCategory(category),
                                            isLocked: isLocked,
                                          ),
                                        ),
                                      ),
                                    ],
                                    // Lesson node
                                    _buildLessonNode(context, category,
                                        isCompleted, isLocked, index, contentWidth),
                                  ],
                                );
                              },
                            );
                          },
                        ),  // ListView.builder close
                            );  // NotificationListener close
                      }),  // Builder close
                      ),
                    ],
                  ),
                ),
                // Banner AdMob - bottom center (Web'de çalışmaz, sadece mobil)
                // Positioned(
                //   bottom: isMobile ? 55 : 85,
                //   left: 0,
                //   right: 0,
                //   child: const Center(
                //     child: BannerAdWidget(),
                //   ),
                // ),
                // Background selector carousel at bottom - more compact on mobile
                Positioned(
                  bottom: isMobile ? 10 : 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: isMobile ? 40 : 60,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Show appropriate backgrounds based on theme mode
                        if (provider.themeMode == ThemeMode.dark)
                          ...AppProvider.darkBackgrounds.map((bg) {
                            final isSelected = provider.selectedDarkBg == bg;
                            return _buildBackgroundOption(
                              context,
                              bg,
                              isSelected,
                              isDark: true,
                              onTap: () => provider.setDarkBackground(bg),
                              compact: isMobile,
                            );
                          })
                        else
                          ...AppProvider.lightBackgrounds.map((bg) {
                            final isSelected = provider.selectedLightBg == bg;
                            return _buildBackgroundOption(
                              context,
                              bg,
                              isSelected,
                              isDark: false,
                              onTap: () => provider.setLightBackground(bg),
                              compact: isMobile,
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOption(
    BuildContext context,
    String bgName,
    bool isSelected, {
    required bool isDark,
    required VoidCallback onTap,
    bool compact = false,
  }) {
    final size = compact ? 28.0 : 55.0;  // Mobile: 28px, Desktop: 55px
    final margin = compact ? 3.0 : 8.0;
    final borderWidth = compact ? 1.5 : (isSelected ? 3.0 : 2.0);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF58CC02)
                : Colors.white.withValues(alpha: 0.5),
            width: borderWidth,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF58CC02).withValues(alpha: 0.5),
                    blurRadius: compact ? 4 : 8,
                    spreadRadius: compact ? 0.5 : 1,
                  )
                ]
              : null,
        ),
        child: ClipOval(
          child: Image.asset(
            _getThumbnailPath(bgName),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withValues(alpha: 0.5),
              child: Center(
                child: Icon(Icons.image, size: compact ? 12 : 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getThumbnailPath(String bgName) {
    // palm_beach and ocean use PNG format for daytime images
    if (bgName == 'palm_beach' || bgName == 'ocean') {
      return 'assets/images/${bgName}_bg.png';
    }
    // Other images use WebP format for better compression
    return 'assets/images/${bgName}_bg.webp';
  }

  // Mobile Drawer Menu
  Widget _buildDrawer(BuildContext context, AppProvider provider) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('👽 ALIEN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 30),
              _menuItem(context, '📚', provider.getString('learn'), true),
              _menuItem(context, '⭐', provider.getString('points'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ScoreScreen()));
              }),
              _menuItem(context, '📝', provider.getString('words'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WordsScreen()));
              }),
              _menuItem(context, '🎯', provider.getString('practice'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MistakesScreen()));
              }),
              // Tekrar butonu - mobil menü
              _menuItemWithBadge(
                context, 
                '🔄', 
                provider.getString('review'), 
                false,
                badge: provider.wordsNeedingReviewCount > 0 
                    ? '${provider.wordsNeedingReviewCount}' 
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ReviewScreen()));
                },
              ),
              _menuItem(context, '💎', 'Premium', false, onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SubscriptionScreen()));
              }),
              _menuItem(context, '🏆', provider.getString('league'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LeagueScreen()));
              }),
              _menuItem(context, '👥', 'Arkadaşlar', false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FriendsScreen()));
              }),
              _menuItem(context, '🎮', provider.getString('game'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GameScreen()));
              }),
              _menuItem(context, '⚙️', provider.getString('settings'), false,
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()));
              }),
              const SizedBox(height: 20),
              // BAŞLA - Login/Register link
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFB8C00)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  dense: true,
                  leading: const Text('🚀', style: TextStyle(fontSize: 20)),
                  title: const Text(
                    'BAŞLA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                    );
                  },
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }



  Widget _menuItem(
      BuildContext context, String emoji, String label, bool isActive,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color:
                      isActive ? Theme.of(context).colorScheme.primary : null,
                )),
          ],
        ),
      ),
    );
  }

  Widget _menuItemWithBadge(
      BuildContext context, String emoji, String label, bool isActive,
      {VoidCallback? onTap, String? badge}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color:
                        isActive ? Theme.of(context).colorScheme.primary : null,
                  )),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to get section color for a category
  Color _getSectionColorForCategory(CategoryData category) {
    final sectionColors = {
      '1. KISIM': const Color(0xFF58CC02),
      '2. KISIM': Colors.red,
      '3. KISIM': Colors.pink,
      '4. KISIM': Colors.orange,
      '5. KISIM': Colors.purple,
      '6. KISIM': Colors.blue,
      '7. KISIM': Colors.teal,
      '8. KISIM': Colors.amber,
    };
    return sectionColors[category.section] ?? const Color(0xFF58CC02);
  }

  Widget _buildStatBadge(BuildContext context, String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSyncStatusBadge(BuildContext context, AppProvider provider) {
    IconData icon;
    Color color;
    String tooltip;
    
    if (provider.isSyncing) {
      icon = Icons.sync;
      color = Colors.blue;
      tooltip = 'Senkronize ediliyor...';
    } else if (!provider.isOnline) {
      icon = Icons.cloud_off;
      color = Colors.grey;
      tooltip = 'Çevrimdışı';
    } else if (provider.isSynced) {
      icon = Icons.cloud_done;
      color = const Color(0xFF58CC02);
      tooltip = 'Senkronize';
    } else {
      icon = Icons.cloud_upload;
      color = Colors.orange;
      tooltip = 'Senkronize edilmedi';
    }
    
    return GestureDetector(
      onTap: provider.isOnline && !provider.isSyncing
          ? () => provider.syncNow()
          : null,
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.8)),
          ),
          child: provider.isSyncing
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                )
              : Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }



  Widget _buildSectionHeader(
      BuildContext context, String sectionName, int index) {
    // Section renk paleti
    Color getSectionColor(String section) {
      final sectionColors = {
        '1. KISIM': const Color(0xFF58CC02), // Green
        '2. KISIM': Colors.red, // Red
        '3. KISIM': Colors.pink, // Pink
        '4. KISIM': Colors.orange, // Orange
        '5. KISIM': Colors.purple, // Purple
        '6. KISIM': Colors.blue, // Blue
        '7. KISIM': Colors.teal, // Teal
      };
      return sectionColors[section] ?? Colors.blue;
    }

    final color = getSectionColor(sectionName);
    final title = vocab_data.sectionTitles[sectionName] ?? sectionName;
    final icon = vocab_data.sectionIcons[sectionName] ?? '📚';

    // Calculate progress for this section
    final provider = Provider.of<AppProvider>(context, listen: false);
    final sectionCategories = vocab_data.vocabulary.entries
        .where((entry) => entry.value.section == sectionName)
        .toList();
    final completedInSection = sectionCategories
        .where((entry) => provider.completedLessons.contains(entry.key))
        .length;
    final totalInSection = sectionCategories.length;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Column(
        children: [
          // Section bilgisi - Text box ÜSTTE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,
                        size: 16, color: color.withValues(alpha: 0.5)),
                    const SizedBox(width: 6),
                    Text(
                      '$completedInSection/$totalInSection',
                      style: TextStyle(
                        color: color.withValues(alpha: 0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Büyük section node - Saydam, sadece kenarlık
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 6,
              ),
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonNode(BuildContext context, CategoryData category,
      bool isCompleted, bool isLocked, int index, double contentWidth) {
    const nodeSize = 80.0;
    const iconSize = 32.0;
    
    final provider = Provider.of<AppProvider>(context);
    final categoryKey = vocab_data.vocabulary.keys.elementAt(index);
    final masteryLevel = provider.getMasteryLevel(categoryKey);
    final masteryIcon = provider.getMasteryIcon(categoryKey);
    final needsReview = provider.needsReview(categoryKey);
    final reviewUrgency = provider.getReviewUrgency(categoryKey);
    
    Color getSectionColor(String? section) {
      if (section == null) return Colors.blue;
      final sectionColors = {
        '1. KISIM': const Color(0xFF58CC02),
        '2. KISIM': Colors.red,
        '3. KISIM': Colors.pink,
        '4. KISIM': Colors.orange,
        '5. KISIM': Colors.purple,
        '6. KISIM': Colors.blue,
        '7. KISIM': Colors.teal,
        '8. KISIM': Colors.amber,
      };
      if (sectionColors.containsKey(section)) {
        return sectionColors[section]!;
      }
      final match = RegExp(r'^(\d+)\. KISIM').firstMatch(section);
      if (match != null) {
        final sectionKey = '${match.group(1)}. KISIM';
        return sectionColors[sectionKey] ?? Colors.blue;
      }
      return Colors.blue;
    }
    
    Color getMasteryColor(int level) {
      switch (level) {
        case 1: return const Color(0xFFCD7F32);
        case 2: return const Color(0xFFC0C0C0);
        case 3: return const Color(0xFFFFD700);
        case 4: return const Color(0xFF9C27B0);
        default: return Colors.grey;
      }
    }
    
    final baseColor = getSectionColor(category.section);
    Color nodeColor;
    
    if (isLocked) {
      nodeColor = Colors.grey.withValues(alpha: 0.5);
    } else if (masteryLevel >= 1) {
      final masteryColor = getMasteryColor(masteryLevel);
      nodeColor = Color.lerp(baseColor, masteryColor, 0.3)!;
    } else {
      nodeColor = baseColor;
    }

    
    // Calculate exact X position (same formula as path calculations)
    final bool isLeftAligned = index % 2 == 1;
    // Convert to alignment: -1.0 = left, 0.0 = center, 1.0 = right
    // Left position: 0.3 from left edge (daha az salınım)
    // Right position: 0.3 from right edge (daha az salınım)
    final double alignmentX = isLeftAligned ? -0.4 : 0.4;
    
    String displayIcon;
    if (isLocked) {
      displayIcon = '🔒';
    } else {
      displayIcon = category.icon;
    }
    
    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LessonScreen(category: category)));
            },
      child: Align(
        alignment: Alignment(alignmentX, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
                    children: [
                      if (needsReview)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.orange.withValues(alpha: 0.8),
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      Container(
                        width: nodeSize,
                        height: nodeSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // İçi tamamen saydam - arka plan görünür
                          color: Colors.transparent,
                          border: Border.all(
                            color: isLocked 
                                ? Colors.grey.withValues(alpha: 0.5)
                                : nodeColor,
                            width: 5,
                          ),
                          // boxShadow kaldırıldı - içi saydam kalacak
                        ),
                        child: Center(
                          child: Text(displayIcon, style: TextStyle(fontSize: iconSize)),
                        ),
                      ),
                      if (masteryLevel >= 1 && !isLocked)
                        Positioned(
                          top: -5,
                          right: -5,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: getMasteryColor(masteryLevel),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: getMasteryColor(masteryLevel).withValues(alpha: 0.5),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(masteryIcon, style: const TextStyle(fontSize: 14)),
                          ),
                        ),
                      if (needsReview && !isLocked)
                        Positioned(
                          bottom: -3,
                          left: -3,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.6),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.refresh, size: 12, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Şeffaf kare arka plan ile metin
                  Container(
                    width: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      category.title,
                      style: TextStyle(
                        color: isLocked ? Colors.grey : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  if (masteryLevel >= 1 && !isLocked)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        AppProvider.masteryNames[masteryLevel] ?? '',
                        style: TextStyle(
                          color: getMasteryColor(masteryLevel),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
