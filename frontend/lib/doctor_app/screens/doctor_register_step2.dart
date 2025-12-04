// doctor_register_screen2.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'doctor_login_screen.dart';

const String _baseUrl = "http://192.168.252.251:5000";

class DoctorRegisterScreen2 extends StatefulWidget {
  final String fullName, email, phone, hospitalName, specialization, userId;
  const DoctorRegisterScreen2({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.hospitalName,
    required this.specialization,
    required this.userId,
  });
  @override
  State<DoctorRegisterScreen2> createState() => _DoctorRegisterScreen2State();
}

class _DoctorRegisterScreen2State extends State<DoctorRegisterScreen2> {
  final _formKey = GlobalKey<FormState>();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final licenseCtrl = TextEditingController();
  File? _pickedImage;
  bool loading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;
    setState(() => _pickedImage = File(picked.path));
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      // Prepare payload for backend
      final payload = {
        "name": widget.fullName,
        "email": widget.email,
        "password": passwordCtrl.text.trim(),

        // Extra fields (backend currently uses only name/email/password,
        // but sending these is safe; they can be added to schema later)
        "phone": widget.phone,
        "hospitalName": widget.hospitalName,
        "specialization": widget.specialization,
        "userId": widget.userId,
        "licenseNumber": licenseCtrl.text.trim(),
      };

      final uri = Uri.parse("$_baseUrl/api/auth/doctor/register");
      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (!mounted) return;

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["success"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Doctor registered successfully")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DoctorLoginScreen()),
            (r) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                data["message"]?.toString() ?? "Registration failed",
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error ${res.statusCode}: Registration failed")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network/server error")),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    licenseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBEEFF3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 96),
              const SizedBox(height: 8),
              Text(
                widget.fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: licenseCtrl,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "License required";
                        }
                        if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(v)) {
                          return "Alphanumeric only";
                        }
                        if (v.trim().length < 6) {
                          return "Invalid license";
                        }
                        return null;
                      },
                      decoration: _dec("License / Registration"),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Password required";
                        }
                        if (v.length < 6) {
                          return "Minimum 6 chars";
                        }
                        return null;
                      },
                      decoration: _dec("Password"),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: confirmCtrl,
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Confirm password";
                        }
                        if (v != passwordCtrl.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      decoration: _dec("Confirm Password"),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            _pickedImage == null
                                ? const Icon(Icons.add_a_photo,
                                    color: Colors.black54)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _pickedImage!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _pickedImage == null
                                    ? 'Select profile photo (optional)'
                                    : 'Photo selected',
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                      ),
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Register"),
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

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );
}
