import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String initialValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const DropdownField({super.key, required this.initialValue, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        value: initialValue,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
