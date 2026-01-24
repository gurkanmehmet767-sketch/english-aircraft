/// Ad Service - Web-safe implementation
/// 
/// Provides a no-op implementation of ad services for web platform.
/// Ads only work on mobile platforms (Android/iOS).
/// 
/// This service follows the singleton pattern to ensure only one instance exists.
/// All methods are safe to call on any platform, but will no-op on web.
library;

import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;

/// AdService singleton for managing advertisements across the app.
/// 
/// Provides methods for loading and showing different types of ads:
/// - Banner ads (persistent bottom ads)
/// - Interstitial ads (full-screen between content)
/// - Rewarded ads (watch video for rewards)
/// 
/// On web platform, all methods are no-op and callbacks are triggered immediately.
class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  final bool _isBannerAdReady = false;
  final bool _isInterstitialAdReady = false;
  final bool _isRewardedAdReady = false;

  // Initialize AdMob - no-op on web
  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('AdService: Ads not supported on web platform');
      return;
    }
    // TODO: Initialize mobile ads when google_mobile_ads is added to pubspec
  }

  // Load Banner Ad
  void loadBannerAd({
    Function? onAdLoaded,
    Function(dynamic)? onAdFailedToLoad,
  }) {
    if (kIsWeb) return;
    // TODO: Implement for mobile
  }

  // Load Interstitial Ad
  void loadInterstitialAd({
    Function? onAdLoaded,
    Function(dynamic)? onAdFailedToLoad,
  }) {
    if (kIsWeb) return;
    // TODO: Implement for mobile
  }

  // Load Rewarded Ad
  void loadRewardedAd({
    Function? onAdLoaded,
    Function(dynamic)? onAdFailedToLoad,
  }) {
    if (kIsWeb) return;
    // TODO: Implement for mobile
  }

  // Show Interstitial Ad
  void showInterstitialAd({required Function onAdDismissed}) {
    if (kIsWeb) {
      onAdDismissed();
      return;
    }
    // TODO: Implement for mobile
  }

  // Show Rewarded Ad
  void showRewardedAd({
    required Function onUserEarnedReward,
    required Function onAdDismissed,
  }) {
    if (kIsWeb) {
      onAdDismissed();
      return;
    }
    // TODO: Implement for mobile
  }

  // Getters
  dynamic get bannerAd => null;
  bool get isBannerAdReady => _isBannerAdReady;
  bool get isInterstitialAdReady => _isInterstitialAdReady;
  bool get isRewardedAdReady => _isRewardedAdReady;

  // Dispose
  void dispose() {}
}

