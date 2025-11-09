import 'package:flutter/material.dart';
import 'doctor_login_screen.dart';
import 'doctor_register_step2.dart';

class DoctorRegisterStep1 extends StatefulWidget {
  const DoctorRegisterStep1({super.key});

  @override
  State<DoctorRegisterStep1> createState() => _DoctorRegisterStep1State();
}

class _DoctorRegisterStep1State extends State<DoctorRegisterStep1> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  void _next() {
    if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all details')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorRegisterStep2(
          name: nameCtrl.text.trim(),
          email: emailCtrl.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBEEFF3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 12),
              const Text(
                "DOCTOR REGISTRATION",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF032859),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7FA3FF),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    _textField('Enter your full name', nameCtrl),
                    const SizedBox(height: 16),
                    const Text('Email ID', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    _textField('Enter your email', emailCtrl),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Next', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorLoginScreen()));
                        },
                        child: const Text(
                          "Already registered? Login here",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String hint, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
