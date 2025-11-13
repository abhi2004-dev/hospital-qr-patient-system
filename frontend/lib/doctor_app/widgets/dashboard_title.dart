import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const DashboardTile({required this.title, required this.icon, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, size: 36, color: Colors.black87), const SizedBox(height:8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))])));
  }
}
