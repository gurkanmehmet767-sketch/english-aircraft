
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = provider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Üyelik'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Arka Plan
          Positioned.fill(
            child: Image.asset(
              isDark ? 'assets/images/space_bg.webp' : 'assets/images/palm_beach_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.7))),

          // İçerik
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              children: [
                const Icon(Icons.diamond_outlined,
                    size: 80, color: Colors.amber),
                const SizedBox(height: 16),
                const Text(
                  'ALIEN PREMIUM',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sınırları kaldır, gökyüzüne hükmet!',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 48),

                // Avantajlar Listesi
                _buildFeatureRow('Sınırsız Can', 'Hata yapsan bile durma.',
                    Icons.favorite, Colors.red),
                _buildFeatureRow('Reklamsız', 'Kesintisiz öğrenme deneyimi.',
                    Icons.block, Colors.blue),
                _buildFeatureRow(
                    'Offline Mod',
                    'Uçaktayken bile internet gerekmez.',
                    Icons.wifi_off,
                    Colors.green),
                _buildFeatureRow(
                    'İleri Seviye',
                    'C1 & C2 Havacılık terimlerine tam erişim.',
                    Icons.flight_takeoff,
                    Colors.orange),

                const SizedBox(height: 48),

                // Fiyat Kartı
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF58CC02),
                        const Color(0xFF2E7D32),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF58CC02).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'AYLIK ABONELİK',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('₺',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text('99',
                              style: TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text('/ay',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white70)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Ödeme işlemi buraya gelecek
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Ödeme sistemi yakında aktif olacak!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2E7D32),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'HEMEN BAŞLA',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'İstediğin zaman iptal et.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
      String title, String desc, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
