import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/themes/theme_toggle_button.dart';
import 'package:frontend/user/auth/components/auth_responsive.dart';
import 'package:frontend/user/auth/components/text_field_login.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _verificationController = TextEditingController();
  bool _isLoading = false;

  // Timer for resend functionality
  int _timeLeft = 60;
  bool _canResend = false;

  @override
  void dispose() {
    _verificationController.dispose();
    super.dispose();
  }

  void _handleVerification() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // TODO: Implement verification logic
        final code = _verificationController.text;
        print('Verifying code: $code');

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // On success, navigate to next screen
        if (mounted) {
          // Navigate to next screen
          // Navigator.pushReplacement(...)
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

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

            // Verify Phone Message
            const Text(
              'Phone Verification',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enter the verification code sent to your phone',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Verification Code Field
            FormTextField(
              label: 'Verification Code',
              icon: Icons.lock_outline,
              controller: _verificationController,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the verification code';
                }
                if (value.length != 6) {
                  return 'Verification code must be 6 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleVerification,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : const Text('Verify', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),

            // Resend Code Button
            TextButton(
              onPressed:
                  _canResend
                      ? () {
                        // TODO: Implement resend logic
                        setState(() {
                          _canResend = false;
                          _timeLeft = 60;
                        });
                      }
                      : null,
              child: Text(
                _canResend
                    ? 'Resend Code'
                    : 'Resend Code in $_timeLeft seconds',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
