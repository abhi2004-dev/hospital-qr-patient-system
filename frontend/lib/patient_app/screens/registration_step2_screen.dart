import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_step3_screen.dart';

class RegistrationStep2Screen extends StatefulWidget {
  const RegistrationStep2Screen({Key? key}) : super(key: key);

  @override
  State<RegistrationStep2Screen> createState() => _RegistrationStep2ScreenState();
}

class _RegistrationStep2ScreenState extends State<RegistrationStep2Screen> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodGroup;

  final List<String> _bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
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
            colors: [
              Color(0xFF9BD6DC),
              Color(0xFF9BD6DC),
            ],
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

              // Back arrow
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Logo
              Image.asset(
                'assets/logo.png',
                width: 110,
                height: 110,
              ),

              const SizedBox(height: 10),

              Text(
                "Health meets Technology..",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "PATIENT REGISTRATION",
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

              const SizedBox(height: 15),

              Text(
                "Enter personal info",
                style: GoogleFonts.fredoka(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

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
                    _buildLabel("Full name"),
                    _buildTextField(_nameController, "name", false),

                    const SizedBox(height: 15),
                    _buildLabel("D.O.B"),
                    _buildTextField(_dobController, "yyyy-mm-dd", false),

                    const SizedBox(height: 15),
                    _buildLabel("Gender"),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _buildGenderOption("male"),
                        const SizedBox(width: 20),
                        _buildGenderOption("female"),
                      ],
                    ),

                    const SizedBox(height: 15),
                    _buildLabel("phone number"),
                    _buildTextField(_phoneController, "Phone Number", false),

                    const SizedBox(height: 15),
                    _buildLabel("Blood group"),
                    _buildDropdown(),

                    const SizedBox(height: 15),
                    _buildLabel("Address"),
                    _buildTextField(_addressController, "", false),

                    const SizedBox(height: 15),
                    _buildLabel("Email"),
                    _buildTextField(_emailController, "email", false),

                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationStep3Screen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F2F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                        ),
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
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
            "Select Blood Group",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          value: _selectedBloodGroup,
          items: _bloodGroups.map((bg) {
            return DropdownMenuItem<String>(
              value: bg,
              child: Text(bg),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedBloodGroup = val;
            });
          },
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _selectedGender,
          activeColor: Colors.black,
          onChanged: (val) {
            setState(() {
              _selectedGender = val;
            });
          },
        ),
        Text(
          gender,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
