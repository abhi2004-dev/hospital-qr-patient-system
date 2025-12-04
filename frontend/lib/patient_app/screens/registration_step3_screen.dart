import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_step4_screen.dart';

class RegistrationStep3Screen extends StatefulWidget {
  final String email;
  final String password;
  final dynamic photo;

  final String name;
  final String dob;
  final String phone;
  final String gender;
  final String bloodGroup;

  const RegistrationStep3Screen({
    Key? key,
    required this.email,
    required this.password,
    required this.photo,
    required this.name,
    required this.dob,
    required this.phone,
    required this.gender,
    required this.bloodGroup,
  }) : super(key: key);

  @override
  State<RegistrationStep3Screen> createState() =>
      _RegistrationStep3ScreenState();
}

class _RegistrationStep3ScreenState extends State<RegistrationStep3Screen> {
  final TextEditingController guardianNameCtrl = TextEditingController();
  final TextEditingController guardianContactCtrl = TextEditingController();
  final TextEditingController relationCtrl = TextEditingController();

  void nextPage() {
    if (guardianNameCtrl.text.trim().isEmpty ||
        guardianContactCtrl.text.trim().isEmpty ||
        relationCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep4Screen(
          email: widget.email,
          password: widget.password,
          photo: widget.photo,
          name: widget.name,
          dob: widget.dob,
          phone: widget.phone,
          gender: widget.gender,
          bloodGroup: widget.bloodGroup,

          guardianName: guardianNameCtrl.text.trim(),
          guardianContact: guardianContactCtrl.text.trim(),
          relation: relationCtrl.text.trim(),
        ),
      ),
    );
  }

  Widget field(String label, TextEditingController ctrl, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
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
            Text("Health meets Technology..",
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400)),

            const SizedBox(height: 16),
            Text("PATIENT REGISTRATION",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0B0B5A))),

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
                  field("Guardian Name", guardianNameCtrl, "Enter name"),
                  field("Guardian Contact", guardianContactCtrl, "10-digit number"),
                  field("Relationship", relationCtrl, "Relation"),

                  const SizedBox(height: 10),

                  ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F2F2F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10)),
                      child: const Text("Next",
                          style:
                              TextStyle(fontSize: 15, color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
