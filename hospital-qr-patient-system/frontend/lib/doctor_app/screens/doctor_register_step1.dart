import 'package:flutter/material.dart';
import 'doctor_register_step2.dart';
import 'doctor_login_screen.dart';

class DoctorRegisterScreen1 extends StatefulWidget {
  const DoctorRegisterScreen1({super.key});

  @override
  State<DoctorRegisterScreen1> createState() => _DoctorRegisterScreen1State();
}

class _DoctorRegisterScreen1State extends State<DoctorRegisterScreen1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController hospitalCtrl = TextEditingController();
  final TextEditingController specializationCtrl = TextEditingController();
  final TextEditingController userIdCtrl = TextEditingController();

  // dropdown specializations
  final List<String> _specializations = [
    "Cardiology",
    "Neurology",
    "Orthopedics",
    "Pediatrics",
    "General Medicine",
    "Dentistry"
  ];
  String? _selectedSpecialization;

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              // Logo
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
              const SizedBox(height: 16),

              // Heading
              const Text(
                "DOCTOR REGISTRATION",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF032859),
                  shadows: [
                    Shadow(
                        color: Colors.black54, offset: Offset(2, 3), blurRadius: 4)
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Card container
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7FA3FF),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter personal info",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 14),

                      // Full name
                      const Text("Full name"),
                      _textField(controller: nameCtrl, hint: "Name"),

                      // Email
                      const SizedBox(height: 12),
                      const Text("Email"),
                      _textField(controller: emailCtrl, hint: "Email"),

                      // Phone number
                      const SizedBox(height: 12),
                      const Text("Phone number"),
                      _textField(
                          controller: phoneCtrl,
                          hint: "Phone Number",
                          keyboard: TextInputType.phone),

                      // Hospital Name
                      const SizedBox(height: 12),
                      const Text("Hospital Name"),
                      _textField(controller: hospitalCtrl, hint: "Hospital name"),

                      // Specialization
                      const SizedBox(height: 12),
                      const Text("Specialization"),
                      _dropdownField(),

                      // Unique user id
                      const SizedBox(height: 12),
                      const Text("Unique user id"),
                      _textField(controller: userIdCtrl, hint: "User ID"),

                      const SizedBox(height: 18),

                      // Next page button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DoctorRegisterScreen2(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Next Page",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Already have account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DoctorLoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
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

  Widget _textField(
      {required TextEditingController controller,
      required String hint,
      TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (val) =>
          val == null || val.isEmpty ? "This field cannot be empty" : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedSpecialization,
      dropdownColor: Colors.white,
      items: _specializations
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) => setState(() => _selectedSpecialization = val),
      decoration: InputDecoration(
        hintText: "Select specialization",
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (val) =>
          val == null || val.isEmpty ? "Please choose specialization" : null,
    );
  }
}
