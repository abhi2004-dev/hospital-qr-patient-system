import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'qr_scanner_screen.dart';
import 'add_rx_screen.dart';
import 'patient_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String? token;
  final String? doctorId;

  const DashboardScreen({super.key, this.token, this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('Doctor Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text("Scan QR"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QrScannerScreen()),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Patient List"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PatientListScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
