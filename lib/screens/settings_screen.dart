import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../services/auth_service.dart';
import 'auth_screen.dart';
import 'welcome_screen.dart';
import 'legal_screen.dart';
import 'legal_menu_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.getString('settings')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with user info
            _buildHeader(context, provider),
            SizedBox(height: 24),

            // Settings categories
            _buildNotificationsSection(context, provider),
            SizedBox(height: 12),
            _buildThemeSection(context, provider),
            SizedBox(height: 12),
            _buildSoundSection(context, provider),
            SizedBox(height: 12),
            _buildLanguageSection(context, provider),
            SizedBox(height: 12),
            _buildStatisticsSection(context, provider),
            SizedBox(height: 12),
            _buildBackgroundsSection(context, provider),
            SizedBox(height: 12),
            _buildDataSection(context, provider),
            SizedBox(height: 12),
            _buildAboutSection(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppProvider provider) {
    final user = provider.currentUser;
    final username = user?.username ?? 'Alien Learner';
    
    // Sync status icon and color
    IconData syncIcon;
    Color syncColor;
    String syncText;
    
    if (provider.isSyncing) {
      syncIcon = Icons.sync;
      syncColor = Colors.blue;
      syncText = 'Senkronize ediliyor...';
    } else if (!provider.isOnline) {
      syncIcon = Icons.cloud_off;
      syncColor = Colors.grey;
      syncText = 'Çevrimdışı';
    } else if (provider.isSynced) {
      syncIcon = Icons.cloud_done;
      syncColor = const Color(0xFF58CC02);
      syncText = 'Senkronize';
    } else {
      syncIcon = Icons.cloud_upload;
      syncColor = Colors.orange;
      syncText = 'Senkronize edilmedi';
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF58CC02),
                shape: BoxShape.circle,
              ),
              child: const Text('👽', style: TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 12),
            Text(
              username,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (user?.email != null)
              Text(
                user!.email,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            Text(
              '${provider.currentLeague.name} League',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            // Sync status row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(syncIcon, size: 18, color: syncColor),
                const SizedBox(width: 6),
                Text(
                  syncText,
                  style: TextStyle(
                    color: syncColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (provider.isOnline && !provider.isSyncing && !provider.isSynced)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextButton.icon(
                      onPressed: () => provider.syncNow(),
                      icon: const Icon(Icons.sync, size: 16),
                      label: const Text('Senkronize Et'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        foregroundColor: syncColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickStat('⚡', '${provider.xp}', 'XP'),
                _buildQuickStat('📚', '${provider.completedLessons.length}', 'Lessons'),
                _buildQuickStat('🔥', '${provider.streak}', 'Streak'),
              ],
            ),
            // Login/Register button if user is not logged in
            if (user == null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                ),
                icon: const Icon(Icons.login),
                label: const Text('Giriş Yap / Kayıt Ol'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
            // Logout button if user is logged in
            if (user != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Çıkış Yap'),
                      content: const Text('Hesabınızdan çıkmak istediğinizden emin misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('İptal'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Çıkış Yap'),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirm == true && context.mounted) {
                    await AuthService().logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                        (route) => false,
                      );
                    }
                  }
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String icon, String value, String label) {
    return Column(
      children: [
        Text(icon, style: TextStyle(fontSize: 24)),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildNotificationsSection(BuildContext context, AppProvider provider) {
    return ExpansionTile(
      leading: Icon(Icons.notifications, color: Color(0xFFFF9800)),
      title: Text(provider.getString('notifications')),
      children: [
        SwitchListTile(
          title: Text(provider.getString('daily_reminder')),
          value: provider.notificationsEnabled,
          onChanged: (_) => provider.toggleNotifications(),
        ),
        if (provider.notificationsEnabled)
          ListTile(
            title: Text(provider.getString('reminder_time')),
            subtitle: Text('${provider.reminderHour.toString().padLeft(2, '0')}:${provider.reminderMinute.toString().padLeft(2, '0')}'),
            trailing: Icon(Icons.access_time),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: provider.reminderHour,
                  minute: provider.reminderMinute,
                ),
              );
              if (time != null) {
                provider.setReminderTime(time.hour, time.minute);
              }
            },
          ),
      ],
    );
  }

  Widget _buildThemeSection(BuildContext context, AppProvider provider) {
    final isDark = provider.themeMode == ThemeMode.dark;
    return Card(
      child: ListTile(
        leading: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: Color(0xFF1CB0F6),
        ),
        title: Text(provider.getString('theme')),
        subtitle: Text(isDark ? provider.getString('dark_mode') : provider.getString('light_mode')),
        trailing: Switch(
          value: isDark,
          onChanged: (_) => provider.toggleTheme(),
        ),
      ),
    );
  }

  Widget _buildSoundSection(BuildContext context, AppProvider provider) {
    return ExpansionTile(
      leading: Icon(Icons.volume_up, color: Color(0xFF58CC02)),
      title: Text(provider.getString('sound')),
      children: [
        SwitchListTile(
          title: Text(provider.getString('sound_effects')),
          value: provider.soundEffectsEnabled,
          onChanged: (_) => provider.toggleSoundEffects(),
        ),
        SwitchListTile(
          title: Text(provider.getString('speech')),
          value: provider.speechEnabled,
          onChanged: (_) => provider.toggleSpeech(),
        ),
        ListTile(
          title: Text(provider.getString('volume')),
          subtitle: Slider(
            value: provider.volume,
            onChanged: (val) => provider.setVolume(val),
            min: 0.0,
            max: 1.0,
          ),
          trailing: Text('${(provider.volume * 100).round()}%'),
        ),
      ],
    );
  }

  Widget _buildLanguageSection(BuildContext context, AppProvider provider) {
    return ExpansionTile(
      leading: Text(provider.currentFlag, style: TextStyle(fontSize: 24)),
      title: Text(provider.getString('language')),
      subtitle: Text(provider.currentLanguageName),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppProvider.languageFlags.entries.map((entry) {
            final isSelected = entry.key == provider.targetLanguage;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(entry.value, style: TextStyle(fontSize: 20)),
                  SizedBox(width: 4),
                  Text(AppProvider.languageNames[entry.key]!),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => provider.setTargetLanguage(entry.key),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildStatisticsSection(BuildContext context, AppProvider provider) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.bar_chart, color: Color(0xFFFF9800)),
        title: Text(provider.getString('statistics')),
        subtitle: Text(
          provider.detailedStats 
            ? provider.getString('detailed_stats') 
            : provider.getString('simple_stats')
        ),
        trailing: Switch(
          value: provider.detailedStats,
          onChanged: (_) => provider.toggleStatsMode(),
        ),
      ),
    );
  }

  Widget _buildBackgroundsSection(BuildContext context, AppProvider provider) {
    final isDark = provider.themeMode == ThemeMode.dark;
    final backgrounds = isDark 
      ? AppProvider.darkBackgrounds 
      : AppProvider.lightBackgrounds;
    
    return ExpansionTile(
      leading: Icon(Icons.wallpaper, color: Color(0xFF1CB0F6)),
      title: Text(provider.getString('backgrounds')),
      subtitle: Text(isDark ? 'Dark Mode' : 'Light Mode'),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: backgrounds.map((bg) {
              final isSelected = isDark 
                ? bg == provider.selectedDarkBg 
                : bg == provider.selectedLightBg;
              return GestureDetector(
                onTap: () {
                  if (isDark) {
                    provider.setDarkBackground(bg);
                  } else {
                    provider.setLightBackground(bg);
                  }
                },
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Color(0xFF58CC02) : Colors.grey,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      // palm_beach and ocean use PNG, dark backgrounds use WEBP
                      'assets/images/${bg}_bg.${(bg == 'palm_beach' || bg == 'ocean') ? 'png' : 'webp'}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.image, size: 30),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context, AppProvider provider) {
    return ExpansionTile(
      leading: Icon(Icons.storage, color: Colors.red),
      title: Text(provider.getString('data_management')),
      children: [
        ListTile(
          leading: Icon(Icons.download, color: Color(0xFF58CC02)),
          title: Text(provider.getString('export_data')),
          onTap: () {
            if (kIsWeb) {
              // Web-only export functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Export feature only available on web version')),
              );
            } else {
              // Mobile platforms - data is already saved locally
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Your data is safely stored on this device')),
              );
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Colors.red),
          title: Text(provider.getString('reset_progress')),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(provider.getString('reset_confirm_title')),
                content: Text(provider.getString('reset_confirm_message')),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(provider.getString('cancel')),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await provider.resetProgress();
                      if (!ctx.mounted) return;
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(content: Text(provider.getString('progress_reset'))),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(provider.getString('reset_confirm_button')),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context, AppProvider provider) {
    return ExpansionTile(
      leading: Icon(Icons.info_outline, color: Color(0xFF1CB0F6)),
      title: Text(provider.getString('about')),
      children: [
        ListTile(
          title: Text(provider.getString('app_version')),
          trailing: Text(AppProvider.appVersion),
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip_outlined, color: Color(0xFF00D9FF)),
          title: Text('Yasal Bilgiler'),
          subtitle: Text('KVKK, Gizlilik ve Kullanım Koşulları'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LegalMenuScreen(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(provider.getString('privacy_policy')),
          trailing: Icon(Icons.open_in_new),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LegalScreen(documentType: 'privacy'),
              ),
            );
          },
        ),
        ListTile(
          title: Text(provider.getString('terms_of_service')),
          trailing: Icon(Icons.open_in_new),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LegalScreen(documentType: 'terms'),
              ),
            );
          },
        ),
      ],
    );
  }
}
