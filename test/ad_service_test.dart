// Ad Service Tests - Web-safe implementation
import 'package:flutter_test/flutter_test.dart';
import 'package:english_aircraft/services/ad_service.dart';

void main() {
  group('AdService Tests', () {
    late AdService adService;

    setUp(() {
      adService = AdService();
    });

    test('AdService should be singleton', () {
      final instance1 = AdService();
      final instance2 = AdService();
      expect(instance1, same(instance2));
    });

    test('initialize should complete without errors', () async {
      await expectLater(adService.initialize(), completes);
    });

    test('loadBannerAd should not throw', () {
      expect(() {
        adService.loadBannerAd(
          onAdLoaded: () {},
          onAdFailedToLoad: (_) {},
        );
      }, returnsNormally);
    });

    test('loadInterstitialAd should not throw', () {
      expect(() {
        adService.loadInterstitialAd(
          onAdLoaded: () {},
          onAdFailedToLoad: (_) {},
        );
      }, returnsNormally);
    });

    test('loadRewardedAd should not throw', () {
      expect(() {
        adService.loadRewardedAd(
          onAdLoaded: () {},
          onAdFailedToLoad: (_) {},
        );
      }, returnsNormally);
    });

    test('showInterstitialAd should call onAdDismissed', () {
      bool dismissed = false;
      adService.showInterstitialAd(
        onAdDismissed: () => dismissed = true,
      );
      expect(dismissed, true);
    });

    test('showRewardedAd should call onAdDismissed', () {
      bool dismissed = false;
      adService.showRewardedAd(
        onUserEarnedReward: () {},
        onAdDismissed: () => dismissed = true,
      );
      expect(dismissed, true);
    });

    test('bannerAd should return null', () {
      expect(adService.bannerAd, null);
    });

    test('isBannerAdReady should be false', () {
      expect(adService.isBannerAdReady, false);
    });

    test('isInterstitialAdReady should be false', () {
      expect(adService.isInterstitialAdReady, false);
    });

    test('isRewardedAdReady should be false', () {
      expect(adService.isRewardedAdReady, false);
    });
  });
}
