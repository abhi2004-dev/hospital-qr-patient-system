// frontend/lib/doctor_app/screens/add_rx_screen.dart
import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class AddRxScreen extends StatefulWidget {
  final String patientId;
  final String token; // doctor's token

  const AddRxScreen({Key? key, required this.patientId, required this.token}) : super(key: key);

  @override
  State<AddRxScreen> createState() => _AddRxScreenState();
}

class _AddRxScreenState extends State<AddRxScreen> {
  final _form = GlobalKey<FormState>();
  final _diagnosisCtl = TextEditingController();
  final _medicineCtl = TextEditingController();
  final _notesCtl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    _diagnosisCtl.dispose();
    _medicineCtl.dispose();
    _notesCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => loading = true);

    final payload = {
      'patientId': widget.patientId,
      'diagnosis': _diagnosisCtl.text.trim(),
      'medicines': [
        // very simple: single string; expand to list-of-objects UI later
        {'name': _medicineCtl.text.trim(), 'dosage': '', 'schedule': ''}
      ],
      'notes': _notesCtl.text.trim(),
      'chronic': false,
    };

    final res = await ApiService.addPrescription(widget.token, payload);

    setState(() => loading = false);

    if (res['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Prescription added')));
      Navigator.pop(context, true);
    } else {
      final msg = res['body']?['message'] ?? res['message'] ?? 'Failed to add';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Prescription')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _diagnosisCtl,
                decoration: const InputDecoration(labelText: 'Diagnosis'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter diagnosis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _medicineCtl,
                decoration: const InputDecoration(labelText: 'Medicine (name, dosage)'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter medicine' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesCtl,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
