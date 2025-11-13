import 'package:flutter/material.dart';
import 'patient_basic_info_screen.dart';
import 'add_rx_screen.dart';
import '../widgets/patient_card.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final searchCtrl = TextEditingController();

  List<Map<String, dynamic>> patients = [
    {"name": "John Doe", "id": "P-1023", "age": 30, "blood": "B+", "lastVisit": "5 Nov"},
    {"name": "Sarah Lee", "id": "P-1098", "age": 27, "blood": "O-", "lastVisit": "1 Nov"},
    {"name": "David Kumar", "id": "P-1121", "age": 45, "blood": "A+", "lastVisit": "2 Nov"},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = patients.where((p) => p['name'].toLowerCase().contains(searchCtrl.text.toLowerCase())).toList();

    return Column(
      children: [
        TextField(
          controller: searchCtrl,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search patient by name',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (ctx, i) {
              final p = filtered[i];
              return PatientCard(
                name: p['name'],
                id: p['id'],
                age: p['age'],
                bloodGroup: p['blood'],
                lastVisit: p['lastVisit'],
                onView: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PatientBasicInfoScreen(patientId: p['id'])));
                },
                onAddRx: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddPrescriptionScreen(
                        patientId: p['id'],
                        patientName: p['name'],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
