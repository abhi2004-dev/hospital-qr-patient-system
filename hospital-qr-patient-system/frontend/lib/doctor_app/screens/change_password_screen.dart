import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final current = TextEditingController();
  final newp = TextEditingController();
  final confirm = TextEditingController();

  void _save() {
    if (newp.text != confirm.text) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match'))); return; }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed (mock)')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF0077B6), appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: const Text('Change Password', style: TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        TextField(controller: current, obscureText: true, decoration: const InputDecoration(hintText:'Current password', filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
        const SizedBox(height:12),
        TextField(controller: newp, obscureText: true, decoration: const InputDecoration(hintText:'New password', filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
        const SizedBox(height:12),
        TextField(controller: confirm, obscureText: true, decoration: const InputDecoration(hintText:'Confirm password', filled:true, fillColor: Colors.white, border: OutlineInputBorder())),
        const SizedBox(height:18),
        ElevatedButton(onPressed: _save, child: const Text('Save Changes'))
      ])),
    );
  }
}
