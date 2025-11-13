import 'package:flutter/material.dart';
import 'doctor_login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6)),
      body: Center(child: Container(padding: const EdgeInsets.all(20), margin: const EdgeInsets.symmetric(horizontal:28), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.logout, size:70, color: Colors.redAccent),
        const SizedBox(height:12),
        const Text('Are you sure you want to log out?', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height:18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          OutlinedButton(onPressed: ()=>Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const DoctorLoginScreen()), (r)=>false), child: const Text('Logout'))
        ])
      ]))),
    );
  }
}
