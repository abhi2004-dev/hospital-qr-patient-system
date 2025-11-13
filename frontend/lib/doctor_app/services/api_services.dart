import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🌍 Replace with your laptop IP
  static const String base = "http://192.168.122.251:5000";

  // 🧑‍⚕️ Register Doctor
  static Future<Map<String, dynamic>?> registerDoctor(
      String name, String email, String password, String specialization) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/auth/doctor/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "specialization": specialization,
        }),
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Register Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // 🔐 Login Doctor
  static Future<Map<String, dynamic>?> loginDoctor(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/auth/doctor/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Login Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // 📋 Add Patient
  static Future<Map<String, dynamic>?> addPatient(
      String token, Map<String, dynamic> patientData) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/patient/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(patientData),
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Add Patient Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // 🩺 Get Doctor Profile
  static Future<Map<String, dynamic>?> getDoctorProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$base/api/doctor/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Fetch Doctor Profile Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }
}
