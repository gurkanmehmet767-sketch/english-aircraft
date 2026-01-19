import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Web-safe banner ad widget - only shows on mobile platforms
class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Ads not supported on web
    if (kIsWeb) {
      return const SizedBox.shrink();
    }
    
    // On mobile, return empty for now (will be implemented when ads are enabled)
    return const SizedBox.shrink();
  }
}
