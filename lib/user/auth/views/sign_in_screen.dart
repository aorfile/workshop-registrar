import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/user/auth/components/divider.dart';
import 'package:frontend/user/auth/components/social_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final String currentDateTime = '2025-03-12 13:15:31';
  final String currentUser = 'aorfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if screen is large enough for centered layout
            bool isLargeScreen = constraints.maxWidth > 800;

            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: isLargeScreen ? 480 : double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 24,
                    vertical: 24,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 0,
                  ),
                  decoration: isLargeScreen ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ) : null,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        // Logo
                        Image.asset(
                          'assets/images/logo.webp',
                          height: 80,
                        ),
                        const SizedBox(height: 24),
                        // Welcome Message
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Current Date Time
                        Text(
                          'UTC: $currentDateTime',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Name Field (Optional)
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name (Optional)',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Email Field
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ],
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
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Or Separator
                        const OrDivider(),
                        const SizedBox(height: 24),
                        // Alternative Sign In Options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialSignInButton(
                              image: 'assets/images/google.png',
                              onPressed: () {
                                // Handle Google sign in
                              },
                            ),
                            const SizedBox(width: 16),
                            SocialSignInButton(
                              image: 'assets/images/google.png',
                              onPressed: () {
                                // Handle mobile sign in
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Sign Up Toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                // Handle navigation to sign up
                              },
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}