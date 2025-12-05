import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String _baseUrl = "http://10.12.94.251:5000";

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({Key? key}) : super(key: key);

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  bool _loading = false;

  List allergies = [];
  String currentMeds = "Not Provided";
  String pastSurgeries = "Not Provided";
  List prescriptions = [];

  @override
  void initState() {
    super.initState();
    _loadMedicalRecords();
  }

  Future<void> _loadMedicalRecords() async {
    setState(() => _loading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      String patientId = prefs.getString("patient_id") ?? "";

      if (patientId.isEmpty) patientId = "693060d28905ddd769c44b36";

      final uri = Uri.parse("$_baseUrl/api/patient/$patientId");
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data["success"] == true) {
          final p = data["patient"] ?? {};

          setState(() {
            allergies = p["allergies"] ?? [];
            currentMeds = p["currentMeds"] ?? "Not Provided";
            pastSurgeries = p["pastSurgeries"] ?? "Not Provided";
            prescriptions = p["prescriptions"] ?? [];
          });
        }
      }
    } catch (e) {
      debugPrint("Medical records load error: $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BD6DC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text(
              "MEDICAL RECORDS",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0B0B5A),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF7388F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection("Allergies", allergies.isEmpty ? "None" : allergies.join(", ")),
                        const SizedBox(height: 15),

                        _buildSection("Current Medication", currentMeds),
                        const SizedBox(height: 15),

                        _buildSection("Past Surgeries", pastSurgeries),
                        const SizedBox(height: 15),

                        _buildSection("Prescriptions",
                            prescriptions.isEmpty ? "No prescriptions yet" : prescriptions.join(", ")),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFB5CFE9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
