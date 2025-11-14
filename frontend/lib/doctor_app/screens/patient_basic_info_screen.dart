// frontend/lib/doctor_app/screens/patient_basic_info_screen.dart
import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class PatientBasicInfoScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final String doctorId;
  const PatientBasicInfoScreen({Key? key, required this.data, this.doctorId = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = data;
    return Scaffold(
      appBar: AppBar(title: Text(p['name'] ?? 'Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Name: ${p['name'] ?? '-'}', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Age: ${p['age'] ?? '-'}'),
          Text('Gender: ${p['gender'] ?? '-'}'),
          Text('Blood Group: ${p['bloodGroup'] ?? '-'}'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () async {
            if (doctorId.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Doctor id missing')));
              return;
            }
            final res = await ApiService.requestOtp(p['_id'] ?? p['id'], doctorId);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['body']?['message'] ?? res['message'] ?? 'OTP request failed')));
          }, child: const Text('Request Full History (OTP)')),
        ]),
      ),
    );
  }
}
