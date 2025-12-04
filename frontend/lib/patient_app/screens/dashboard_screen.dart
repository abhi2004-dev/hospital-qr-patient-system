import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// SCREEN IMPORTS
import 'qr_screen.dart';
import 'prescription_screen.dart';
import 'medical_records_screen.dart';
import 'emergency_info_screen.dart';
import 'help_screen.dart';
import 'settings_screen.dart';

const String _baseUrl = "http://192.168.252.251:5000";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _patientName = "Patient";
  String _patientId = "";
  String _patientQrId = "";

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadPatientFromBackend();
  }

  Future<void> _loadPatientFromBackend() async {
    setState(() => _loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();

      // try to read saved id; if empty, fall back to your test id
      String id = prefs.getString("patient_id") ?? "";
      if (id.isEmpty) {
        id = "693060d28905ddd769c44b36"; // temp: your test patient id
      }

      final uri = Uri.parse("$_baseUrl/api/patient/$id");
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["success"] == true) {
          final p = data["patient"] ?? {};
          setState(() {
            _patientName = (p["name"] ?? "Patient").toString();
            _patientId = (p["_id"] ?? "").toString();
            _patientQrId = (p["qrId"] ?? "").toString();
          });

          // also keep in prefs for other screens
          await prefs.setString("patient_id", _patientId);
          await prefs.setString("patient_name", _patientName);
          await prefs.setString("patient_qrId", _patientQrId);
          await prefs.setString("patient_phone", (p["phone"] ?? "").toString());
        }
      }
    } catch (e) {
      // optional: show snackbar
      debugPrint("Dashboard load error: $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF9BD6DC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------------
              // HEADER
              // ----------------------------------------------------
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF7388F6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          _patientName,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA6B8FC),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ----------------------------------------------------
              // QUICK ACTIONS TITLE
              // ----------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Quick actions",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ----------------------------------------------------
              // QUICK ACTIONS BOX
              // ----------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A6DC8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickAction(
                        Icons.qr_code,
                        "My QR",
                        onTap: () {
                          if (_patientId.isEmpty && _patientQrId.isEmpty) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QRScreen(
                                patientID: _patientQrId.isNotEmpty
                                    ? _patientQrId
                                    : _patientId,
                                patientName: _patientName,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildQuickAction(
                        Icons.receipt_long,
                        "Prescription",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrescriptionScreen()),
                          );
                        },
                      ),
                      _buildQuickAction(
                        Icons.folder_open,
                        "Records",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MedicalRecordsScreen()),
                          );
                        },
                      ),
                      _buildQuickAction(
                        Icons.emergency,
                        "Emergency",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EmergencyInfoScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ----------------------------------------------------
              // RECENT VISITS (still dummy for now)
              // ----------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Recent Visits",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              _buildVisitCard("Dr. Doctor 1 name", "Hospital name - date"),
              _buildVisitCard("Dr. Doctor 2 name", "Hospital name - date"),
              _buildVisitCard("Dr. Doctor 3 name", "Hospital name - date"),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // ----------------------------------------------------
      // BOTTOM NAVIGATION
      // ----------------------------------------------------
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF7388F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.home_outlined,
                  color: Colors.black, size: 28),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
              child: const Icon(Icons.settings_outlined,
                  color: Colors.black, size: 28),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              },
              child: const Icon(Icons.help_outline,
                  color: Colors.black, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------
  // QUICK ACTION BUTTON WIDGET
  // ----------------------------------------------------------------
  Widget _buildQuickAction(IconData icon, String label,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------
  // RECENT VISITS CARD
  // ----------------------------------------------------------------
  Widget _buildVisitCard(String doctor, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFA6D9FB),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFBFC7F8),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.black54,
                size: 28,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
