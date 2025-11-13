import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_step3_screen.dart';

class RegistrationStep4Screen extends StatefulWidget {
  const RegistrationStep4Screen({Key? key}) : super(key: key);

  @override
  State<RegistrationStep4Screen> createState() => _RegistrationStep4ScreenState();
}

class _RegistrationStep4ScreenState extends State<RegistrationStep4Screen> {
  final _medicationController = TextEditingController();
  final _surgeryController = TextEditingController();
  final _chronicController = TextEditingController();
  final _insuranceController = TextEditingController();

  String? _selectedAllergy;
  final List<String> _allergyOptions = [
    "No known allergies",
    "Penicillin",
    "Peanuts",
    "Dust",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9BD6DC), Color(0xFF9BD6DC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Back Arrow
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationStep3Screen(),
                      ),
                    );
                  },
                ),
              ),

              // Logo
              Image.asset('assets/logo.png', width: 110, height: 110),

              const SizedBox(height: 10),

              // Tagline
              Text(
                "Health meets Technology..",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                "MEDICAL INFORMATION",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0B0B5A),
                  letterSpacing: 1.0,
                  shadows: [
                    const Shadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 1,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Blue Card Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFF7388F6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Allergies"),
                    _buildDropdown(),

                    const SizedBox(height: 15),
                    _buildLabel("current medication"),
                    _buildTextField(_medicationController, "enter current medications", false),

                    const SizedBox(height: 15),
                    _buildLabel("past surgery"),
                    _buildTextField(_surgeryController, "enter past surgeries", false),

                    const SizedBox(height: 15),
                    _buildLabel("chronic illnesses"),
                    _buildTextField(_chronicController, "enter chronic illnesses", false),

                    const SizedBox(height: 15),
                    _buildLabel("Insurance provider(if any)"),
                    _buildTextField(_insuranceController, "enter insurance provider", false),

                    const SizedBox(height: 25),

                    // Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton("Edit", () {}),
                        _buildButton("Save", () {}),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey[700],
          fontSize: 13,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            "Select Allergy",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          value: _selectedAllergy,
          items: _allergyOptions.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedAllergy = val;
            });
          },
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2F2F2F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
