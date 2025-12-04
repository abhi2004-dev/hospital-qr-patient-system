import 'dart:convert';
import 'package:http/http.dart' as http;

/// One medicine entry
class MedicineDto {
  final String name;
  final String dose;
  final String duration;

  MedicineDto({
    required this.name,
    required this.dose,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'dose': dose,
        'duration': duration,
      };
}

class PrescriptionService {
  // IMPORTANT: change this to match how you run backend
  // If using Android emulator and backend on same laptop:
  static const String baseUrl = 'http://10.0.2.2:5000';

  // If using real device over WiFi:
  // static const String baseUrl = 'http://YOUR_LAPTOP_IP:5000';

  /// Calls POST /api/prescriptions/add
  static Future<bool> addPrescriptionForPatient({
    required String patientId,
    required String doctorId,
    required List<MedicineDto> medicines,
    required String notes,
  }) async {
    final url = Uri.parse('$baseUrl/api/prescriptions/add');

    final body = {
      'patientId': patientId,
      'doctorId': doctorId,
      'medicines': medicines.map((m) => m.toJson()).toList(),
      'notes': notes,
    };

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // your controller returns { success:true, prescription: {...} }
        final data = jsonDecode(res.body);
        return data['success'] == true;
      } else {
        print('addPrescription failed: ${res.statusCode} ${res.body}');
        return false;
      }
    } catch (e) {
      print('addPrescription error: $e');
      return false;
    }
  }
}
