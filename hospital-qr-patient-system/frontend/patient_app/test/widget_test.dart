// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// This is a basic Flutter widget test.
// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Make sure this import points to your main.dart file
import 'package:patient_app/main.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // 1. Build the correct app widget: PatientApp
    await tester.pumpWidget(const PatientApp());

    // 2. Verify that the login screen is showing.
    // We can do this by looking for the title and the login button.
    expect(find.text('Patient Login'), findsOneWidget);
    expect(find.text('Please log in.'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // 3. Verify no counter elements are present.
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.text('0'), findsNothing);
  });
}