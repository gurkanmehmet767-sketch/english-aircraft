import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/sync_service.dart';
import '../models/user_model.dart';
import 'home_screen.dart';
import 'legal_screen.dart';

class AuthScreen extends StatefulWidget {
  final bool showLogin;
  
  const AuthScreen({super.key, this.showLogin = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _authService = AuthService();
  
  // Controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  final _registerEmailController = TextEditingController();
  final _registerUsernameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  
  // Focus nodes
  final _loginEmailFocus = FocusNode();
  final _loginPasswordFocus = FocusNode();
  final _registerEmailFocus = FocusNode();
  final _registerUsernameFocus = FocusNode();
  final _registerPasswordFocus = FocusNode();
  
  // State
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _kvkkAccepted = false; // KVKK onayı
  
  // Validation
  bool _emailValid = false;
  bool _usernameValid = false;
  int _passwordStrength = 0; // 0-3

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.showLogin ? 0 : 1,
    );
    
    // Add listeners for real-time validation
    _registerEmailController.addListener(_validateEmail);
    _registerUsernameController.addListener(_validateUsername);
    _registerPasswordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerUsernameController.dispose();
    _registerPasswordController.dispose();
    _loginEmailFocus.dispose();
    _loginPasswordFocus.dispose();
    _registerEmailFocus.dispose();
    _registerUsernameFocus.dispose();
    _registerPasswordFocus.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _registerEmailController.text;
    setState(() {
      _emailValid = email.contains('@') && email.contains('.') && email.length > 5;
    });
  }

  void _validateUsername() {
    final username = _registerUsernameController.text;
    setState(() {
      _usernameValid = username.length >= 3 && username.length <= 20 && 
                       RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
    });
  }

