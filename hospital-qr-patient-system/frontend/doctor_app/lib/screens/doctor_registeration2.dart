import 'package:flutter/material.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../../services/api_service.dart';
import '../../services/local_storage.dart';
import '../screens/shared/success_dialog.dart';

class DoctorRegisterPage2 extends StatefulWidget {
  final Map<String, dynamic> page1Data;
  const DoctorRegisterPage2({super.key, required this.page1Data});
  @override
  State<DoctorRegisterPage2> createState() => _DoctorRegisterPage2State();
}

class _DoctorRegisterPage2State extends State<DoctorRegisterPage2> {
  final _license = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool loading = false;

  @override
  void dispose() { _license.dispose(); _password.dispose(); _confirm.dispose(); super.dispose(); }

  Future<void> _register() async {
    final pwd = _password.text;
    if (pwd.length < 6) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be >= 6 chars'))); return; }
    if (pwd != _confirm.text) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match'))); return; }
    final payload = {...widget.page1Data, 'licenseId': _license.text.trim(), 'password': pwd};

    setState(() => loading = true);
    final res = await ApiService.registerDoctor(payload);
    setState(() => loading = false);

    if (res['success'] == true) {
      await LocalStorage.saveToken(res['token'] ?? '');
      await LocalStorage.saveRole('doctor');
      showDialog(context: context, builder: (_) => const SuccessDialog(message: 'Registration successful'));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? 'Registration failed')));
    }
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
              const Text('DOCTOR REGISTRATION', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF032859))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF7FA3FF).withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Text('Enter credentials', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _license, hintText: 'License/ Registration'),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _password, hintText: 'Enter password', obscureText: true),
                  const SizedBox(height: 10),
                  CustomInputField(controller: _confirm, hintText: 'Confirm password', obscureText: true),
                  const SizedBox(height: 14),
                  CustomButton(text: loading ? 'Registering...' : 'Register', onPressed: loading ? null : _register),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
