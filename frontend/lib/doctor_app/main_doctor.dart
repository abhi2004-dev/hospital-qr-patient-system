// frontend/lib/doctor_app/main_doctor.dart
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'utils/app_colors.dart';

class DoctorApp extends StatelessWidget {
  final String token;
  final String doctorId;

  const DoctorApp({Key? key, required this.token, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.bg,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary),
      ),
      home: DashboardScreen(token: token, doctorId: doctorId),
    );
  }
}
