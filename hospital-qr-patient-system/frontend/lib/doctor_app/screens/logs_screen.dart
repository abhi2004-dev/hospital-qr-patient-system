import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {
        "patient": "John Doe (P-1023)",
        "action": "Added Prescription",
        "time": DateTime.now().subtract(const Duration(hours: 1)),
        "color": Colors.greenAccent,
        "icon": Icons.medical_services_outlined
      },
      {
        "patient": "Sarah Lee (P-1098)",
        "action": "Viewed Full History",
        "time": DateTime.now().subtract(const Duration(hours: 3)),
        "color": Colors.blueAccent,
        "icon": Icons.history
      },
      {
        "patient": "David Kumar (P-1121)",
        "action": "Requested OTP Access",
        "time": DateTime.now().subtract(const Duration(days: 1)),
        "color": Colors.orangeAccent,
        "icon": Icons.lock_open_rounded
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Activity Logs',
          style: TextStyle(
            color: Color(0xFF032859),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: (log['color'] as Color).withOpacity(0.2),
                child: Icon(log['icon'] as IconData, color: log['color'] as Color),
              ),
              title: Text(
                log['action'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF032859)),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(log['patient'] as String),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM d, yyyy hh:mm a').format(log['time'] as DateTime),
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
