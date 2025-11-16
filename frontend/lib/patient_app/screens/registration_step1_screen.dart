import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'registration_step2_screen.dart';

class PatientRegistrationStep1 extends StatefulWidget {
  const PatientRegistrationStep1({super.key});

  @override
  State<PatientRegistrationStep1> createState() =>
      _PatientRegistrationStep1State();
}

class _PatientRegistrationStep1State extends State<PatientRegistrationStep1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController insuranceCtrl = TextEditingController();
  final TextEditingController guardianNameCtrl = TextEditingController();
  final TextEditingController guardianPhoneCtrl = TextEditingController();
  final TextEditingController relationCtrl = TextEditingController();
  final TextEditingController medsCtrl = TextEditingController();
  final TextEditingController surgeriesCtrl = TextEditingController();

  String? selectedBloodGroup;
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  // simple allergies list you can expand
  final List<String> allergiesPool = [
    'Pollen',
    'Dust',
    'Penicillin',
    'Peanuts',
    'Seafood',
    'Latex',
    'None'
  ];
  List<String> selectedAllergies = [];

  @override
  void dispose() {
    nameCtrl.dispose();
    dobCtrl.dispose();
    phoneCtrl.dispose();
    insuranceCtrl.dispose();
    guardianNameCtrl.dispose();
    guardianPhoneCtrl.dispose();
    relationCtrl.dispose();
    medsCtrl.dispose();
    surgeriesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initial = DateTime(now.year - 25, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      dobCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    if (selectedBloodGroup == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select blood group")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep2Screen(
          name: nameCtrl.text.trim(),
          dob: dobCtrl.text.trim(),
          phone: phoneCtrl.text.trim(),
          bloodGroup: selectedBloodGroup!,
          allergies: selectedAllergies,
          currentMeds: medsCtrl.text.trim(),
          pastSurgeries: surgeriesCtrl.text.trim(),
          insuranceProvider: insuranceCtrl.text.trim(),
          guardianName: guardianNameCtrl.text.trim(),
          guardianPhone: guardianPhoneCtrl.text.trim(),
          guardianRelation: relationCtrl.text.trim(),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint,
      {TextInputType keyboard = TextInputType.text, String? Function(String?)? validator}) {
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
      backgroundColor: const Color(0xFFEFFBF8),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Image.asset('assets/logo.png', height: 84),
              const SizedBox(height: 8),
              const Text("Patient Registration", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              _input(nameCtrl, "Full Name", validator: (v) {
                if (v == null || v.trim().isEmpty) return "Name required";
                return null;
              }),
              const SizedBox(height: 12),

              // DOB (date picker)
              TextFormField(
                controller: dobCtrl,
                readOnly: true,
                onTap: _pickDob,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return "Date of birth required";
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Date of birth",
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: const Icon(Icons.calendar_today),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              _input(phoneCtrl, "Phone (10 digits)", keyboard: TextInputType.phone, validator: (v) {
                if (v == null || v.trim().isEmpty) return "Phone required";
                if (!RegExp(r"^[0-9]{10}$").hasMatch(v)) return "Enter 10 digit phone";
                return null;
              }),
              const SizedBox(height: 12),

              // Blood group dropdown
              const Align(alignment: Alignment.centerLeft, child: Text("Blood Group", style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("Select blood group"),
                    value: selectedBloodGroup,
                    items: bloodGroups.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (v) => setState(() => selectedBloodGroup = v),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Allergies - selectable chips from pool
              const Align(alignment: Alignment.centerLeft, child: Text("Allergies (tap to select)", style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allergiesPool.map((a) {
                  final selected = selectedAllergies.contains(a);
                  return FilterChip(
                    label: Text(a),
                    selected: selected,
                    onSelected: (s) {
                      setState(() {
                        if (s) {
                          if (!selectedAllergies.contains(a)) selectedAllergies.add(a);
                        } else {
                          selectedAllergies.remove(a);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              _input(medsCtrl, "Current medications (comma separated)", validator: (v) => null),
              const SizedBox(height: 12),

              _input(surgeriesCtrl, "Past surgeries (brief)", validator: (v) => null),
              const SizedBox(height: 12),

              _input(insuranceCtrl, "Insurance provider (optional)", validator: (v) => null),
              const SizedBox(height: 12),

              const SizedBox(height: 6),
              const Align(alignment: Alignment.centerLeft, child: Text("Emergency contact", style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              _input(guardianNameCtrl, "Guardian name", validator: (v) {
                if (v == null || v.trim().isEmpty) return "Guardian required";
                return null;
              }),
              const SizedBox(height: 8),
              _input(guardianPhoneCtrl, "Guardian phone (10 digits)", keyboard: TextInputType.phone, validator: (v) {
                if (v == null || v.trim().isEmpty) return "Guardian phone required";
                if (!RegExp(r"^[0-9]{10}$").hasMatch(v)) return "Enter 10 digit phone";
                return null;
              }),
              const SizedBox(height: 8),
              _input(relationCtrl, "Relation with emergency contact", validator: (v) {
                if (v == null || v.trim().isEmpty) return "Relation required";
                return null;
              }),
              const SizedBox(height: 18),

              ElevatedButton(onPressed: _next, style: ElevatedButton.styleFrom(backgroundColor: Colors.black87), child: const Text("Continue")),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}
