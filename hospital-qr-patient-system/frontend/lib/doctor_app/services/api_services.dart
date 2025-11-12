import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔹 Replace this IP address with your computer's IPv4 (from ipconfig)
  static const String baseUrl = "http://10.89.72.251:5000/api";

  // ---------------------- Doctor APIs ----------------------

  /// Doctor Login
  static Future<Map<String, dynamic>> doctorLogin(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/doctor/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "data": data};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ??
              'Login failed. Please check credentials.'
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }

  /// Doctor Registration (Step 1)
  static Future<Map<String, dynamic>> registerDoctorStep1(
      Map<String, dynamic> doctorData) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/doctor/register-step1"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(doctorData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {"success": true, "data": data};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ??
              'Registration step 1 failed.'
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }

  /// Doctor Registration (Step 2)
  static Future<Map<String, dynamic>> registerDoctorStep2(
      Map<String, dynamic> doctorData) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/doctor/register-step2"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(doctorData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {"success": true, "data": data};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ??
              'Registration step 2 failed.'
        };
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }

  // ---------------------- Patient APIs (optional) ----------------------

  /// Fetch all patients (for Add RX or dashboard)
  static Future<Map<String, dynamic>> getAllPatients() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/doctor/patients"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "data": data};
      } else {
        return {"success": false, "message": "Failed to fetch patients"};
      }
    } catch (e) {
      return {"success": false, "message": "Network error: $e"};
    }
  }
}
