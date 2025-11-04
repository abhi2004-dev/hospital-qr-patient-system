// Flutter widget test for the Hospital QR Patient App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patient_app/main.dart';

void main() {
  testWidgets('App loads splash screen and transitions to login screen',
      (WidgetTester tester) async {
    // 1. Build the app (MyApp is your root widget in main.dart)
    await tester.pumpWidget(const MyApp());

    // 2. Verify splash screen elements appear
    expect(find.text('HEALTH_QR'), findsOneWidget);
    expect(find.text('Smart Health. Simplified.'), findsOneWidget);

    // 3. Simulate time passing for the splash animation to finish
    await tester.pump(const Duration(seconds: 5));

    // 4. Verify that the Login Screen loaded successfully
    expect(find.text('Welcome to Login Screen 👋'), findsOneWidget);
  });
}
