import 'package:flutter/material.dart';
import 'common/splash_screen.dart';
import 'doctor_app/utils/app_colors.dart';   // <-- FIXED
import 'doctor_app/utils/constants.dart';   // keep this ONLY if needed

void main() {
  runApp(const HospitalQRApp());
}

class HospitalQRApp extends StatelessWidget {
  const HospitalQRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital QR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.bg,  // FIXED - use bg color, not primary
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
