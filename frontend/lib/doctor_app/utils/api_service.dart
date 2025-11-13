import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ Replace this IP with your laptop's IP address (run `ipconfig` or `ifconfig`)
  static const base = "http://192.168.1.105:5000"; // Example: change to your real IP

  // 🩺 Doctor Login
  static Future<Map<String, dynamic>?> loginDoctor(String email, String pass) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/auth/doctor/login'),
        body: jsonEncode({"email": email, "password": pass}),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(r.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Login Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // 🧑‍⚕️ Doctor Register
  static Future<Map<String, dynamic>?> registerDoctor(
      String name, String email, String password) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/auth/doctor/register'),
        body: jsonEncode({"name": name, "email": email, "password": password}),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(r.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Register Network Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // 🩺 Get Doctor Details
  static Future<Map<String, dynamic>?> getDoctorDetails(String token) async {
    try {
      final r = await http.get(
        Uri.parse('$base/api/doctor/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return jsonDecode(r.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Fetch Doctor Details Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }
  
  // 💊 Add Prescription (ADDED METHOD)
  static Future<Map<String, dynamic>?> addPrescription(
      String patientId,
      String doctorId,
      List<Map<String, String>> medications, // Expects the list of meds
      String notes) async {
    try {
      final r = await http.post(
        // Assuming the server endpoint for adding prescriptions is this:
        Uri.parse('$base/api/prescription/add'), 
        body: jsonEncode({
          "patientId": patientId,
          "doctorId": doctorId,
          "medications": medications,
          "notes": notes,
        }),
        headers: {
          'Content-Type': 'application/json',
          // NOTE: If this endpoint requires a token for authorization, 
          // you'll need to pass and include the token here.
        },
      );
      // Check for a non-200 status code before decoding if your API returns errors
      if (r.statusCode != 200) {
        print("❌ Add Prescription API Status: ${r.statusCode}");
      }
      return jsonDecode(r.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Add Prescription Network Error: $e");
      return {"success": false, "message": "Network error or API endpoint issue"};
    }
  }

  // 📋 Add Patient
  static Future<Map<String, dynamic>?> addPatient(
      String token, Map<String, dynamic> data) async {
    try {
      final r = await http.post(
        Uri.parse('$base/api/patient/add'),
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return jsonDecode(r.body) as Map<String, dynamic>;
    } catch (e) {
      print("❌ Add Patient Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }
}