import 'package:flutter/material.dart';
import '../utils/specializations.dart';
import 'doctor_register_step2.dart';

class DoctorRegisterStep1 extends StatefulWidget {
  const DoctorRegisterStep1({super.key});

  @override
  State<DoctorRegisterStep1> createState() => _DoctorRegisterStep1State();
}

class _DoctorRegisterStep1State extends State<DoctorRegisterStep1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController hospitalCtrl = TextEditingController();
  final TextEditingController userIdCtrl = TextEditingController();

  List<String> selectedSpecializations = [];

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    hospitalCtrl.dispose();
    userIdCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    if (selectedSpecializations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select at least one specialization")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorRegisterScreen2(
          fullName: nameCtrl.text.trim(),
          email: emailCtrl.text.trim(),
          phone: phoneCtrl.text.trim(),
          hospitalName: hospitalCtrl.text.trim(),
          specialization: selectedSpecializations.join(", "),
          userId: userIdCtrl.text.trim(),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, {TextInputType keyboard = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: c,
      keyboardType: keyboard,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBEEFF3),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: BackButton(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Image.asset('assets/logo.png', height: 90),
              const SizedBox(height: 10),
              const Text("Doctor Registration", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              _input(nameCtrl, "Full name", validator: (v) {
                if (v == null || v.trim().isEmpty) return "Name required";
                if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(v)) return "Invalid name";
                if (v.trim().length < 3) return "Too short";
                return null;
              }),
              const SizedBox(height: 12),

              _input(emailCtrl, "Email", keyboard: TextInputType.emailAddress, validator: (v) {
                if (v == null || v.trim().isEmpty) return "Email required";
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(v)) return "Invalid email";
                return null;
              }),
              const SizedBox(height: 12),

              _input(phoneCtrl, "Phone (10 digits)", keyboard: TextInputType.phone, validator: (v) {
                if (v == null || v.trim().isEmpty) return "Phone required";
                if (!RegExp(r"^[0-9]{10}$").hasMatch(v)) return "Enter 10 digit phone";
                return null;
              }),
              const SizedBox(height: 12),

              _input(hospitalCtrl, "Hospital/Clinic", validator: (v) {
                if (v == null || v.trim().isEmpty) return "Hospital required";
                if (v.trim().length < 3) return "Too short";
                return null;
              }),
              const SizedBox(height: 12),

              // Specialization chips + dropdown
              const Align(alignment: Alignment.centerLeft, child: Text("Specialization", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              if (selectedSpecializations.isNotEmpty)
                Wrap(spacing: 8, runSpacing: 8, children: selectedSpecializations.map((spec) {
                  return Chip(label: Text(spec), onDeleted: () => setState(() => selectedSpecializations.remove(spec)));
                }).toList()),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select specialization"),
                    value: null,
                    items: SpecializationsList.list.map((spec) => DropdownMenuItem(value: spec, child: Text(spec))).toList(),
                    onChanged: (value) {
                      if (value != null && !selectedSpecializations.contains(value)) setState(() => selectedSpecializations.add(value));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _input(userIdCtrl, "User ID", validator: (v) {
                if (v == null || v.trim().isEmpty) return "User ID required";
                if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(v)) return "Only letters & numbers allowed";
                if (v.trim().length < 4) return "At least 4 characters";
                return null;
              }),
              const SizedBox(height: 20),

              ElevatedButton(onPressed: _next, style: ElevatedButton.styleFrom(backgroundColor: Colors.black87), child: const Text("Next")),
              const SizedBox(height: 18),
            ]),
          ),
        ),
      ),
    );
  }
}
