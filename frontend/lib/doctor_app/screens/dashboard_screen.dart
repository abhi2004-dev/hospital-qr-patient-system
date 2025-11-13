import 'package:flutter/material.dart';
import 'patient_list_screen.dart';
import 'qr_scanner_screen.dart';
import 'logs_screen.dart';
import 'profile_screen.dart';
import '../widgets/dashboard_title.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Doctor Dashboard',
          style: TextStyle(color: Color(0xFF032859), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFF032859)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF032859),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DashboardTile(
                      title: 'Scan QR',
                      icon: Icons.qr_code_scanner,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const QRScannerScreen()));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardTile(
                      title: 'Add Rx',
                      icon: Icons.add_box,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientListScreen()));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardTile(
                      title: 'Logs',
                      icon: Icons.history,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const LogsScreen()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Patients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF032859),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const PatientListScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
