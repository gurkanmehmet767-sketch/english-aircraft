// Stub implementation for web - ads are not supported on web
class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  Future<void> initialize() async {}

  void loadBannerAd({
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
  }) {
    // No-op on web
  }

  void loadInterstitialAd({
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
  }) {
    // No-op on web
  }

  void loadRewardedAd({
    required Function onAdLoaded,
    required Function(dynamic) onAdFailedToLoad,
  }) {
    // No-op on web
  }

  void showInterstitialAd({required Function onAdDismissed}) {}

  void showRewardedAd({
    required Function onUserEarnedReward,
    required Function onAdDismissed,
  }) {}

  dynamic get bannerAd => null;
  bool get isBannerAdReady => false;
  bool get isInterstitialAdReady => false;
  bool get isRewardedAdReady => false;

  void dispose() {}
}
