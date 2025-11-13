import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/theme.dart';
import 'utils/constants.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const PatientApp());
}

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  // Check if patient already logged in
  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(patientTokenKey) != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hospital QR Patient",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          // Loading state
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // If logged in → Dashboard
          if (snapshot.data == true) {
            return const DashboardScreen();
          }

          // If NOT logged in → Login Screen
          return const LoginScreen();
        },
      ),
    );
  }
}
