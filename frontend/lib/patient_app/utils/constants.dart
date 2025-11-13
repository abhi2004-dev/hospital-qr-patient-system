import 'package:flutter/material.dart';

/// ---------------------------
/// APP BASICS
/// ---------------------------

// App Name
const String appName = "Hospital QR Patient System";

/// ---------------------------
/// BACKEND BASE URL
/// ---------------------------
/// IMPORTANT: Replace with your own IPv4 address if needed
const String baseUrl = "http://192.168.122.251:5000";

/// ---------------------------
/// STORAGE KEYS
/// ---------------------------
/// Used with SharedPreferences to store login session
const String patientTokenKey = "patient_token";
const String patientIdKey = "patient_id";

/// ---------------------------
/// APP COLORS (Patient Theme)
/// ---------------------------
class AppColors {
  static const Color primary = Color(0xFF1A82B2);
  static const Color secondary = Color(0xFF157BAA);
  static const Color darkBlue = Color(0xFF004E7C);
  static const Color lightBlue = Color(0xFFA6D9FB);
  static const Color background = Color(0xFF9BD6DC);
}
