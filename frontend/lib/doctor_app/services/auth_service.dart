// frontend/lib/doctor_app/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // SharedPreferences keys – used across app
  static const String keyToken = 'doctor_token';
  static const String keyDoctorId = 'doctor_id';
  static const String keyDoctorName = 'doctor_name';
  static const String keyDoctorEmail = 'doctor_email';
  static const String keyDoctorSpecialization = 'doctor_specialization';
  static const String keyRole = 'loggedInRole';

  /// Save DOCTOR login session
  static Future<void> saveDoctorSession({
    required String token,
    required String id,
    required String name,
    required String email,
    required String specialization,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, token);
    await prefs.setString(keyDoctorId, id);
    await prefs.setString(keyDoctorName, name);
    await prefs.setString(keyDoctorEmail, email);
    await prefs.setString(keyDoctorSpecialization, specialization);
    await prefs.setString(keyRole, 'doctor');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  static Future<String?> getDoctorId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyDoctorId);
  }

  static Future<String?> getDoctorName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyDoctorName);
  }

  static Future<String?> getDoctorEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyDoctorEmail);
  }

  static Future<String?> getDoctorSpecialization() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyDoctorSpecialization);
  }

  static Future<bool> isDoctorLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(keyToken);
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
    await prefs.remove(keyDoctorId);
    await prefs.remove(keyDoctorName);
    await prefs.remove(keyDoctorEmail);
    await prefs.remove(keyDoctorSpecialization);

    if (prefs.getString(keyRole) == 'doctor') {
      await prefs.remove(keyRole);
    }
  }
}
