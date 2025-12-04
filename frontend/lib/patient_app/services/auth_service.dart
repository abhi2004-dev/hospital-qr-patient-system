import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // ⚠️ Make sure this matches your CURRENT backend IP
  // Example for WiFi device: "http://192.168.x.x:5000"
  // Example for emulator: "http://10.0.2.2:5000"
  static const String base = "http://192.168.252.251:5000";

  // =====================================================
  // SAVE USER LOGIN DATA LOCALLY  (TOKEN + USER DETAILS)
  // =====================================================
  static Future<void> saveLoginData({
    required String token,
    required Map<String, dynamic> user,
    required String role, // 'patient' or 'doctor'
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("role", role);
    await prefs.setString("user", jsonEncode(user));
    await prefs.setBool("loggedIn", true);
  }

  // Helper specifically for patient keys used by UI
  static Future<void> _savePatientFields(
    Map<String, dynamic> user, {
    String? fallbackName,
    String? fallbackPhone,
    String? fallbackEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final String id = (user["_id"] ??
            user["id"] ??
            user["patientId"] ??
            "")
        .toString();

    final String name = (user["name"] ?? fallbackName ?? "").toString();
    final String phone = (user["phone"] ?? fallbackPhone ?? "").toString();
    final String email = (user["email"] ?? fallbackEmail ?? "").toString();
    final String qrId = (user["qrId"] ?? "").toString();

    await prefs.setString("patientId", id);
    await prefs.setString("patientName", name);
    await prefs.setString("patientPhone", phone);
    await prefs.setString("patientEmail", email);
    if (qrId.isNotEmpty) {
      await prefs.setString("patientQrId", qrId);
    }
  }

  // =====================================================
  // CHECK IF USER IS LOGGED IN
  // =====================================================
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loggedIn") ?? false;
  }

  // =====================================================
  // GET SAVED USER DATA (generic JSON)
  // =====================================================
  static Future<Map<String, dynamic>?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString("user");
    if (user == null) return null;
    return jsonDecode(user);
  }

  // =====================================================
  // LOGOUT (CLEAR DATA)
  // =====================================================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // =====================================================
  // REGISTER PATIENT (field-by-field)
  // =====================================================
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

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        // handle both shapes:
        // { success, token, user }
        // OR { success, body: { token, patient } }
        final body = data["body"] ?? {};
        final user = data["user"] ??
            body["patient"] ??
            body["user"] ??
            <String, dynamic>{};

        final String token =
            (data["token"] ?? body["token"] ?? "").toString();

        if (token.isNotEmpty) {
          await saveLoginData(
            token: token,
            user: user,
            role: "patient",
          );
        }

        await _savePatientFields(
          user,
          fallbackName: name,
          fallbackPhone: phone,
          fallbackEmail: email,
        );
      }

      return data;
    } catch (e) {
      print("❌ Patient Register Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // =====================================================
  // REGISTER PATIENT (FULL PAYLOAD VERSION)
  // You can send a ready Map instead of individual fields.
  // =====================================================
  static Future<Map<String, dynamic>> registerPatientFull(
      Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse('$base/api/auth/patient/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        final body = data["body"] ?? {};
        final user = data["user"] ??
            body["patient"] ??
            body["user"] ??
            <String, dynamic>{};

        final String token =
            (data["token"] ?? body["token"] ?? "").toString();

        if (token.isNotEmpty) {
          await saveLoginData(
            token: token,
            user: user,
            role: "patient",
          );
        }

        await _savePatientFields(user);
      }

      return data;
    } catch (e) {
      print("❌ Patient Register Error (full): $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // =====================================================
  // LOGIN PATIENT
  // =====================================================
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

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        final body = data["body"] ?? {};
        final user = data["user"] ??
            body["patient"] ??
            body["user"] ??
            <String, dynamic>{};

        final String token =
            (data["token"] ?? body["token"] ?? "").toString();

        if (token.isNotEmpty) {
          await saveLoginData(
            token: token,
            user: user,
            role: "patient",
          );
        }

        await _savePatientFields(
          user,
          fallbackEmail: email,
        );
      }

      return data;
    } catch (e) {
      print("❌ Patient Login Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // =====================================================
  // UPDATE PATIENT PROFILE
  // =====================================================
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

      final data = jsonDecode(response.body);

      // If backend returns updated patient, refresh local cache
      if (data["success"] == true) {
        final body = data["body"] ?? {};
        final user = data["patient"] ??
            data["user"] ??
            body["patient"] ??
            body["user"] ??
            <String, dynamic>{};

        await _savePatientFields(
          user,
          fallbackName: name,
          fallbackPhone: phone,
          fallbackEmail: email,
        );
      }

      return data;
    } catch (e) {
      print("❌ Patient Update Error: $e");
      return {"success": false, "message": "Network error"};
    }
  }

  // =====================================================
  // FETCH PATIENT DATA
  // =====================================================
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
