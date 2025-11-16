import 'package:flutter/material.dart';
import 'screens/registration_step1_screen.dart';

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hospital QR - Patient",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF004E89),
        scaffoldBackgroundColor: const Color(0xFFE8F6FF),
      ),
      home: const PatientRegistrationStep1(),   // ✅ Correct class name
    );
  }
}
