import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class RegistrationStep5Screen extends StatefulWidget {
  final String email;
  final String password;
  final dynamic photo;

  final String name;
  final String dob;
  final String phone;
  final String gender;
  final String bloodGroup;

  final String guardianName;
  final String guardianContact;
  final String relation;

  final List<String> allergy; // list
  final String medications;
  final String pastSurgery;
  final String chronicIllness;
  final String insurance;

  const RegistrationStep5Screen({
    Key? key,
    required this.email,
    required this.password,
    required this.photo,
    required this.name,
    required this.dob,
    required this.phone,
    required this.gender,
    required this.bloodGroup,
    required this.guardianName,
    required this.guardianContact,
    required this.relation,
    required this.allergy,
    required this.medications,
    required this.pastSurgery,
    required this.chronicIllness,
    required this.insurance,
  }) : super(key: key);

  @override
  State<RegistrationStep5Screen> createState() =>
      _RegistrationStep5ScreenState();
}

class _RegistrationStep5ScreenState extends State<RegistrationStep5Screen> {
  final TextEditingController emergencyNameCtrl = TextEditingController();
  final TextEditingController emergencyContactCtrl = TextEditingController();
  final TextEditingController relationshipCtrl = TextEditingController();

  bool loading = false;

  Future<void> submit() async {
    if (emergencyNameCtrl.text.trim().isEmpty ||
        emergencyContactCtrl.text.trim().isEmpty ||
        relationshipCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);

    // Build payload for full registration
    final Map<String, dynamic> payload = {
      "email": widget.email,
      "password": widget.password,

      "name": widget.name,
      "dob": widget.dob,
      "phone": widget.phone,
      "gender": widget.gender,
      "bloodGroup": widget.bloodGroup,

      "guardianName": widget.guardianName,
      "guardianContact": widget.guardianContact,
      "relation": widget.relation,

      "allergy": widget.allergy,
      "medications": widget.medications,
      "pastSurgery": widget.pastSurgery,
      "chronicIllness": widget.chronicIllness,
      "insurance": widget.insurance,

      "emergencyName": emergencyNameCtrl.text.trim(),
      "emergencyContact": emergencyContactCtrl.text.trim(),
      "emergencyRelation": relationshipCtrl.text.trim(),

      // if backend expects photo field, add it here
      // "photo": widget.photo,
    };

    final data = await AuthService.registerPatientFull(payload);

    setState(() => loading = false);

    if (data["success"] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"] ?? "Registration failed")),
      );
    }
  }

  Widget field(String label, TextEditingController ctrl, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF9BD6DC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/logo.png', width: 110, height: 110),

            const SizedBox(height: 10),
            Text(
              "Health meets Technology..",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 16),
            Text(
              "EMERGENCY INFORMATION",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0B0B5A),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                color: const Color(0xFF7388F6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  field("Emergency guardian name", emergencyNameCtrl, "Enter name"),
                  field("Emergency contact number", emergencyContactCtrl, "10-digit phone"),
                  field("Relationship", relationshipCtrl, "Relation"),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: loading ? null : submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F2F2F),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      loading ? "Submitting..." : "Submit",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
