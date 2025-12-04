// frontend/lib/doctor_app/utils/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart'; // baseUrl

class ApiService {
  /// Request OTP so doctor can view full patient history
  /// Adjust path to match otpRoutes.js if needed.
  static Future<Map<String, dynamic>> requestOtp(
      String patientId, String doctorId) async {
    try {
      final uri = Uri.parse("$baseUrl/api/otp/request");

      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "patientId": patientId,
          "doctorId": doctorId,
        }),
      );

      return jsonDecode(res.body);
    } catch (e) {
      return {
        "success": false,
        "message": "Network Error while requesting OTP",
      };
    }
  }

  /// Add prescription for a patient
  /// Adjust path to match prescriptionRoutes.js if needed.
  static Future<Map<String, dynamic>> addPrescription(
      String token, Map<String, dynamic> payload) async {
    try {
      final uri = Uri.parse("$baseUrl/api/prescriptions");

      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload),
      );

      return jsonDecode(res.body);
    } catch (e) {
      return {
        "success": false,
        "message": "Network Error while adding prescription",
      };
    }
  }
}
