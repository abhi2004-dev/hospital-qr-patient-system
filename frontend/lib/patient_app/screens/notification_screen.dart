import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 5),

                // Title
                Text(
                  "Notifications",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // BOX 1 - Tick icon
                _notificationTile(
                  icon: Icons.check_circle_outline,
                ),

                const SizedBox(height: 20),

                // BOX 2 - Bell icon
                _notificationTile(
                  icon: Icons.notifications_none,
                ),

                const SizedBox(height: 20),

                // BOX 3 - Medical note icon
                _notificationTile(
                  icon: Icons.description,
                ),

                const SizedBox(height: 20),

                // BOX 4 - Download icon
                _notificationTile(
                  icon: Icons.download,
                ),

                const SizedBox(height: 20),

                // Last empty box
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Notification Tile Widget ----------
  Widget _notificationTile({required IconData icon}) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
