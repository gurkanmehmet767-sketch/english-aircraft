import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LegalScreen extends StatefulWidget {
  final String documentType; // 'kvkk', 'privacy', 'terms'

  const LegalScreen({
    super.key,
    required this.documentType,
  });

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  String _content = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    try {
      String path;
      switch (widget.documentType) {
        case 'kvkk':
          path = 'assets/legal/kvkk_aydinlatma_metni.md';
          break;
        case 'privacy':
          path = 'assets/legal/gizlilik_politikasi.md';
          break;
        case 'terms':
          path = 'assets/legal/kullanim_kosullari.md';
          break;
        default:
          path = 'assets/legal/gizlilik_politikasi.md';
      }

      final content = await rootBundle.loadString(path);
      setState(() {
        _content = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _content = '# Hata\n\nDokuman yüklenirken bir hata oluştu.\n\nLütfen daha sonra tekrar deneyin.';
        _isLoading = false;
      });
    }
  }

  String _getTitle() {
    switch (widget.documentType) {
      case 'kvkk':
        return 'KVKK Aydınlatma Metni';
      case 'privacy':
        return 'Gizlilik Politikası';
      case 'terms':
        return 'Kullanım Koşulları';
      default:
        return 'Yasal Bilgiler';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(_getTitle()),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00D9FF),
              ),
            )
          : Markdown(
              data: _content,
              styleSheet: MarkdownStyleSheet(
                h1: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                h2: const TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
                h3: const TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
                p: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
                listBullet: const TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 14,
                ),
                strong: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                em: const TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                blockquote: const TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
                code: const TextStyle(
                  color: Color(0xFF00D9FF),
                  backgroundColor: Color(0xFF0F3460),
                  fontFamily: 'monospace',
                ),
                horizontalRuleDecoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF00D9FF),
                      width: 1,
                    ),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16),
            ),
    );
  }
}
