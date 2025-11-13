import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameCtrl = TextEditingController(text: "Dr. Ananya Rao");
  final TextEditingController emailCtrl = TextEditingController(text: "ananya.rao@apollo.com");
  final TextEditingController phoneCtrl = TextEditingController(text: "+91 9876543210");
  final TextEditingController hospitalCtrl = TextEditingController(text: "Apollo Hospital, Bangalore");

  Future<void> _pick() async {
    final XFile? f = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (f != null) setState(()=>_photo = File(f.path));
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved (local only)')));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6)), body: SingleChildScrollView(padding: const EdgeInsets.all(18), child: Column(children: [
      Stack(children:[
        CircleAvatar(radius: 60, backgroundColor: Colors.white, backgroundImage: _photo!=null?FileImage(_photo!):null, child: _photo==null?const Icon(Icons.person,size:60):null),
        Positioned(bottom:0,right:0, child: GestureDetector(onTap: _pick, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.edit))))
      ]),
      const SizedBox(height: 20),
      TextField(controller: nameCtrl, decoration: const InputDecoration(filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
      const SizedBox(height:10),
      TextField(controller: emailCtrl, decoration: const InputDecoration(filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
      const SizedBox(height:10),
      TextField(controller: phoneCtrl, decoration: const InputDecoration(filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
      const SizedBox(height:10),
      TextField(controller: hospitalCtrl, decoration: const InputDecoration(filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
      const SizedBox(height:18),
      ElevatedButton(onPressed: _save, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: const Text('Save'))
    ])));
  }
}
