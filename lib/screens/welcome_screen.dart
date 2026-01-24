import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0F8FF), // Light blue
              Color(0xFFE6F3FF), // Lighter blue
              Color(0xFFFFF8E6), // Light yellow
            ],
          ),
        ),
        child: SafeArea(
          child: isMobile
              ? _buildMobileLayout(context, provider)
              : _buildDesktopLayout(context, provider),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppProvider provider) {
    return Column(
      children: [
        // Header with logo and language selector
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/alien_emblem.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'ALIEN',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFF9800),
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF1CB0F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'AVIATION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              _buildLanguageSelector(provider),
            ],
          ),
        ),

        // Main content
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side - Alien mascot illustration
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Decorative circles in background
                          Positioned(
                            top: 50,
                            left: 50,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF9800).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            right: 60,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFF1CB0F6).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          // Main illustration
                          Image.asset(
                            'assets/images/sky_mascot_hero.webp',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Text(
                              '👽✈️\n🌍📚🚀',
                              style: TextStyle(fontSize: 100, height: 1.5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Right side - Text and buttons
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 450),
                    padding: EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Main heading with alien emoji
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF58CC02),
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    Text('👽', style: TextStyle(fontSize: 36)),
                              ),
                              SizedBox(width: 12),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF58CC02),
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    Text('✈️', style: TextStyle(fontSize: 36)),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),

                          Text(
                            'Havacılık İngilizcesi öğrenmenin',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'ücretsiz, eğlenceli ve etkili yolu!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF9800),
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 48),

                          // Start button with gradient
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF9800), Color(0xFFFB8C00)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Color(0xFFFF9800).withValues(alpha: 0.3),
                                  blurRadius: 16,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AuthScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'BAŞLA',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.rocket_launch,
                                      size: 24, color: Colors.black),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 16),

                          // Already have account button
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const AuthScreen(showLogin: true)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF1CB0F6),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              side: BorderSide(
                                  color: Color(0xFFE5E5E5), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'ZATEN HESABIM VAR',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          SizedBox(height: 16),

                          // Guest mode button
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF777777),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_outline, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Ziyaretçi olarak devam et',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32),

                          // Features
                          _buildFeature('✅', 'Ücretsiz ve reklamsız'),
                          SizedBox(height: 12),
                          _buildFeature('🎯', 'Interaktif dersler'),
                          SizedBox(height: 12),
                          _buildFeature('🌍', '5 dilde öğren'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom language carousel
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Text(
                'Öğrenmek istediğin dili seç',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF777777),
                ),
              ),
              SizedBox(height: 16),
              _buildLanguageCarousel(provider),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppProvider provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          'assets/images/alien_emblem.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ALIEN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF9800),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                _buildLanguageSelector(provider),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Alien mascot
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF58CC02),
                  shape: BoxShape.circle,
                ),
                child: Text('👽', style: TextStyle(fontSize: 40)),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF58CC02),
                  shape: BoxShape.circle,
                ),
                child: Text('✈️', style: TextStyle(fontSize: 40)),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Illustration
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Image.asset(
              'assets/images/alien_welcome_hero.webp',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Text(
                '🌍📚🚀\n✈️🛩️🌟',
                style: TextStyle(fontSize: 60, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: 24),

          // Text and buttons
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Havacılık İngilizcesi öğrenmenin',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  'ücretsiz, eğlenceli ve etkili yolu!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF9800),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                // Start button
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFFB8C00)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF9800).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const AuthScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BAŞLA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.rocket_launch,
                            size: 22, color: Colors.black),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Already have account button
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AuthScreen(showLogin: false)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF1CB0F6),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Color(0xFFE5E5E5), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'ZATEN HESABIM VAR',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Guest mode button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF777777),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Ziyaretçi olarak devam et',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Features
                _buildFeature('✅', 'Ücretsiz ve reklamsız'),
                SizedBox(height: 6),
                _buildFeature('🎯', 'Interaktif dersler'),
                SizedBox(height: 6),
                _buildFeature('🌍', '5 dilde öğren'),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Language carousel
          Text(
            'Öğrenmek istediğin dili seç',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF777777),
            ),
          ),
          SizedBox(height: 6),
          _buildLanguageCarousel(provider),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFeature(String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: TextStyle(fontSize: 18)),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B4B4B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(AppProvider provider) {
    return PopupMenuButton<String>(
      onSelected: (lang) => provider.setTargetLanguage(lang),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE5E5E5), width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SİTE DİLİ: ${AppProvider.languageNames[provider.targetLanguage]?.toUpperCase() ?? 'TÜRKÇE'}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF777777),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 18, color: Color(0xFF777777)),
          ],
        ),
      ),
      itemBuilder: (context) => AppProvider.languageFlags.entries.map((e) {
        return PopupMenuItem(
          value: e.key,
          child: Row(
            children: [
              Text(e.value, style: TextStyle(fontSize: 20)),
              SizedBox(width: 12),
              Text(
                AppProvider.languageNames[e.key] ?? '',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              if (e.key == provider.targetLanguage) ...[
                Spacer(),
                Icon(Icons.check, color: Color(0xFFFF9800), size: 18),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLanguageCarousel(AppProvider provider) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 65),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        children: [
          _buildLanguageChip('🇬🇧', 'English', 'İngilizce', provider),
          _buildLanguageChip('🇩🇪', 'Deutsch', 'Almanca', provider),
          _buildLanguageChip('🇷🇺', 'Русский', 'Rusça', provider),
          _buildLanguageChip('🇫🇷', 'Français', 'Fransızca', provider),
          _buildLanguageChip('🇪🇸', 'Español', 'İspanyolca', provider),
          _buildLanguageChip('🇳🇱', 'Nederlands', 'Hollandaca', provider),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(
      String flag, String name, String local, AppProvider provider) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE5E5E5), width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(flag, style: TextStyle(fontSize: 20)),
          SizedBox(height: 2),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4B4B4B),
            ),
          ),
        ],
      ),
    );
  }
}
