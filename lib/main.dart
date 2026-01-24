import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'services/sync_service.dart';
// import 'services/ad_service.dart'; // Temporarily disabled for web

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start auto-sync service
  SyncService().startAutoSync();

  // Initialize AdMob (skip on web - AdMob doesn't work on web)
  // if (!kIsWeb) {
  //   await AdService().initialize();
  // }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const AlienApp(),
    ),
  );
}

class AlienApp extends StatelessWidget {
  const AlienApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    if (provider.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: provider.themeMode,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Check if user is logged in
    final isLoggedIn = provider.currentUser != null;

    return MaterialApp(
      title: 'Alien English',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.themeMode,
      home: isLoggedIn ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
