import 'package:flutter/material.dart';
import 'doctor_register_step1.dart';
import 'dashboard_screen.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool _passwordVisible = false;

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

              const Text(
                "DOCTOR LOGIN",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF032859),
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(2, 3),
                      blurRadius: 4,
                    ),
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
                      const Text(
                        "Enter doctor credentials",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 14),

                      // Doctor ID / Email / Phone
                      const Text("doctor_id, email or mobile number"),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: idCtrl,
                        validator: (val) =>
                            val == null || val.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Enter ID / Email / Number",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Password
                      const Text("password"),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: passwordCtrl,
                        obscureText: !_passwordVisible,
                        validator: (val) => val == null || val.isEmpty
                            ? "Password required"
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Buttons: Login & Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Logging in...')),
                                );

                                // TODO: Hook up with backend API login
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const DashboardScreen()),
                                  );
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Login"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DoctorRegisterScreen1(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Register"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Forgot password
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password reset flow coming soon.')),
                            );
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
