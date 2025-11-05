import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  const SuccessDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.check_circle, color: Color(0xFF2EB5E0), size: 64),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
