import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_service.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _firestoreService = FirestoreService();
  final _localStorageService = LocalStorageService();

  UserModel? _currentUser;
  List<LeaderboardEntry> _globalLeaderboard = [];
  List<LeaderboardEntry> _friendsLeaderboard = [];
  bool _isLoading = false;
  int? _userGlobalRank;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      _currentUser = await _localStorageService.getUser();

      if (_currentUser != null) {
        try {
          // Try to load global leaderboard
          _globalLeaderboard = await _firestoreService.getGlobalLeaderboard(
            _currentUser!.league,
            limit: 50,
          );

          // Load friends leaderboard
          _friendsLeaderboard = await _firestoreService.getFriendsLeaderboard(
            _currentUser!.uid,
            limit: 50,
          );

          // Get user's global rank
          _userGlobalRank = await _firestoreService.getUserGlobalRank(
            _currentUser!.uid,
            _currentUser!.league,
          );
        } catch (e) {
          // If Firestore fails, just show empty leaderboards
          debugPrint('Error loading leaderboard: $e');
        }
      }
    } catch (e) {
      debugPrint('Error in _loadData: $e');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Alpha League',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF58CC02), Color(0xFF46A302)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '🏆',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.public), text: 'Global'),
            Tab(icon: Icon(Icons.people), text: 'Arkadaşlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGlobalTab(),
          _buildFriendsTab(),
        ],
      ),
    );
  }

  Widget _buildNotLoggedIn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Giriş yapmanız gerekiyor',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Leaderboard\'u görmek için giriş yapın',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildNotSynced() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Hesabınız henüz senkronize edilmedi',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Leaderboard\'u görmek için hesabınızı oluşturup internet bağlantısıyla senkronize etmeniz gerekiyor.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Geri Dön'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check if user is logged in
    if (_currentUser == null) {
      return _buildNotLoggedIn();
    }

    // Check if user is synced
    if (!_currentUser!.isSynced) {
      return _buildNotSynced();
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: Column(
        children: [
          // User rank card
          if (_currentUser != null && _userGlobalRank != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '#$_userGlobalRank',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF667eea),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser!.username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${_currentUser!.xp} XP',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text('🏆', style: TextStyle(fontSize: 32)),
                ],
              ),
            ),

          // Leaderboard list
          Expanded(
            child: _globalLeaderboard.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.leaderboard,
                            size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz sıralama yok',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _globalLeaderboard.length,
                    itemBuilder: (context, index) {
                      final entry = _globalLeaderboard[index];
                      final isCurrentUser = entry.uid == _currentUser?.uid;
                      return _buildLeaderboardCard(entry, isCurrentUser);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check if user is logged in
    if (_currentUser == null) {
      return _buildNotLoggedIn();
    }

    // Check if user is synced
    if (!_currentUser!.isSynced) {
      return _buildNotSynced();
    }

    if (_friendsLeaderboard.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Henüz arkadaşın yok',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Arkadaş ekleyerek onlarla yarış!',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friendsLeaderboard.length,
        itemBuilder: (context, index) {
          final entry = _friendsLeaderboard[index];
          final isCurrentUser = entry.uid == _currentUser?.uid;
          return _buildLeaderboardCard(entry, isCurrentUser);
        },
      ),
    );
  }

  Widget _buildLeaderboardCard(LeaderboardEntry entry, bool isCurrentUser) {
    Color rankColor;
    String rankEmoji;

    if (entry.rank == 1) {
      rankColor = const Color(0xFFFFD700); // Gold
      rankEmoji = '🥇';
    } else if (entry.rank == 2) {
      rankColor = const Color(0xFFC0C0C0); // Silver
      rankEmoji = '🥈';
    } else if (entry.rank == 3) {
      rankColor = const Color(0xFFCD7F32); // Bronze
      rankEmoji = '🥉';
    } else {
      rankColor = Colors.grey;
      rankEmoji = '';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? const Color(0xFF667eea).withValues(alpha: 0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser ? const Color(0xFF667eea) : Colors.grey.shade200,
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: entry.rank <= 3 ? rankColor : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  entry.rank <= 3 ? rankEmoji : '#${entry.rank}',
                  style: TextStyle(
                    fontSize: entry.rank <= 3 ? 20 : 14,
                    fontWeight: FontWeight.w900,
                    color: entry.rank <= 3 ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 24,
              backgroundColor: _getUserColor(entry.username),
              child: Text(
                entry.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      isCurrentUser ? const Color(0xFF667eea) : Colors.black87,
                ),
              ),
            ),
            if (isCurrentUser)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF667eea),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'SEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              '${entry.xp} XP',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        trailing: entry.rank <= 3
            ? null
            : Icon(
                Icons.trending_up,
                color: Colors.grey.shade400,
                size: 20,
              ),
      ),
    );
  }

  Color _getUserColor(String username) {
    final colors = [
      const Color(0xFF667eea),
      const Color(0xFF58CC02),
      const Color(0xFFFF9800),
      const Color(0xFF1CB0F6),
      const Color(0xFFFF6B6B),
      const Color(0xFF9B59B6),
    ];

    final index = username.codeUnitAt(0) % colors.length;
    return colors[index];
  }
}
