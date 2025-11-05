import 'package:flutter/material.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';
import '../screens/doctor_registeration1.dart';
import '../../services/api_service.dart';
import '../../services/local_storage.dart';
import '../screens/shared/success_dialog.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});
  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final _idCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool loading = false;

  Future<void> _login() async {
    setState(() => loading = true);
    final res = await ApiService.loginDoctor(identifier: _idCtrl.text.trim(), password: _passCtrl.text);
    setState(() => loading = false);
    if (res['success'] == true) {
      await LocalStorage.saveToken(res['token']);
      await LocalStorage.saveRole('doctor');
      showDialog(context: context, builder: (_) => const SuccessDialog(message: 'Login successful'));
      // Navigate to dashboard later. For now pop dialog then stay.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? 'Login failed')));
    }
  }

  @override
  void dispose() { _idCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFF2EB5E0)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(children: [
              Align(alignment: Alignment.centerLeft, child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
              Image.asset('assets/logo.png', height: 96),
              const SizedBox(height: 6),
              const Text('Health meets Technology..', style: TextStyle(fontSize: 14, color: Color(0xFF032859))),
              const SizedBox(height: 16),
              const Text('DOCTOR LOGIN', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF032859))),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: const Color(0xFF7FA3FF).withOpacity(0.4), borderRadius: BorderRadius.circular(18)),
                child: Column(children: [
                  const Text('Enter doctor credentials', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  CustomInputField(controller: _idCtrl, hintText: 'doctor_id, email or mobile number'),
                  const SizedBox(height: 12),
                  CustomInputField(controller: _passCtrl, hintText: 'password', obscureText: true),
                  const SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    CustomButton(text: 'Login', onPressed: loading ? null : _login),
                    CustomButton(text: 'Register', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorRegisterPage1()))),
                  ]),
                  const SizedBox(height: 8),
                  TextButton(onPressed: () {}, child: const Text('forgot password?', style: TextStyle(color: Colors.black87))),
                ]),
              ),
              const SizedBox(height: 16),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorRegisterPage1())), child: const Text("Don't have an account? Register", style: TextStyle(decoration: TextDecoration.underline))),
            ]),
          ),
        ),
      ),
    );
  }
}
