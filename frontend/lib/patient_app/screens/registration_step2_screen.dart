import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'registration_step3_screen.dart';

class RegistrationStep2Screen extends StatefulWidget {
  final String email;
  final String password;
  final dynamic photo;

  const RegistrationStep2Screen({
    Key? key,
    required this.email,
    required this.password,
    required this.photo,
  }) : super(key: key);

  @override
  State<RegistrationStep2Screen> createState() =>
      _RegistrationStep2ScreenState();
}

class _RegistrationStep2ScreenState extends State<RegistrationStep2Screen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  String? gender;
  String? bloodGroup;

  final List<String> bloodGroups = [
    "A+","A-","B+","B-","O+","O-","AB+","AB-"
  ];

  Future<void> pickDOB() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      dobCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  void nextPage() {
    if (nameCtrl.text.trim().isEmpty ||
        dobCtrl.text.trim().isEmpty ||
        phoneCtrl.text.trim().isEmpty ||
        gender == null ||
        bloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep3Screen(
          email: widget.email,
          password: widget.password,
          photo: widget.photo,

          name: nameCtrl.text.trim(),
          dob: dobCtrl.text.trim(),
          phone: phoneCtrl.text.trim(),
          gender: gender!,
          bloodGroup: bloodGroup!,
        ),
      ),
    );
  }

  Widget field(String label, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        input,
        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration deco(String h) => InputDecoration(
        hintText: h,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF9BD6DC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/logo.png', width: 110, height: 110),

            const SizedBox(height: 10),
            Text("Health meets Technology..",

                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400)),

            const SizedBox(height: 16),
            Text("PATIENT REGISTRATION",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0B0B5A))),

            const SizedBox(height: 15),
            Text("Enter Personal Info",
                style: GoogleFonts.fredoka(
                    fontSize: 18, fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            Container(
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                color: const Color(0xFF7388F6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  // Full Name
                  field(
                      "Full Name",
                      TextField(
                        controller: nameCtrl,
                        decoration: deco("Enter full name"),
                      )),

                  // DOB Picker
                  field(
                      "Date of Birth",
                      TextField(
                        controller: dobCtrl,
                        readOnly: true,
                        onTap: pickDOB,
                        decoration: deco("Select DOB").copyWith(
                            suffixIcon:
                                const Icon(Icons.calendar_today)),
                      )),

                  // Phone
                  field(
                      "Phone Number",
                      TextField(
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: deco("10-digit phone"),
                      )),

                  // Gender
                  field(
                      "Gender",
                      Row(
                        children: [
                          Radio(
                              value: "Male",
                              groupValue: gender,
                              activeColor: Colors.black,
                              onChanged: (v) => setState(() => gender = v)),
                          const Text("Male"),
                          const SizedBox(width: 20),
                          Radio(
                              value: "Female",
                              groupValue: gender,
                              activeColor: Colors.black,
                              onChanged: (v) => setState(() => gender = v)),
                          const Text("Female"),
                        ],
                      )),

                  // Blood Group
                  field(
                      "Blood Group",
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: bloodGroup,
                            hint: const Text("Select blood group"),
                            isExpanded: true,
                            items: bloodGroups
                                .map((bg) => DropdownMenuItem(
                                    value: bg, child: Text(bg)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => bloodGroup = v),
                          ),
                        ),
                      )),

                  const SizedBox(height: 10),

                  ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F2F2F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10)),
                      child: const Text("Next",
                          style:
                              TextStyle(fontSize: 15, color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
