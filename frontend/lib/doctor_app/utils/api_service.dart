// frontend/lib/doctor_app/utils/api_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiService {
  static const String base = baseUrl;

  static Map<String, String> _headers([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  static Map<String, dynamic> _decodeResponse(http.Response r) {
    try {
      final body = r.body.isNotEmpty ? jsonDecode(r.body) : {};
      return {
        'success': r.statusCode >= 200 && r.statusCode < 300,
        'status': r.statusCode,
        'body': body,
      };
    } catch (e) {
      return {'success': false, 'message': 'Invalid response'};
    }
  }

  // register
  static Future<Map<String, dynamic>> registerDoctor(String name, String email, String password, String specialization) async {
    try {
      final r = await http.post(Uri.parse('$base/api/auth/doctor/register'),
        headers: _headers(),
        body: jsonEncode({'name': name, 'email': email, 'password': password, 'specialization': specialization}),
      );
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  // login
  static Future<Map<String, dynamic>> loginDoctor(String email, String password) async {
    try {
      final r = await http.post(Uri.parse('$base/api/auth/doctor/login'),
        headers: _headers(),
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  // add prescription
  static Future<Map<String, dynamic>> addPrescription(String token, Map<String, dynamic> payload) async {
    try {
      final r = await http.post(Uri.parse('$base/api/prescription/add'),
        headers: _headers(token),
        body: jsonEncode(payload),
      );
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  // patient summary
  static Future<Map<String, dynamic>> getPatientSummary(String id, [String? token]) async {
    try {
      final r = await http.get(Uri.parse('$base/api/patient/$id/summary'), headers: _headers(token));
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  // fetch QR PNG
  static Future<Uint8List?> fetchPatientQrPng(String patientId) async {
    try {
      final r = await http.get(Uri.parse('$base/api/qr/patient/$patientId'));
      if (r.statusCode != 200) return null;
      return r.bodyBytes;
    } catch (e) {
      return null;
    }
  }

  // OTP
  static Future<Map<String, dynamic>> requestOtp(String patientId, String doctorId) async {
    try {
      final r = await http.post(Uri.parse('$base/api/otp/request'),
        headers: _headers(),
        body: jsonEncode({'patientId': patientId, 'doctorId': doctorId}),
      );
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String patientId, String doctorId, String code) async {
    try {
      final r = await http.post(Uri.parse('$base/api/otp/verify'),
        headers: _headers(),
        body: jsonEncode({'patientId': patientId, 'doctorId': doctorId, 'code': code}),
      );
      return _decodeResponse(r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }
}
