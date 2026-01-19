import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../data/vocabulary_data_fixed.dart' as vocab_data;
import 'friends_screen.dart';
import 'settings_screen.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = provider.themeMode == ThemeMode.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFF667eea), const Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : _user == null
                  ? _buildNotLoggedIn()
                  : _buildProfile(provider),
        ),
      ),
    );
  }

  Widget _buildNotLoggedIn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.person_off, size: 64, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            const Text(
              'Henüz giriş yapmadınız',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Profilinizi görüntülemek için giriş yapın veya kayıt olun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AuthScreen(showLogin: true)),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('GİRİŞ YAP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AuthScreen(showLogin: false)),
                );
              },
              child: const Text(
                'Hesap oluştur',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(AppProvider provider) {
    return Column(
      children: [
        // Header with back button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              const Expanded(
                child: Text(
                  'PROFİL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ),

        // Profile Card
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildProfileCard(provider),
        ),

        // Stats Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildStatsRow(provider),
        ),

        const SizedBox(height: 16),

        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: const Color(0xFF58CC02),
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'İSTATİSTİK'),
              Tab(text: 'BAŞARILAR'),
              Tab(text: 'ARKADAŞLAR'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildStatisticsTab(provider),
              _buildAchievementsTab(provider),
              _buildFriendsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(AppProvider provider) {
    final league = provider.currentLeague;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.2),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(int.parse(
                          league.colors[0].replaceFirst('#', '0xFF'))),
                      Color(int.parse(
                          league.colors[1].replaceFirst('#', '0xFF'))),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Text(
                    _user?.username.substring(0, 1).toUpperCase() ?? '?',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Level Badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    '${provider.currentLevel}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.username ?? 'Kullanıcı',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(int.parse(
                                league.colors[0].replaceFirst('#', '0xFF'))),
                            Color(int.parse(
                                league.colors[1].replaceFirst('#', '0xFF'))),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        league.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_user?.isSynced ?? false)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cloud_done,
                                size: 12, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Synced',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _user?.email ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(AppProvider provider) {
    return Row(
      children: [
        _buildStatCard('🔥', '${provider.streak}', 'Gün Seri', Colors.orange),
        const SizedBox(width: 8),
        _buildStatCard('⚡', '${provider.xp}', 'XP', Colors.amber),
        const SizedBox(width: 8),
        _buildStatCard('❤️', '${provider.lives}', 'Can', Colors.red),
        const SizedBox(width: 8),
        _buildStatCard(
            '📚', '${provider.completedLessons.length}', 'Ders', Colors.blue),
      ],
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsTab(AppProvider provider) {
    final totalLessons = vocab_data.vocabulary.length;
    final completedCount = provider.completedLessons.length;
    final progress = totalLessons > 0 ? completedCount / totalLessons : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Genel İlerleme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 10,
                        backgroundColor: Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation(Color(0xFF58CC02)),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '$completedCount / $totalLessons ders tamamlandı',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Detailed Stats
          _buildDetailedStats(provider),
        ],
      ),
    );
  }

  Widget _buildDetailedStats(AppProvider provider) {
    final memberSince = _user?.createdAt ?? DateTime.now();
    final daysSince = DateTime.now().difference(memberSince).inDays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildStatRow('Toplam XP', '${provider.xp}', Icons.bolt),
          _buildStatRow('Güncel Seri', '${provider.streak} gün',
              Icons.local_fire_department),
          _buildStatRow('Tamamlanan Ders',
              '${provider.completedLessons.length}', Icons.check_circle),
          _buildStatRow('Öğrenilen Kelime', '${provider.learnedWords.length}',
              Icons.text_fields),
          _buildStatRow(
              'Mevcut Lig', provider.currentLeague.name, Icons.emoji_events),
          _buildStatRow(
              'Üyelik Süresi', '$daysSince gün', Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(AppProvider provider) {
    final achievements = _getAchievements(provider);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return _buildAchievementCard(
          achievement['emoji'] as String,
          achievement['title'] as String,
          achievement['unlocked'] as bool,
        );
      },
    );
  }

  List<Map<String, dynamic>> _getAchievements(AppProvider provider) {
    return [
      {
        'emoji': '🎯',
        'title': 'İlk Ders',
        'unlocked': provider.completedLessons.isNotEmpty
      },
      {'emoji': '🔥', 'title': '7 Gün Seri', 'unlocked': provider.streak >= 7},
      {'emoji': '⚡', 'title': '100 XP', 'unlocked': provider.xp >= 100},
      {
        'emoji': '📚',
        'title': '10 Ders',
        'unlocked': provider.completedLessons.length >= 10
      },
      {'emoji': '🏆', 'title': 'Bronz Lig', 'unlocked': provider.xp >= 500},
      {'emoji': '💎', 'title': 'Gümüş Lig', 'unlocked': provider.xp >= 2000},
      {'emoji': '👑', 'title': 'Altın Lig', 'unlocked': provider.xp >= 5000},
      {'emoji': '🌟', 'title': 'Master', 'unlocked': provider.xp >= 10000},
      {
        'emoji': '🎓',
        'title': '30 Gün Seri',
        'unlocked': provider.streak >= 30
      },
    ];
  }

  Widget _buildAchievementCard(String emoji, String title, bool unlocked) {
    return Container(
      decoration: BoxDecoration(
        color: unlocked
            ? const Color(0xFF58CC02).withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? const Color(0xFF58CC02) : Colors.white24,
          width: unlocked ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 28,
              color: unlocked ? null : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: unlocked ? Colors.white : Colors.white38,
            ),
          ),
          if (unlocked) ...[
            const SizedBox(height: 2),
            const Icon(Icons.check_circle, color: Color(0xFF58CC02), size: 14),
          ],
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    final friendCount = _user?.friendIds.length ?? 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.group, size: 48, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Text(
              friendCount > 0 ? '$friendCount Arkadaş' : 'Henüz arkadaş yok',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Arkadaşlarınla yarışarak daha hızlı öğren!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FriendsScreen()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('ARKADAŞ EKLE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
