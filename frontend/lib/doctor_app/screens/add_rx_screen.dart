import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String patientId;
  final String? patientName;
  const AddPrescriptionScreen({required this.patientId, this.patientName, super.key});
  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final TextEditingController medsCtrl = TextEditingController();
  final TextEditingController notesCtrl = TextEditingController();
  bool loading = false;

  void _save() async {
    setState(()=>loading=true);
    final res = await ApiService.addPrescription(widget.patientId, "doctorIdPlaceholder", [
      {"name": medsCtrl.text.trim(), "dose":"", "duration":""}
    ], notesCtrl.text.trim());
    setState(()=>loading=false);
    if (res!=null && res['success']==true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Prescription saved')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res?['message'] ?? 'Error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077B6),
      appBar: AppBar(backgroundColor: const Color(0xFF0077B6), title: Text('Add Prescription for ${widget.patientName ?? ''}', style: const TextStyle(color: Colors.white))),
      body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        TextField(controller: medsCtrl, decoration: const InputDecoration(hintText: 'Medicine(s) - comma separated', filled:true, fillColor: Colors.white)),
        const SizedBox(height: 12),
        TextField(controller: notesCtrl, maxLines: 4, decoration: const InputDecoration(hintText: 'Notes', filled:true, fillColor: Colors.white)),
        const SizedBox(height: 18),
        ElevatedButton(onPressed: loading?null:_save, child: loading?const CircularProgressIndicator():const Text('Save'))
      ])),
    );
  }
}
