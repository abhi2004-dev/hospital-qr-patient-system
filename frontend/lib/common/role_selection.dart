import 'package:flutter/material.dart';

// doctor & patient entry screens
import '../doctor_app/screens/doctor_register_step1.dart';
import '../patient_app/screens/registration_step1_screen.dart';

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
        MaterialPageRoute(builder: (_) => DoctorRegisterStep1()), // FIXED → removed const
      );
    } else if (selectedRole == 'patient') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PatientRegistrationStep1()), // FIXED → removed const
      );
    }
  }

  Widget roleCard(String label, IconData icon, String value) {
    final bool active = selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => selectedRole = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: active ? Colors.blue.shade700 : Colors.transparent,
              width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(active ? 0.12 : 0.04),
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
                    color: Color(0xFF032859),
                  ),
                ),
                const SizedBox(height: 20),
                roleCard('PATIENT', Icons.person, 'patient'),
                const SizedBox(height: 16),
                roleCard('DOCTOR', Icons.medical_services, 'doctor'),
                const Spacer(),
                ElevatedButton(
                  onPressed: selectedRole == null ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004E89),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
