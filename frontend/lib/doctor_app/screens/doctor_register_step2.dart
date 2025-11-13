import 'dart:io';
import 'package:flutter/material.dart';
import 'doctor_login_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/api_service.dart';

class DoctorRegisterStep2 extends StatefulWidget {
  final String name;
  final String email;
  const DoctorRegisterStep2({required this.name, required this.email, super.key});
  @override
  State<DoctorRegisterStep2> createState() => _DoctorRegisterStep2State();
}

class _DoctorRegisterStep2State extends State<DoctorRegisterStep2> {
  final TextEditingController licenseCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;

  Future<void> _pickImage() async {
    final XFile? f = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (f != null) setState(() => _photo = File(f.path));
  }

 void _register() async {
  if (passCtrl.text != confirmCtrl.text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Passwords do not match')));
    return;
  }

  if (licenseCtrl.text.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Enter specialization / license')));
    return;
  }

  setState(() => loading = true);

  final res = await ApiService.registerDoctor(
    widget.name,
    widget.email,
    passCtrl.text,
    licenseCtrl.text, // specialization
  );

  setState(() => loading = false);

  if (res != null && res['success'] == true) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DoctorLoginScreen()),
      (r) => false,
    );
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res?['message'] ?? 'Register failed')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFBEEFF3), appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.black), onPressed: () => Navigator.pop(context))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(18), child: Column(children: [
        Image.asset('assets/logo.png', height: 80),
        const SizedBox(height: 8), Text('Register: ${widget.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(controller: licenseCtrl, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(), hintText: 'License / Registration')),
        const SizedBox(height: 12),
        TextField(controller: passCtrl, obscureText: true, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(), hintText: 'Password')),
        const SizedBox(height: 12),
        TextField(controller: confirmCtrl, obscureText: true, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(), hintText: 'Confirm Password')),
        const SizedBox(height: 12),
        GestureDetector(onTap: _pickImage, child: Container(height: 56, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children: [ if (_photo!=null) Image.file(_photo!, width: 48, height: 48, fit: BoxFit.cover) else const Icon(Icons.add_a_photo), const SizedBox(width: 12), Expanded(child: Text(_photo==null ? 'Upload photo' : 'Photo selected')) ]))),
        const SizedBox(height: 18),
        ElevatedButton(onPressed: loading ? null : _register, style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14)), child: loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register')),
      ])),
    );
  }
}
