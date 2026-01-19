// Ad Service - Web-safe implementation
// Ads only work on mobile platforms (Android/iOS)
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;

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
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
  }) {
    if (kIsWeb) return;
    // TODO: Implement for mobile
  }

  // Load Interstitial Ad
  void loadInterstitialAd({
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
  }) {
    if (kIsWeb) return;
    // TODO: Implement for mobile
  }

  // Load Rewarded Ad
  void loadRewardedAd({
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
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

