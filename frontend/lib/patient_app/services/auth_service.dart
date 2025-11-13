import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Replace with your backend IP
  static const String base = "http://192.168.122.251:5000";

  // ============================
  // REGISTER PATIENT
  // ============================
  static Future<Map<String, dynamic>> registerPatient({
    required String name,
    required String dob,
    required String email,
    required String phone,
    required String address,
    required String uniqueID,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/auth/patient/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "dob": dob,
          "email": email,
          "phone": phone,
          "address": address,
          "uniqueID": uniqueID,
          "password": password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Patient Register Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // ============================
  // LOGIN PATIENT
  // ============================
  static Future<Map<String, dynamic>> loginPatient({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/auth/patient/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Patient Login Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // ============================
  // UPDATE PROFILE
  // ============================
  static Future<Map<String, dynamic>> updateProfile({
    required String patientID,
    required String name,
    required String dob,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$base/api/patient/update/$patientID'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "dob": dob,
          "email": email,
          "phone": phone,
          "address": address,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Patient Update Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // ============================
  // FETCH PATIENT DATA
  // ============================
  static Future<Map<String, dynamic>> getPatient(String patientID) async {
    try {
      final response = await http.get(
        Uri.parse('$base/api/patient/$patientID'),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Fetch Patient Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }
}
