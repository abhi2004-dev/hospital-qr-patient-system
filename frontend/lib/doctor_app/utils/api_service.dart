// frontend/lib/doctor_app/utils/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart'; // same folder import - ensure relative path correct

class ApiService {
  // Use centralized baseUrl from constants.dart (no trailing /api)
  static const String base = baseUrl;

  // -------------------------
  // Auth - Doctor
  // -------------------------
  static Future<Map<String, dynamic>?> registerDoctor(
      String name, String email, String password, String specialization) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/auth/doctor/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "specialization": specialization,
        }),
      );
      return _decodeResponse(r);
    } catch (e) {
      print("❌ Register Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  static Future<Map<String, dynamic>?> loginDoctor(
      String email, String password) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/auth/doctor/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      return _decodeResponse(r);
    } catch (e) {
      print("❌ Login Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // -------------------------
  // Doctor profile
  // -------------------------
  static Future<Map<String, dynamic>?> getDoctorProfile(String token) async {
    try {
      final r = await http.get(
        Uri.parse('$base/api/doctor/profile'),
        headers: _authHeaders(token),
      );
      return _decodeResponse(r);
    } catch (e) {
      print("❌ Fetch Doctor Profile Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // -------------------------
  // Patients
  // -------------------------
  static Future<Map<String, dynamic>?> addPatient(
      String token, Map<String, dynamic> patientData) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/patient/add'),
        headers: _authHeaders(token),
        body: jsonEncode(patientData),
      );
      return _decodeResponse(r);
    } catch (e) {
      print("❌ Add Patient Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // -------------------------
  // Prescriptions (example)
  // Make sure backend has this route before using
  // -------------------------
  static Future<Map<String, dynamic>?> addPrescription(
      String token,
      String patientId,
      List<Map<String, dynamic>> medications,
      String notes) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/prescription/add'),
        headers: _authHeaders(token),
        body: jsonEncode({
          "patientId": patientId,
          "medications": medications,
          "notes": notes,
        }),
      );
      return _decodeResponse(r);
    } catch (e) {
      print("❌ Add Prescription Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // -------------------------
  // Helpers
  // -------------------------
  static Map<String, String> _authHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Map<String, dynamic> _decodeResponse(http.Response r) {
    try {
      final body = r.body.isNotEmpty ? jsonDecode(r.body) : {};
      // If backend returns non-200 (error), include status code in return for debugging
      if (r.statusCode < 200 || r.statusCode >= 300) {
        print("⚠️ API returned status ${r.statusCode} with body: ${r.body}");
        // ensure a consistent map response
        return {
          "success": false,
          "statusCode": r.statusCode,
          "body": body,
        };
      }
      return body as Map<String, dynamic>;
    } catch (e) {
      print("❌ Response decode error: $e");
      return {"success": false, "message": "Invalid response format"};
    }
  }
}
