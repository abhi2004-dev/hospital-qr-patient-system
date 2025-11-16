// doctor_model.dart
class Doctor {
  final String id;
  final String name;
  final String email;
  final String specialization;

  Doctor({required this.id, required this.name, required this.email, required this.specialization});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }
}
