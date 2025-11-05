import 'dart:async';

class ApiService {
  // Simulate network latency and return mock responses.
  static Future<Map<String, dynamic>> registerDoctor(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(seconds: 1));
    // basic duplicate-email simulation
    if (payload['email'] == 'exists@doctor.com') {
      return {'success': false, 'message': 'Email already exists'};
    }
    // return token and doctor data (mock)
    return {'success': true, 'token': 'mock_doctor_token_123', 'doctor': {'name': payload['name'], 'specialization': payload['specialization']}};
  }

  static Future<Map<String, dynamic>> loginDoctor({required String identifier, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (identifier == 'dr@test' && password == 'password') {
      return {'success': true, 'token': 'mock_login_token', 'doctor': {'name': 'Dr Test'}};
    }
    return {'success': false, 'message': 'Invalid credentials'};
  }
}
