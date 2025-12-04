// frontend/lib/doctor_app/services/api_services.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constants.dart'; // contains baseUrl

class ApiServices {

  /// ============================
  /// DOCTOR LOGIN
  /// ============================
  static Future<Map<String, dynamic>> doctorLogin(
      String email, String password) async {
    try {
      final uri = Uri.parse("$baseUrl/api/auth/doctor/login");

      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (res.statusCode != 200) {
        return {"success": false, "message": "Invalid credentials"};
      }

      final data = jsonDecode(res.body);

      // Normalize data so UI always receives:
      // {success:true, token:"", doctor:{}}
      final body = data["body"] ?? data;

      return {
        "success": body["success"] ?? data["success"],
        "token": body["token"],
        "doctor": body["doctor"],
      };

    } catch (e) {
      return {"success": false, "message": "Network Error"};
    }
  }

  /// ============================
  /// DOCTOR REGISTRATION
  /// ============================
  static Future<Map<String, dynamic>> doctorRegister(
      Map<String, dynamic> payload) async {
    try {
      final uri = Uri.parse("$baseUrl/api/auth/doctor/register");

      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (res.statusCode != 200) {
        return {"success": false, "message": "Registration failed"};
      }

      return jsonDecode(res.body);
    } catch (e) {
      return {"success": false, "message": "Network Error"};
    }
  }
}
