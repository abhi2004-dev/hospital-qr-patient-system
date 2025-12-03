// frontend/lib/doctor_app/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Keys for SharedPreferences
  static const String _keyToken = 'token'; // used by ApiService.getDoctorProfile
  static const String _keyDoctorId = 'doctorId';
  static const String _keyDoctorName = 'doctorName';
  static const String _keyDoctorEmail = 'doctorEmail';
  static const String _keyUserRole = 'loggedInRole';

  /// New: Save full doctor session after login
  static Future<void> saveDoctorSession({
    required String token,
    required String id,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyDoctorId, id);
    await prefs.setString(_keyDoctorName, name);
    await prefs.setString(_keyDoctorEmail, email);
    await prefs.setString(_keyUserRole, 'doctor');
  }

  /// Backwards compatibility for existing calls
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<void> saveDoctorName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDoctorName, name);
  }

  static Future<String?> getDoctorName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDoctorName);
  }

  static Future<String?> getDoctorId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDoctorId);
  }

  static Future<String?> getDoctorEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDoctorEmail);
  }

  static Future<bool> isDoctorLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_keyToken);
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyDoctorId);
    await prefs.remove(_keyDoctorName);
    await prefs.remove(_keyDoctorEmail);

    // clear global role if it was doctor
    final role = prefs.getString(_keyUserRole);
    if (role == 'doctor') {
      await prefs.remove(_keyUserRole);
    }
  }
}
