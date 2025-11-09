import 'package:flutter/material.dart';

class OTPRequestScreen extends StatelessWidget {
  const OTPRequestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('OTP Verification', style: TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        const Text('Enter OTP sent to patient', style: TextStyle(color: Colors.white)),
        const SizedBox(height: 12),
        TextField(decoration: const InputDecoration(hintText: 'OTP', filled:true, fillColor: Colors.white)),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: ()=>Navigator.pop(context), child: const Text('Verify'))
      ])));
  }
}