  void _validatePassword() {
    final password = _registerPasswordController.text;
    int strength = 0;
    if (password.length >= 6) strength++;
    if (password.length >= 10) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[0-9]').hasMatch(password)) strength++;
    setState(() => _passwordStrength = strength);
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.login(
      email: _loginEmailController.text,
      password: _loginPasswordController.text,
    );

    setState(() => _isLoading = false);

    if (result.success && mounted) {
      _showSuccessAnimation(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  Future<void> _handleRegister() async {
    // KVKK kontrolü
    if (!_kvkkAccepted) {
      setState(() => _errorMessage = 'Lütfen KVKK Aydınlatma Metnini onaylayın.');
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.registerOffline(
      email: _registerEmailController.text,
      username: _registerUsernameController.text,
      password: _registerPasswordController.text,
    );

    setState(() => _isLoading = false);

    if (result.success && mounted) {
      _showWelcomeDialog(result.user!);
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  void _showSuccessAnimation(VoidCallback onComplete) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF58CC02), size: 64),
              const SizedBox(height: 16),
              const Text(
                'Giriş Başarılı!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.pop(context);
      onComplete();
    });
  }

  void _showWelcomeDialog(UserModel user) async {
    final syncService = SyncService();
    final isOnline = await syncService.isOnline();
    
    // If online, trigger sync immediately
    if (isOnline) {
      syncService.processSyncQueue();
    }
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF0F8FF), Color(0xFFFFF8E6)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF58CC02),
                  shape: BoxShape.circle,
                ),
                child: const Text('🎉', style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hoş Geldin!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF9800),
                ),
              ),
              const SizedBox(height: 16),
              // Show different message based on online status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isOnline ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isOnline ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOnline ? Icons.cloud_done : Icons.wifi_off,
                      color: isOnline ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        isOnline 
                          ? 'Hesabın oluşturuldu ve senkronize edildi! ✓'
                          : 'Offline kaydedildi • WiFi bağlandığında sync olacak',
                        style: TextStyle(
                          fontSize: 11, 
                          color: isOnline ? const Color(0xFF2E7D32) : const Color(0xFF795548),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'BAŞLA 🚀',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFF093FB),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 420),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildLogoCircle('👽'),
                              const SizedBox(width: 12),
                              _buildLogoCircle('✈️'),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                            ).createShader(bounds),
                            child: const Text(
                              'ALIEN AVIATION',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),

                          // Modern Tabs
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: TabBar(
                              controller: _tabController,
                              indicator: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF667eea).withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.white,
                              unselectedLabelColor: const Color(0xFF777777),
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              dividerColor: Colors.transparent,
                              tabs: const [
                                Tab(text: 'GİRİŞ YAP'),
                                Tab(text: 'KAYIT OL'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Error message  
                          if (_errorMessage != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Tab Content - Flexible height based on screen
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.4,
                              minHeight: 260,
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildLoginTab(),
                                _buildRegisterTab(),
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
          ),
        ),
      ),
    );
  }

  Widget _buildLogoCircle(String emoji) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58CC02), Color(0xFF46A302)],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF58CC02).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 26)),
    );
  }

  Widget _buildLoginTab() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildModernTextField(
              controller: _loginEmailController,
              focusNode: _loginEmailFocus,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) => _loginPasswordFocus.requestFocus(),
            ),
            const SizedBox(height: 14),
            _buildModernTextField(
              controller: _loginPasswordController,
              focusNode: _loginPasswordFocus,
              label: 'Şifre',
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              onSubmitted: (_) => _handleLogin(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF999999),
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            const SizedBox(height: 20),
            _buildModernButton(
              label: 'GİRİŞ YAP',
              onPressed: _isLoading ? null : _handleLogin,
              icon: Icons.login_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterTab() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildModernTextField(
              controller: _registerEmailController,
              focusNode: _registerEmailFocus,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) => _registerUsernameFocus.requestFocus(),
              validationIcon: _registerEmailController.text.isNotEmpty
                  ? (_emailValid ? Icons.check_circle : Icons.cancel)
                  : null,
              validationColor: _emailValid ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 14),
            _buildModernTextField(
              controller: _registerUsernameController,
              focusNode: _registerUsernameFocus,
              label: 'Kullanıcı Adı',
              icon: Icons.person_outline,
              hint: '3-20 karakter',
              onSubmitted: (_) => _registerPasswordFocus.requestFocus(),
              validationIcon: _registerUsernameController.text.isNotEmpty
                  ? (_usernameValid ? Icons.check_circle : Icons.cancel)
                  : null,
              validationColor: _usernameValid ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 14),
            _buildModernTextField(
              controller: _registerPasswordController,
              focusNode: _registerPasswordFocus,
              label: 'Şifre',
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              hint: 'En az 6 karakter',
              onSubmitted: (_) => _handleRegister(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF999999),
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            if (_registerPasswordController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildPasswordStrengthIndicator(),
            ],
            const SizedBox(height: 16),
            
            // KVKK Onay Checkbox
            InkWell(
              onTap: () => setState(() => _kvkkAccepted = !_kvkkAccepted),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kvkkAccepted 
                      ? const Color(0xFFE8F5E9) 
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _kvkkAccepted 
                        ? const Color(0xFF4CAF50) 
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _kvkkAccepted ? Icons.check_box : Icons.check_box_outline_blank,
                      color: _kvkkAccepted ? const Color(0xFF4CAF50) : Colors.grey,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(text: 'KVKK '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => _showKVKKDialog(),
                                child: const Text(
                                  'Aydınlatma Metni',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2196F3),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: 'ni okudum, '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => _showPrivacyPolicyDialog(),
                                child: const Text(
                                  'Gizlilik Politikası',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2196F3),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' ve '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => _showTermsDialog(),
                                child: const Text(
                                  'Kullanım Koşulları',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF2196F3),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: 'nı kabul ediyorum.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            _buildModernButton(
              label: 'KAYIT OL',
              onPressed: _isLoading ? null : _handleRegister,
              icon: Icons.rocket_launch_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final strengthLabels = ['Zayıf', 'Orta', 'İyi', 'Güçlü'];
    final strengthColors = [Colors.red, Colors.orange, Colors.blue, Colors.green];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(3, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
                decoration: BoxDecoration(
                  color: index < _passwordStrength 
                      ? strengthColors[_passwordStrength]
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          _passwordStrength > 0 ? strengthLabels[_passwordStrength - 1] : '',
          style: TextStyle(
            fontSize: 11,
            color: _passwordStrength > 0 ? strengthColors[_passwordStrength] : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? hint,
    Function(String)? onSubmitted,
    IconData? validationIcon,
    Color? validationColor,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        prefixIcon: Icon(icon, color: const Color(0xFF999999), size: 22),
        suffixIcon: validationIcon != null
            ? Icon(validationIcon, color: validationColor, size: 20)
            : suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildModernButton({
    required String label,
    required VoidCallback? onPressed,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF58CC02), Color(0xFF46A302)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF58CC02).withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(icon, size: 22),
                ],
              ),
      ),
    );
  }

  // KVKK Dialog Functions
  void _showKVKKDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LegalScreen(documentType: 'kvkk'),
      ),
    );
  }

  void _showPrivacyPolicyDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LegalScreen(documentType: 'privacy'),
      ),
    );
  }

  void _showTermsDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LegalScreen(documentType: 'terms'),
      ),
    );
  }
}
