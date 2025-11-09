import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final doctor = {"name":"Dr. Ananya Rao","hospital":"Apollo Hospital, Bangalore","id":"D_1004","special":"Cardiology","phone":"+91 9876543210","email":"ananya.rao@apollo.com"};
    return Scaffold(backgroundColor: const Color(0xFF0077B6),
      appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('Doctor Profile', style: TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)), child: Row(children: [
          const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
          const SizedBox(width:12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(doctor['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text(doctor['hospital']!, style: const TextStyle(fontSize: 14, color: Colors.black87)), Text('User ID: ${doctor['id']}', style: const TextStyle(color: Colors.black54))]))
        ])),
        const SizedBox(height:20),
        ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const EditProfileScreen())), child: const Text('Edit Profile')),
        const SizedBox(height:8),
        ElevatedButton(onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const DashboardScreen()), (r)=>false), style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: const Text('Home'))
      ])),
    );
  }
}
