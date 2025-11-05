import 'package:flutter/material.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../screens/doctor_registeration2.dart';
import '../../widgets/dropdown_field.dart';

class DoctorRegisterPage1 extends StatefulWidget {
  const DoctorRegisterPage1({super.key});
  @override
  State<DoctorRegisterPage1> createState() => _DoctorRegisterPage1State();
}

class _DoctorRegisterPage1State extends State<DoctorRegisterPage1> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _hospital = TextEditingController();
  final _uniqueId = TextEditingController();
  String specialization = 'Cardiology';

  @override
  void dispose() {
    _name.dispose(); _email.dispose(); _phone.dispose(); _hospital.dispose(); _uniqueId.dispose();
    super.dispose();
  }

  void _next() {
    // simple validation
    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill name and email')));
      return;
    }
    final data = {
      'name': _name.text.trim(),
      'email': _email.text.trim(),
      'phone': _phone.text.trim(),
      'hospitalName': _hospital.text.trim(),
      'specialization': specialization,
      'uniqueId': _uniqueId.text.trim(),
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorRegisterPage2(page1Data: data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFF2EB5E0)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(children: [
              Align(alignment: Alignment.centerLeft, child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
              Image.asset('assets/logo.png', height: 80),
              const SizedBox(height: 6),
              const Text('Health meets Technology..', style: TextStyle(fontSize: 14, color: Color(0xFF032859))),
              const SizedBox(height: 10),
              const Text('DOCTOR REGISTRATION', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF032859))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF7FA3FF).withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Text('Enter personal info', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _name, hintText: 'Full name'),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _email, hintText: 'Email'),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _phone, hintText: 'Phone Number', keyboardType: TextInputType.phone),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _hospital, hintText: 'Hospital name'),
                  const SizedBox(height: 10),
                  DropdownField(
                    initialValue: specialization,
                    items: const ['Cardiology','Orthopedics','Pediatrics','Neurology','Gynecology','ENT','Dermatology','General Medicine'],
                    onChanged: (v) => setState(() => specialization = v ?? specialization),
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _uniqueId, hintText: 'Unique user id (optional)'),
                  const SizedBox(height: 14),
                  CustomButton(text: 'Next Page', onPressed: _next),
                  const SizedBox(height: 8),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Login'))
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
