// doctor_login_screen.dart
import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});
  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text;
    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter email and password")));
      return;
    }
    setState(() => loading = true);
    final res = await ApiService.doctorLogin(email, pass);
    setState(() => loading = false);
    if (res == null || res['success'] != true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid credentials or network error")));
      return;
    }
    await AuthService.saveToken(res['token']);
    await AuthService.saveDoctorName(res['doctor']?['name'] ?? '');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBEEFF3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(children: [
            Image.asset('assets/logo.png', height: 120),
            const SizedBox(height: 12),
            const Text("Doctor Login", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(controller: emailCtrl, decoration: _dec("Email"), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            TextFormField(controller: passCtrl, decoration: _dec("Password"), obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: loading ? null : _login, style: ElevatedButton.styleFrom(backgroundColor: Colors.black87, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12)), child: loading ? const CircularProgressIndicator(color: Colors.white) : const Text("Login")),
            const SizedBox(height: 12),
            TextButton(onPressed: () {
              // TODO: navigation to register
            }, child: const Text("Don't have an account? Register")),
          ]),
        ),
      ),
    );
  }

  InputDecoration _dec(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
  );
}
