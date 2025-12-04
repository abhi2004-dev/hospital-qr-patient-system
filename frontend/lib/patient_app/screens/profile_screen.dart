// frontend/lib/patient_app/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart' as patient_auth;
import 'edit_profile_screen.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "";
  String _dob = "";
  String _age = "";
  String _email = "";
  String _phone = "";
  String _address = "";
  String _patientId = "";
  String _bloodGroup = "";
  List<dynamic> _allergies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  Future<void> _loadPatient() async {
    setState(() => _loading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('patient_id'); // ✔ correct key

      if (id == null || id.isEmpty) {
        setState(() => _loading = false);
        return;
      }

      _patientId = id;

      // 🔥 Fetch from backend using your AuthService
      final res = await patient_auth.AuthService.getPatient(id);

      if (res["success"] == true && res["patient"] != null) {
        final p = res["patient"];

        setState(() {
          _name = (p["name"] ?? "").toString();
          _email = (p["email"] ?? "").toString();
          _phone = (p["phone"] ?? "").toString();
          _address = (p["address"] ?? "").toString();
          _dob = (p["dob"] ?? "").toString();
          _bloodGroup = (p["bloodGroup"] ?? "").toString();
          _allergies = (p["allergies"] ?? []);

          // 🧮 If age not stored, fallback to DOB
          if (p["age"] != null) {
            _age = p["age"].toString();
          } else if (_dob.isNotEmpty) {
            _age = "DOB: $_dob";
          }

          _loading = false;
        });
        return;
      }

      // Fallback if backend returned no data
      setState(() {
        _name = prefs.getString('patient_name') ?? "";
        _email = prefs.getString('patient_email') ?? "";
        _phone = prefs.getString('patient_phone') ?? "";
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFBBD2FF),
              Color(0xFF9AB6FF),
              Color(0xFF7388F6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 20),

                    // ---------------- TOP BAR ----------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DashboardScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Profile",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ---------------- BODY ----------------
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              // ---------------- TOP CARD ----------------
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person,
                                        size: 70, color: Colors.black87),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _name.isNotEmpty
                                              ? _name
                                              : "Patient name",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _age.isNotEmpty ? _age : "Age",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Patient ID: $_patientId",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 18),

                              // ---------------- CONTACT CARD ----------------
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contact",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Phone
                                    Row(
                                      children: [
                                        const Icon(Icons.phone, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          _phone.isNotEmpty
                                              ? _phone
                                              : "Phone not available",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    // Email
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.email, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _email.isNotEmpty
                                                ? _email
                                                : "Email not available",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    // Address
                                    Text(
                                      "Address",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _address.isNotEmpty
                                          ? _address
                                          : "Address not available",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    // Blood group
                                    Text(
                                      "Blood Group",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _bloodGroup.isNotEmpty
                                          ? _bloodGroup
                                          : "Not provided",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),

                                    const SizedBox(height: 12),

                                    // Allergies
                                    Text(
                                      "Allergies",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _allergies.isNotEmpty
                                          ? _allergies.join(", ")
                                          : "None",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // ---------------- BUTTONS ----------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const EditProfileScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text("Edit Profile"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const DashboardScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text("Home"),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
