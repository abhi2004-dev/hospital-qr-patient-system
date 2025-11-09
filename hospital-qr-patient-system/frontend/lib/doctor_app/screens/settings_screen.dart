import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'notifications_screen.dart';
import 'logout_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('Settings', style: TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        ListTile(leading: const Icon(Icons.edit), title: const Text('Edit Profile'), tileColor: Colors.white, onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const EditProfileScreen()))),
        const SizedBox(height:10),
        ListTile(leading: const Icon(Icons.lock), title: const Text('Change Password'), tileColor: Colors.white, onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChangePasswordScreen()))),
        const SizedBox(height:10),
        ListTile(leading: const Icon(Icons.notifications), title: const Text('Notifications'), tileColor: Colors.white, onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const NotificationsScreen()))),
        const SizedBox(height:10),
        ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), tileColor: Colors.white, onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const LogoutScreen()))),
      ])),
    );
  }
}
