// frontend/lib/common/splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/role_selection.dart';
import '../doctor_app/screens/dashboard_screen.dart' as doctor_dashboard;
import '../patient_app/screens/dashboard_screen.dart' as patient_dashboard;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    _startNavigationLogic();
  }

  Future<void> _startNavigationLogic() async {
    // Keep the splash visible for 2 seconds as before
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('loggedInRole');

    if (role == 'doctor') {
      final String? token = prefs.getString('doctorToken');
      if (token != null && token.isNotEmpty) {
        // Doctor auto-login → Dashboard
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const doctor_dashboard.DashboardScreen(),
          ),
        );
        return;
      }
    } else if (role == 'patient') {
      final String? patientId = prefs.getString('patientId');
      if (patientId != null && patientId.isNotEmpty) {
        // Patient auto-login → Dashboard
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const patient_dashboard.DashboardScreen(),
          ),
        );
        return;
      }
    }

    // Default: pick role (as before)
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077B6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Image.asset('assets/logo.png', height: 120),
            ),
            const SizedBox(height: 14),
            const Text(
              'Health meets Technology..',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
