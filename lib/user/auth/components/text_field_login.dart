import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const FormTextField({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}
