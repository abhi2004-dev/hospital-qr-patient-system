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

  final List<Map<String, dynamic>> patients = [
    {
      "name": "John Doe",
      "id": "P-1023",
      "age": 30,
      "bloodGroup": "B+",
      "lastVisit": "5 Nov"
    },
    {
      "name": "Sarah Lee",
      "id": "P-1098",
      "age": 27,
      "bloodGroup": "O-",
      "lastVisit": "1 Nov"
    },
    {
      "name": "David Kumar",
      "id": "P-1121",
      "age": 45,
      "bloodGroup": "A+",
      "lastVisit": "2 Nov"
    },
  ];

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchCtrl.text.trim().toLowerCase();
    final filtered = patients.where(
      (p) => p['name'].toLowerCase().contains(query),
    ).toList();

    return Column(
      children: [
        // Search Box
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchCtrl,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search patient by name',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // List of Patients
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final p = filtered[i];

              return PatientCard(
                name: p['name'],
                id: p['id'],
                age: p['age'],                   // 😊 correct
                bloodGroup: p['bloodGroup'],     // 😊 correct
                lastVisit: p['lastVisit'],
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PatientBasicInfoScreen(
                        data: p,
                        doctorId: '',
                      ),
                    ),
                  );
                },
                onAddRx: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddRxScreen(
                        patientId: p['id'],
                        token: '',
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
