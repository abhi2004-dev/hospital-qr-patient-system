import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String id;
  final int? age;
  final String? bloodGroup;
  final String lastVisit;

  final VoidCallback onView;
  final VoidCallback onAddRx;

  const PatientCard({
    super.key,
    required this.name,
    required this.id,
    required this.lastVisit,
    required this.onView,
    required this.onAddRx,
    this.age,
    this.bloodGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black12,
            child: Icon(Icons.person, color: Colors.black),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("ID: $id", style: const TextStyle(fontSize: 13)),
                if (age != null)
                  Text("Age: $age", style: const TextStyle(fontSize: 13)),
                if (bloodGroup != null)
                  Text("Blood: $bloodGroup",
                      style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 4),
                Text("Last Visit: $lastVisit",
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),

          Column(
            children: [
              ElevatedButton(
                onPressed: onView,
                child: const Text("View"),
              ),
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: onAddRx,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text("Add Rx"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
