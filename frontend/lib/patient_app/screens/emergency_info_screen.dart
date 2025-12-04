import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String _baseUrl = "http://192.168.252.251:5000";

class EmergencyInfoScreen extends StatefulWidget {
  const EmergencyInfoScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyInfoScreen> createState() => _EmergencyInfoScreenState();
}

class _EmergencyInfoScreenState extends State<EmergencyInfoScreen> {
  bool _loading = false;

  String guardianName = "Not Provided";
  String emergencyPhone = "Not Provided";
  String relation = "Not Provided";

  @override
  void initState() {
    super.initState();
    _loadEmergencyInfo();
  }

  Future<void> _loadEmergencyInfo() async {
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
            guardianName = (p["guardianName"] ?? "Not Provided").toString();
            emergencyPhone =
                (p["guardianContact"] ?? "Not Provided").toString();
            relation = (p["guardianRelation"] ?? "Not Provided").toString();
          });
        }
      }
    } catch (e) {
      debugPrint("Emergency info load error: $e");
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
              "EMERGENCY INFORMATION",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0B0B5A),
              ),
            ),

            const SizedBox(height: 25),

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
                        _buildItem("Guardian Name", guardianName),
                        const SizedBox(height: 10),
                        _buildItem("Contact Number", emergencyPhone),
                        const SizedBox(height: 10),
                        _buildItem("Relation", relation),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
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
