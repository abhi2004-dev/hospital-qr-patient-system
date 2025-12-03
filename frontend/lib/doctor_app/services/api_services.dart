// frontend/lib/doctor_app/services/api_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor_model.dart';

/// Backend base URL with /api
const String baseUrl = "http://10.211.180.251:5000/api";

class ApiService {
  // -------------------------
  // Auth
  // -------------------------
  static Future<Map<String, dynamic>?> doctorLogin(
      String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/doctor/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      // Expecting { success, token, doctor } or { success:false, message }
      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      print("ApiService.doctorLogin error: $e");
      return {
        "success": false,
        "message": "Network error",
      };
    }
  }

  static Future<Map<String, dynamic>> doctorRegister({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? hospitalName,
    String? specialization,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/doctor/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
          "hospitalName": hospitalName,
          "specialization": specialization,
        }),
      );

      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      print("ApiService.doctorRegister error: $e");
      return {
        "success": false,
        "message": "Network error",
      };
    }
  }

  // -------------------------
  // Profile
  // -------------------------
  static Future<Doctor?> getDoctorProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null || token.isEmpty) return null;

      final res = await http.get(
        Uri.parse("$baseUrl/doctor/me"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final doctorJson = body['doctor'] as Map<String, dynamic>;
        return Doctor.fromJson(doctorJson);
      }
      return null;
    } catch (e) {
      print("ApiService.getDoctorProfile error: $e");
      return null;
    }
  }
}
