import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RewardedAdButton extends StatelessWidget {
  final VoidCallback onAdWatched;
  final String buttonText;

  const RewardedAdButton({
    super.key,
    required this.onAdWatched,
    this.buttonText = '📺 Video İzle + 1 Can',
  });

  @override
  Widget build(BuildContext context) {
    // Ads not supported on web - show disabled button
    if (kIsWeb) {
      return ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.play_circle_filled),
        label: Text('$buttonText (Web\'de kullanılamaz)'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      );
    }
    
    // On mobile, return placeholder for now
    return ElevatedButton.icon(
      onPressed: null,
      icon: const Icon(Icons.play_circle_filled),
      label: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
