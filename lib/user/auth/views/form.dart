import 'package:flutter/material.dart';
import 'package:frontend/user/auth/components/auth_responsive.dart';

import 'package:frontend/user/auth/components/text_field_login.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final String currentDateTime = '2025-03-12 13:15:31';
  final String currentUser = 'aorfile';

  @override
  Widget build(BuildContext context) {
    return AuthResponsive(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            // Logo
            Image.asset('assets/images/logo.webp', height: 80),
            const SizedBox(height: 24),
            // Welcome Message
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const SizedBox(height: 40),
            // Name Field
            FormTextField(label: 'Full name', icon: Icons.person_outline),
            const SizedBox(height: 16),
            // Email Field
            FormTextField(label: 'Email', icon: Icons.email_outlined),
            const SizedBox(height: 16),
            // Phone Field
            FormTextField(label: 'Phone number', icon: Icons.phone_outlined),
            const SizedBox(height: 16),
            // Department Field
            FormTextField(label: 'Department', icon: Icons.work_outline),
            const SizedBox(height: 16),
            // Role Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items:
                  ['student', 'admin', 'presenter'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {},
            ),
            const SizedBox(height: 24),
            // Sign In Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle sign in
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Register', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),

            // Or Separator
          ],
        ),
      ),
    );
  }
}
