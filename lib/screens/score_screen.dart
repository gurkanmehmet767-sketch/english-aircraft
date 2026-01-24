import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 PUAN & İSTATİSTİKLER'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Ana XP Kartı
              _buildMainXPCard(context, provider, isDark),
              const SizedBox(height: 16),

              // İstatistikler Grid
              _buildStatsGrid(context, provider, isDark),
              const SizedBox(height: 16),

              // Seviye İlerleme
              _buildLevelProgress(context, provider, isDark),
              const SizedBox(height: 16),

              // Başarılar
              _buildAchievements(context, provider, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainXPCard(
      BuildContext context, AppProvider provider, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.bolt, color: Colors.amber, size: 48),
          const SizedBox(height: 8),
          Text(
            '${provider.totalXP}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'TOPLAM XP',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'SEVİYE ${provider.currentLevel}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(
      BuildContext context, AppProvider provider, bool isDark) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          context,
          icon: Icons.local_fire_department,
          iconColor: Colors.orange,
          value: '${provider.streak}',
          label: 'Günlük Seri',
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          icon: Icons.check_circle,
          iconColor: Colors.green,
          value: '${provider.completedLessons.length}',
          label: 'Tamamlanan Ders',
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          icon: Icons.favorite,
          iconColor: Colors.red,
          value: '${provider.lives}',
          label: 'Kalan Can',
          isDark: isDark,
        ),
        _buildStatCard(
          context,
          icon: Icons.refresh,
          iconColor: Colors.blue,
          value: '${provider.currentCycle}',
          label: 'Tekrar Döngüsü',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgress(
      BuildContext context, AppProvider provider, bool isDark) {
    final currentLevel = provider.currentLevel;
    final xpForCurrentLevel = (currentLevel - 1) * 100;
    final xpForNextLevel = currentLevel * 100;
    final progressXP = provider.totalXP - xpForCurrentLevel;
    final neededXP = xpForNextLevel - xpForCurrentLevel;
    final progress = (progressXP / neededXP).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seviye İlerlemesi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                'Seviye ${currentLevel + 1}\'e $progressXP/$neededXP XP',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.grey.shade200,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(
      BuildContext context, AppProvider provider, bool isDark) {
    final achievements = [
      {
        'icon': '🔥',
        'title': 'Ateş Başlangıcı',
        'desc': '3 günlük seri',
        'done': provider.streak >= 3
      },
      {
        'icon': '⭐',
        'title': 'Yıldız Öğrenci',
        'desc': '100 XP kazan',
        'done': provider.totalXP >= 100
      },
      {
        'icon': '📚',
        'title': 'Kitap Kurdu',
        'desc': '5 ders tamamla',
        'done': provider.completedLessons.length >= 5
      },
      {
        'icon': '🏆',
        'title': 'Şampiyon',
        'desc': '500 XP kazan',
        'done': provider.totalXP >= 500
      },
      {
        'icon': '🚀',
        'title': 'Roket Öğrenci',
        'desc': '10 ders tamamla',
        'done': provider.completedLessons.length >= 10
      },
      {
        'icon': '💎',
        'title': 'Elmas Seviye',
        'desc': '1000 XP kazan',
        'done': provider.totalXP >= 1000
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🏅 Başarılar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...achievements.map((a) => _buildAchievementItem(
                context,
                icon: a['icon'] as String,
                title: a['title'] as String,
                description: a['desc'] as String,
                isCompleted: a['done'] as bool,
                isDark: isDark,
              )),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    required bool isCompleted,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? const Color(0xFF58CC02).withValues(alpha: 0.2)
            : (isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.grey.shade100),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? const Color(0xFF58CC02) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Text(icon,
              style: TextStyle(
                  fontSize: 28, color: isCompleted ? null : Colors.grey)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted
                        ? (isDark ? Colors.white : Colors.black87)
                        : Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isCompleted
                        ? (isDark ? Colors.white60 : Colors.black54)
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check_circle, color: Color(0xFF58CC02), size: 24)
          else
            Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 24),
        ],
      ),
    );
  }
}
