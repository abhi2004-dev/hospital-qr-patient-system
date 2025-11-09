import 'package:flutter/material.dart';

class PatientFullRecordScreen extends StatelessWidget {
  const PatientFullRecordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('Full Record', style: TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: SingleChildScrollView(child: Column(children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Text('Full patient medical history will appear here...')),
      ]))));
  }
}
