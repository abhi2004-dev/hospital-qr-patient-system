import 'package:flutter/material.dart';
import '../screens/doctor_login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole; // 'patient' or 'doctor'

  void _continue() {
    if (selectedRole == 'doctor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DoctorLoginScreen()),
      );
    } else if (selectedRole == 'patient') {
      // Since patient_app is a separate Flutter project,
      // we can't import its screens directly.
      // Instead, show a helpful message for now.
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Switch App"),
          content: const Text(
              "Please open the Patient App to log in as a patient."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Widget roleCard(String label, IconData icon, String value) {
    final bool active = selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => selectedRole = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(active ? 0.12 : 0.06),
              blurRadius: active ? 12 : 6,
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF2EB5E0),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: active ? const Color(0xFF004E89) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFF2EB5E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Image.asset('assets/logo.png', height: 96),
                const SizedBox(height: 8),
                const Text(
                  'Health meets Technology..',
                  style: TextStyle(fontSize: 14, color: Color(0xFF032859)),
                ),
                const SizedBox(height: 40),
                const Text(
                  'SELECT YOUR ROLE',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF032859)),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7FA3FF).withOpacity(0.35),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          roleCard('PATIENT', Icons.person, 'patient'),
                          const SizedBox(height: 18),
                          roleCard('DOCTOR', Icons.medical_services, 'doctor'),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectedRole == null ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004E89),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
