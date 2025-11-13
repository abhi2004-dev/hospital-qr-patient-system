import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// SCREEN IMPORTS
import 'qr_screen.dart';
import 'prescription_screen.dart';
import 'medical_records_screen.dart';
import 'emergency_info_screen.dart';
import 'help_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
                          "Patient name",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QRScreen(
                                patientID: "PAT123456",
                                patientName: "Patient name",
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

              // ----------------------------------------------------
              // RECENT VISITS
              // ----------------------------------------------------
              const SizedBox(height: 25),

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
            // HOME
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.home_outlined,
                  color: Colors.black, size: 28),
            ),

            // SETTINGS
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

            // HELP
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
