// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:english_aircraft/providers/app_provider.dart';
import 'package:english_aircraft/main.dart';

void main() {
  testWidgets('App should build successfully', (WidgetTester tester) async {
    // Build the app with necessary providers
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppProvider(),
        child: const AlienApp(),
      ),
    );
    
    // Verify the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

