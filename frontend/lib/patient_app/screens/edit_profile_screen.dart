import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart' as patient_auth;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final userIdController = TextEditingController();

  bool _loading = true;
  bool _editing = false;
  String _patientId = "";

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  Future<void> _loadExistingData() async {
    setState(() {
      _loading = true;
      _editing = false;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString("patient_id");

      if (id == null || id.isEmpty) {
        setState(() => _loading = false);
        return;
      }

      _patientId = id;

      final res = await patient_auth.AuthService.getPatient(id);

      if (res["success"] == true && res["patient"] != null) {
        final p = res["patient"];

        setState(() {
          nameController.text = (p["name"] ?? "").toString();
          dobController.text = (p["dob"] ?? "").toString();
          emailController.text = (p["email"] ?? "").toString();
          phoneController.text = (p["phone"] ?? "").toString();
          addressController.text = (p["address"] ?? "").toString();
          userIdController.text =
              (p["uniqueID"] ?? p["_id"] ?? "").toString(); // display something
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_patientId.isEmpty) return;

    setState(() => _loading = true);
    try {
      final res = await patient_auth.AuthService.updateProfile(
        patientID: _patientId,
        name: nameController.text.trim(),
        dob: dobController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
      );

      if (res["success"] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
        }

        // disable editing again
        setState(() {
          _editing = false;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(res["message"] ?? "Failed to update profile")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error updating profile")),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A82B2),
              Color(0xFF157BAA),
              Color(0xFF1174A2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),

                      const SizedBox(height: 10),

                      // Profile icon + edit icon
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.edit, size: 22),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      _label("Full name"),
                      _inputBox(nameController, "Full name",
                          enabled: _editing),
                      const SizedBox(height: 18),

                      _label("D.O.B"),
                      _inputBox(dobController, "Enter your D.O.B",
                          enabled: _editing),
                      const SizedBox(height: 18),

                      _label("Email"),
                      _inputBox(emailController, "enter your email",
                          enabled: _editing),
                      const SizedBox(height: 18),

                      _label("Phone number"),
                      _inputBox(phoneController, "phone number",
                          enabled: _editing),
                      const SizedBox(height: 18),

                      _label("Address"),
                      _inputBox(addressController, "Address",
                          enabled: _editing),
                      const SizedBox(height: 18),

                      _label("Unique User ID"),
                      _inputBox(userIdController, "Unique user ID",
                          enabled: false),
                      const SizedBox(height: 30),

                      // Buttons row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _smallButton("Edit", () {
                            setState(() {
                              _editing = true;
                            });
                          }),
                          _smallButton("Save", () {
                            if (_editing) {
                              _saveProfile();
                            }
                          }),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _inputBox(TextEditingController controller, String hint,
      {required bool enabled}) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
        ),
        style: GoogleFonts.poppins(fontSize: 15),
      ),
    );
  }

  Widget _smallButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        fixedSize: const Size(110, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
