import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'doctor_register_step1.dart';
import 'doctor_login_screen.dart';

class DoctorRegisterScreen2 extends StatefulWidget {
  const DoctorRegisterScreen2({super.key});

  @override
  State<DoctorRegisterScreen2> createState() => _DoctorRegisterScreen2State();
}

class _DoctorRegisterScreen2State extends State<DoctorRegisterScreen2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController licenseCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmVisible = false;

  File? _pickedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    // Show simple dialog to choose camera or gallery
    final choice = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(context).pop('gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () => Navigator.of(context).pop('camera'),
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Cancel'),
              onTap: () => Navigator.of(context).pop(null),
            ),
          ]),
        );
      },
    );

    if (choice == null) return;

    try {
      final XFile? picked = await _picker.pickImage(
        source: choice == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (picked != null) {
        setState(() {
          _pickedImage = File(picked.path);
        });
      }
    } catch (e) {
      // handle errors (permissions etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selection failed: $e')),
      );
    }
  }

  void _onRegisterPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (passwordCtrl.text != confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // TODO: Hook this into your backend register API (auth_service / api_service)
    // For now show success and navigate to login
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text('Doctor registered successfully. Proceed to login.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // navigate to login (replace stack)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const DoctorLoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    licenseCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // sizing
    final media = MediaQuery.of(context);
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              // Logo and tagline (same as page1)
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 8),
              const Text(
                "Health meets Technology..",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF032859),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Big heading
              const Text(
                "DOCTOR REGISTRATION",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF032859),
                  shadows: [
                    Shadow(color: Colors.black54, offset: Offset(2, 3), blurRadius: 4),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Card container (credential form)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7FA3FF),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter credentials',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      // License / Registration
                      const Text('License/ Registration'),
                      const SizedBox(height: 6),
                      _inputField(label: 'License / Registration', controller: licenseCtrl),

                      const SizedBox(height: 12),

                      // Password
                      const Text('Enter password'),
                      const SizedBox(height: 6),
                      _passwordField(
                        controller: passwordCtrl,
                        hint: 'password',
                        visible: _passwordVisible,
                        onToggle: () => setState(() => _passwordVisible = !_passwordVisible),
                      ),

                      const SizedBox(height: 12),

                      // Confirm password
                      const Text('Confirm password'),
                      const SizedBox(height: 6),
                      _passwordField(
                        controller: confirmCtrl,
                        hint: 'password',
                        visible: _confirmVisible,
                        onToggle: () => setState(() => _confirmVisible = !_confirmVisible),
                      ),

                      const SizedBox(height: 12),

                      // Select photo
                      const Text('Select photo'),
                      const SizedBox(height: 6),
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
                              if (_pickedImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(_pickedImage!, width: 40, height: 40, fit: BoxFit.cover),
                                )
                              else
                                const Icon(Icons.add_a_photo, color: Colors.black54),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _pickedImage == null ? 'photo' : 'photo selected',
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Register button
                      Center(
                        child: ElevatedButton(
                          onPressed: _onRegisterPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Register', style: TextStyle(fontSize: 16)),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({required String label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !visible,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Please enter password';
        if (v.length < 6) return 'Password must be at least 6 chars';
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
          color: Colors.black54,
          onPressed: onToggle,
        ),
      ),
    );
  }
}
