import 'package:flutter/material.dart';
import '../doctor_app/screens/doctor_register_step1.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  void _continue() {
    if (selectedRole == 'doctor') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorRegisterStep1()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Patient app will be available soon.")),
      );
    }
  }

  Widget _roleCard(String label, IconData icon, String value) {
    final active = selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => selectedRole = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(active ? 0.2 : 0.1),
              blurRadius: active ? 12 : 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF2EB5E0),
              radius: 26,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                color: active ? const Color(0xFF032859) : Colors.black87,
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 10),
                const Text(
                  'Health meets Technology..',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF032859),
                    fontWeight: FontWeight.w500,
                  ),
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
                const SizedBox(height: 24),
                _roleCard('PATIENT', Icons.person, 'patient'),
                const SizedBox(height: 18),
                _roleCard('DOCTOR', Icons.medical_services, 'doctor'),
                const Spacer(),
                ElevatedButton(
                  onPressed: selectedRole == null ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004E89),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
