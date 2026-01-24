import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_service.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _firestoreService = FirestoreService();
  final _localStorageService = LocalStorageService();
  final _searchController = TextEditingController();

  UserModel? _currentUser;
  List<UserModel> _friends = [];
  List<FriendRequest> _pendingRequests = [];
  List<UserModel> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    _currentUser = await _localStorageService.getUser();
    if (_currentUser != null && _currentUser!.isSynced) {
      _friends = await _firestoreService.getFriends(_currentUser!.uid);
      _pendingRequests =
          await _firestoreService.getFriendRequests(_currentUser!.uid);
    }

    setState(() => _isLoading = false);
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    final results = await _firestoreService.searchUsersByUsername(query);
    // Filter out current user and existing friends
    final filtered = results.where((user) {
      return user.uid != _currentUser?.uid &&
          !_friends.any((friend) => friend.uid == user.uid);
    }).toList();

    setState(() {
      _searchResults = filtered;
      _isSearching = false;
    });
  }

  Future<void> _sendFriendRequest(UserModel targetUser) async {
    if (_currentUser == null) return;

    try {
      await _firestoreService.sendFriendRequest(
        _currentUser!.uid,
        targetUser.uid,
        _currentUser!.username,
        targetUser.username,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${targetUser.username} adlı kullanıcıya istek gönderildi'),
            backgroundColor: const Color(0xFF58CC02),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İstek gönderilemedi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _acceptRequest(FriendRequest request) async {
    try {
      await _firestoreService.acceptFriendRequest(request.id);
      await _loadData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${request.fromUsername} arkadaş olarak eklendi! 🎉'),
            backgroundColor: const Color(0xFF58CC02),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İstek kabul edilemedi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _rejectRequest(FriendRequest request) async {
    try {
      await _firestoreService.rejectFriendRequest(request.id);
      await _loadData();
    } catch (e) {
      // Silent fail
    }
  }

  Future<void> _removeFriend(UserModel friend) async {
    if (_currentUser == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arkadaşı Çıkar'),
        content: Text(
            '${friend.username} adlı kullanıcıyı arkadaş listesinden çıkarmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Çıkar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _firestoreService.removeFriend(_currentUser!.uid, friend.uid);
        await _loadData();
      } catch (e) {
        // Silent fail
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arkadaşlar',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Arkadaşlar'),
            Tab(text: 'İstekler'),
            Tab(text: 'Ara'),
          ],
        ),
      ),
      body: _currentUser == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Giriş yapmanız gerekiyor',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : !_currentUser!.isSynced
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'WiFi bağlantısı bekleniyor',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Arkadaş eklemek için online olmanız gerekiyor',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFriendsTab(),
                    _buildRequestsTab(),
                    _buildSearchTab(),
                  ],
                ),
    );
  }

  Widget _buildFriendsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_friends.isEmpty) {
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
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              '"Ara" sekmesinden arkadaş ekle',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _tabController.animateTo(2),
              icon: const Icon(Icons.person_add),
              label: const Text('Arkadaş Ara'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          final friend = _friends[index];
          return _buildFriendCard(friend);
        },
      ),
    );
  }

  Widget _buildFriendCard(UserModel friend) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF667eea),
          child: Text(
            friend.username[0].toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          friend.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber.shade700),
            const SizedBox(width: 4),
            Text('${friend.xp} XP', style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getLeagueColor(friend.league).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                friend.league,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _getLeagueColor(friend.league),
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showFriendOptions(friend),
        ),
      ),
    );
  }

  Widget _buildRequestsTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_pendingRequests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Arkadaşlık isteği yok',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _pendingRequests.length,
        itemBuilder: (context, index) {
          final request = _pendingRequests[index];
          return _buildRequestCard(request);
        },
      ),
    );
  }

  Widget _buildRequestCard(FriendRequest request) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFF58CC02),
              child: Text(
                request.fromUsername[0].toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.fromUsername,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Arkadaşlık isteği gönderdi',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.check_circle, color: Color(0xFF58CC02)),
                  onPressed: () => _acceptRequest(request),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () => _rejectRequest(request),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => _searchUsers(value),
            decoration: InputDecoration(
              hintText: 'Kullanıcı adı ara...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _searchUsers('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ),
        Expanded(
          child: _isSearching
              ? const Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchController.text.isEmpty
                                ? Icons.search
                                : Icons.person_search,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'Kullanıcı aramaya başla'
                                : 'Kullanıcı bulunamadı',
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
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _searchResults[index];
                        return _buildSearchResultCard(user);
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildSearchResultCard(UserModel user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFFF9800),
          child: Text(
            user.username[0].toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          user.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber.shade700),
            const SizedBox(width: 4),
            Text('${user.xp} XP', style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getLeagueColor(user.league).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user.league,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _getLeagueColor(user.league),
                ),
              ),
            ),
          ],
        ),
        trailing: ElevatedButton.icon(
          onPressed: () => _sendFriendRequest(user),
          icon: const Icon(Icons.person_add, size: 18),
          label: const Text('Ekle'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF58CC02),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ),
    );
  }

  void _showFriendOptions(UserModel friend) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.leaderboard, color: Color(0xFF667eea)),
              title: const Text('Karşılaştır'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to comparison screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.red),
              title: const Text('Arkadaşlıktan Çıkar'),
              onTap: () {
                Navigator.pop(context);
                _removeFriend(friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getLeagueColor(String league) {
    switch (league.toLowerCase()) {
      case 'alpha':
        return const Color(0xFF58CC02);
      case 'beta':
        return const Color(0xFF1CB0F6);
      case 'gamma':
        return const Color(0xFFFF9800);
      default:
        return Colors.grey;
    }
  }
}
