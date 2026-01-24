// Web Speech API helper - web platform
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

bool _isSpeaking = false;

void speakText(String text, {double rate = 0.9}) {
  final synth = html.window.speechSynthesis;

  // Toggle mantığı: konuşuyorsa durdur, durmuşsa konuş
  if (_isSpeaking) {
    synth?.cancel();
    _isSpeaking = false;
  } else {
    synth?.cancel(); // Önceki konuşmayı temizle
    final utterance = html.SpeechSynthesisUtterance(text);
    utterance.lang = 'en-US';
    utterance.rate = rate; // Kullanıcının belirlediği hız

    // Konuşma bitince flag'i sıfırla
    utterance.onEnd.listen((_) {
      _isSpeaking = false;
    });

    synth?.speak(utterance);
    _isSpeaking = true;
  }
}
