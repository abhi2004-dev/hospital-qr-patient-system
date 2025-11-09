import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const base = "http://10.0.2.2:5000"; // Android emulator -> host machine
  // If testing on real device, replace with your machine IP e.g. http://192.168.1.10:5000

  static Future<Map<String,dynamic>?> loginDoctor(String email, String pass) async {
    try {
      final r = await http.post(Uri.parse('$base/auth/doctor/login'.replaceFirst('/auth','/api/auth')), body: jsonEncode({"email":email,"password":pass}), headers: {'Content-Type':'application/json'});
      return jsonDecode(r.body) as Map<String,dynamic>;
    } catch (e) { return {"success":false,"message":"Network error"}; }
  }

  static Future<Map<String,dynamic>?> registerDoctor(String name, String email, String password) async {
    try {
      final r = await http.post(Uri.parse('$base/api/auth/doctor/register'), body: jsonEncode({"name":name,"email":email,"password":password}), headers: {'Content-Type':'application/json'});
      return jsonDecode(r.body) as Map<String,dynamic>;
    } catch (e) { return {"success":false,"message":"Network error"}; }
  }

  static Future<Map<String,dynamic>?> addPrescription(String patientId, String doctorId, List medicines, String notes) async {
    try {
      final r = await http.post(Uri.parse('$base/api/prescriptions/add'), body: jsonEncode({"patientId":patientId,"doctorId":doctorId,"medicines":medicines,"notes":notes}), headers: {'Content-Type':'application/json'});
      return jsonDecode(r.body) as Map<String,dynamic>;
    } catch (e) { return {"success":false,"message":"Network error"}; }
  }
}
