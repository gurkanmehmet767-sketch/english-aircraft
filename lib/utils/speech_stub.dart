// Mobile Speech API helper - non-web platforms (Android/iOS/Desktop)
// Uses flutter_tts package for Text-to-Speech functionality

import 'package:flutter_tts/flutter_tts.dart';

// Global TTS instance
final FlutterTts _flutterTts = FlutterTts();
bool _isInitialized = false;
bool _isSpeaking = false;

Future<void> _initTts() async {
  if (_isInitialized) return;
  
  await _flutterTts.setLanguage('en-US');
  await _flutterTts.setSpeechRate(0.5); // Default rate
  await _flutterTts.setVolume(1.0);
  await _flutterTts.setPitch(1.0);
  
  _flutterTts.setCompletionHandler(() {
    _isSpeaking = false;
  });
  
  _flutterTts.setCancelHandler(() {
    _isSpeaking = false;
  });
  
  _flutterTts.setErrorHandler((msg) {
    _isSpeaking = false;
  });
  
  _isInitialized = true;
}

void speakText(String text, {double rate = 0.9}) async {
  await _initTts();
  
  // Toggle logic: if speaking, stop; if stopped, speak
  if (_isSpeaking) {
    await _flutterTts.stop();
    _isSpeaking = false;
  } else {
    await _flutterTts.stop(); // Clear any previous speech
    
    // Convert rate (0.5-2.0 range expected from web) to flutter_tts range (0.0-1.0)
    // Web rate 0.9 ≈ flutter_tts 0.45
    double adjustedRate = rate * 0.5;
    if (adjustedRate < 0.1) adjustedRate = 0.1;
    if (adjustedRate > 1.0) adjustedRate = 1.0;
    
    await _flutterTts.setSpeechRate(adjustedRate);
    await _flutterTts.speak(text);
    _isSpeaking = true;
  }
}
