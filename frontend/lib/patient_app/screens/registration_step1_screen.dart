import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'registration_step2_screen.dart';

class PatientRegistrationStep1 extends StatefulWidget {
  const PatientRegistrationStep1({super.key});

  @override
  State<PatientRegistrationStep1> createState() =>
      _PatientRegistrationStep1State();
}

class _PatientRegistrationStep1State extends State<PatientRegistrationStep1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  File? selectedImage;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void _goNext() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a photo")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep2Screen(
          email: emailCtrl.text.trim(),
          password: passCtrl.text.trim(),
          photo: selectedImage!,
        ),
      ),
    );
  }

  Widget _textField(TextEditingController c, String hint,
      {bool obscure = false}) {
    return TextFormField(
      controller: c,
      obscureText: obscure,
      validator: (v) {
        if (v == null || v.trim().isEmpty) return "$hint is required";
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BD6DC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 8),

              const Text("Health meets Technology..",
                  style: TextStyle(fontSize: 14, color: Colors.black87)),

              const SizedBox(height: 10),

              const Text(
                "PATIENT REGISTRATION",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B0B5A),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                decoration: BoxDecoration(
                  color: const Color(0xFF7388F6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("enter your email",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),
                    _textField(emailCtrl, "Email"),
                    const SizedBox(height: 16),

                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter password",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),
                    _textField(passCtrl, "password", obscure: true),
                    const SizedBox(height: 16),

                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("confirm password",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: confirmPassCtrl,
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Confirm password is required";
                        }
                        if (v.trim() != passCtrl.text.trim()) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "password",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 18),

                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("upload photo",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 6),

                    GestureDetector(
                      onTap: pickPhoto,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedImage == null
                              ? "jpg/png format"
                              : "Photo selected ✔",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    ElevatedButton(
                      onPressed: _goNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: const Text("Register"),
                    ),
                  ]),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
