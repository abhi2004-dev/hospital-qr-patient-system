import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_step5_screen.dart';

class RegistrationStep4Screen extends StatefulWidget {
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

  const RegistrationStep4Screen({
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
  }) : super(key: key);

  @override
  State<RegistrationStep4Screen> createState() =>
      _RegistrationStep4ScreenState();
}

class _RegistrationStep4ScreenState extends State<RegistrationStep4Screen> {
  final TextEditingController medsCtrl = TextEditingController();
  final TextEditingController surgeryCtrl = TextEditingController();
  final TextEditingController chronicCtrl = TextEditingController();
  final TextEditingController insuranceCtrl = TextEditingController();

  String? allergy;
  final List<String> allergyOptions = [
    "No known allergies",
    "Penicillin",
    "Peanuts",
    "Dust",
    "Other"
  ];

  void nextPage() {
    if (allergy == null ||
        medsCtrl.text.trim().isEmpty ||
        surgeryCtrl.text.trim().isEmpty ||
        chronicCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep5Screen(
          email: widget.email,
          password: widget.password,
          photo: widget.photo,

          name: widget.name,
          dob: widget.dob,
          phone: widget.phone,
          gender: widget.gender,
          bloodGroup: widget.bloodGroup,

          guardianName: widget.guardianName,
          guardianContact: widget.guardianContact,
          relation: widget.relation,

          // 🔹 pass as List<String> (fix)
          allergy: [allergy!],
          medications: medsCtrl.text.trim(),
          pastSurgery: surgeryCtrl.text.trim(),
          chronicIllness: chronicCtrl.text.trim(),
          insurance: insuranceCtrl.text.trim(),
        ),
      ),
    );
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

  Widget dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: allergy,
          hint: const Text("Select allergy"),
          items: allergyOptions
              .map(
                (item) =>
                    DropdownMenuItem(value: item, child: Text(item)),
              )
              .toList(),
          onChanged: (v) => setState(() => allergy = v),
        ),
      ),
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
              "MEDICAL INFORMATION",
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
                  Text(
                    "Allergies",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  dropdown(),
                  const SizedBox(height: 16),

                  field("Current Medication", medsCtrl, "Enter medications"),
                  field("Past Surgery", surgeryCtrl, "Enter surgery history"),
                  field("Chronic Illness", chronicCtrl, "Enter illnesses"),
                  field(
                    "Insurance Provider (optional)",
                    insuranceCtrl,
                    "Enter provider",
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F2F2F),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
