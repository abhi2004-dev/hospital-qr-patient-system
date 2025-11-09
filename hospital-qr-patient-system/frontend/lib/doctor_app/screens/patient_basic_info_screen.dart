import 'package:flutter/material.dart';

class PatientBasicInfoScreen extends StatelessWidget {
  final String patientId;
  const PatientBasicInfoScreen({required this.patientId, super.key});

  @override
  Widget build(BuildContext context) {
    // For now show static info; later call backend /api/patients/:id
    return Scaffold(
      backgroundColor: const Color(0xFF0077B6),
      appBar: AppBar(backgroundColor: const Color(0xFF0077B6), elevation: 0, title: const Text('Patient Info', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('John Doe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Blood Group: B+', style: TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            Text('Allergies: None', style: TextStyle(color: Colors.black54)),
          ])),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const Scaffold(body: Center(child: Text('OTP flow here'))))), child: const Text('Request Full History (OTP)'))
        ]),
      ),
    );
  }
}
