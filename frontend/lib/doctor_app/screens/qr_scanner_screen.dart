import 'package:flutter/material.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077B6),
      appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('QR Scanner', style: TextStyle(color: Colors.white))),
      body: Center(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Text('Scanner placeholder'))),
    );
  }
}
