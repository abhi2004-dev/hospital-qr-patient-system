import 'dart:convert';
import 'package:http/http.dart' as http;

class Medicine {
  final String name;
  final String dose;
  final String duration;

  Medicine({
    required this.name,
    required this.dose,
    required this.duration,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'] ?? '',
      dose: json['dose'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}

class Prescription {
  final List<Medicine> medicines;
  final String notes;
  final DateTime createdAt;

  Prescription({
    required this.medicines,
    required this.notes,
    required this.createdAt,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    final medsJson = json['medicines'] as List<dynamic>? ?? [];
    return Prescription(
      medicines: medsJson.map((m) => Medicine.fromJson(m)).toList(),
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class PatientPrescriptionService {
  // SAME BASE URL YOU USED IN DOCTOR PrescriptionService
  static const String baseUrl = 'http://10.0.2.2:5000';

  static Future<Prescription?> getLatestPrescription(String patientId) async {
    final url =
        Uri.parse('$baseUrl/api/prescriptions/latest/$patientId');

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final presJson = data['prescription']; // from controller
        return Prescription.fromJson(presJson);
      } else {
        print('getLatestPrescription failed: ${res.statusCode} ${res.body}');
        return null;
      }
    } catch (e) {
      print('getLatestPrescription error: $e');
      return null;
    }
  }
}
