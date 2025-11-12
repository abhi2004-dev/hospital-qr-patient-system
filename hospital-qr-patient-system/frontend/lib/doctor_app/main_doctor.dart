import 'package:flutter/material.dart';
import '../doctor_app/screens/doctor_login_screen.dart';
import '../doctor_app/screens/dashboard_screen.dart';
import '../doctor_app/utils/themes.dart';
import '../utils/constants.dart';
const String appName="Q-health";

void main() {
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName, // from constants.dart
      debugShowCheckedModeBanner: false,
      theme: doctorAppTheme ?? ThemeData.light(), // <- ✅ safe fallback added
      initialRoute: '/login',
      routes: {
        '/login': (context) => const DoctorLoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
