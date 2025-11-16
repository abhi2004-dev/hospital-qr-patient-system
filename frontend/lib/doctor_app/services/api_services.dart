// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor_model.dart';

/// IMPORTANT: replace this with your laptop IP (not localhost)
const String baseUrl = "http://192.168.1.7:5000/api";

class ApiService {
  // -------------------------
  // Auth
  // -------------------------
  static Future<Map<String, dynamic>?> doctorLogin(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/doctor/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (res.statusCode == 200) return jsonDecode(res.body) as Map<String, dynamic>;
      return null;
    } catch (e) {
      print("ApiService.doctorLogin error: $e");
      return null;
    }
  }

  static Future<bool> doctorRegister(Map<String, dynamic> payload) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/doctor/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );
      return res.statusCode == 201 || res.statusCode == 200;
    } catch (e) {
      print("ApiService.doctorRegister error: $e");
      return false;
    }
  }

  // -------------------------
  // Profile / Dashboard
  // -------------------------
  static Future<Doctor?> getDoctorProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) return null;

      final res = await http.get(
        Uri.parse("$baseUrl/doctor/me"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        return Doctor.fromJson(body['doctor']);
      }
      return null;
    } catch (e) {
      print("ApiService.getDoctorProfile error: $e");
      return null;
    }
  }

  // Other API calls (patients, prescriptions) will follow the same pattern.
}
