import 'package:flutter/material.dart';
import 'common/splash_screen.dart';
import 'utils/constants.dart';

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
        scaffoldBackgroundColor: AppColors.primary,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
