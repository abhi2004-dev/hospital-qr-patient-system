import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  final String patientID;       // <-- Unique ID passed from Dashboard
  final String patientName;     // <-- To display under QR

  const QRScreen({
    Key? key,
    required this.patientID,
    required this.patientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A82B2),
              Color(0xFF157BAA),
              Color(0xFF1174A2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Back arrow
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 20),

            // QR Code Box
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFA6D9FB),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(15),
              child: QrImageView(
                data: patientID,        // REAL QR generated from patient ID
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Patient Name
            Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFB5CFE9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  patientName,    // <-- Display real patient name
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Patient ID Box
            Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFB5CFE9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  patientID, // <-- Display real ID
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Download QR Button
            ElevatedButton(
              onPressed: () {
                // TODO: implement download
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004E7C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
              ),
              child: Text(
                "Download QR",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD8E7F4),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Share QR Button
            ElevatedButton(
              onPressed: () {
                // TODO: implement share
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004E7C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 85, vertical: 12),
              ),
              child: Text(
                "Share QR",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD8E7F4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
