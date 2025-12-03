import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://10.211.180.251:5000";

  // Doctor login
  static Future<Map<String, dynamic>> doctorLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/doctor/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": "Network Error"};
    }
  }
}
