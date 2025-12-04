// frontend/lib/doctor_app/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/doctor_model.dart';
import '../utils/app_colors.dart';
import 'qr_scanner_screen.dart';
import 'patient_list_screen.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  final String? token;
  final String? doctorId;

  const DashboardScreen({Key? key, this.token, this.doctorId}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Doctor? doctor;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();

      final id =
          prefs.getString(AuthService.keyDoctorId) ?? widget.doctorId ?? "Unknown";
      final name =
          prefs.getString(AuthService.keyDoctorName) ?? "Unknown Doctor";
      final specialization =
          prefs.getString(AuthService.keyDoctorSpecialization) ?? "General";
      final email =
          prefs.getString(AuthService.keyDoctorEmail) ?? "";

      setState(() {
        doctor = Doctor(
          id: id,
          name: name,
          specialization: specialization,
          email: email,
        );
        loading = false;
      });
    } catch (e) {
      setState(() {
        doctor = Doctor(
          id: widget.doctorId ?? "D-000",
          name: "Dr. Example",
          specialization: "General",
          email: "",
        );
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor?.name ?? "Doctor Dashboard"),
        backgroundColor: AppColors.primary,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(doctor?.name ?? ""),
                      subtitle: Text(doctor?.specialization ?? ""),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _tile("Scan QR", Icons.qr_code, () async {
                        final code = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QrScannerScreen(),
                          ),
                        );
                        if (code != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Scanned: $code")),
                          );
                        }
                      }),
                      _tile("Add Rx", Icons.note_add, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PatientListScreen(),
                          ),
                        );
                      }),
                      _tile("Logs", Icons.history, () {
                        // TODO: connect logs screen
                      }),
                      _tile("Notifications", Icons.notifications, () {
                        // TODO: connect notifications screen
                      }),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _tile(String title, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 34),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
