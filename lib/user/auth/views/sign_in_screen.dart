import 'package:flutter/material.dart';
import 'package:frontend/user/auth/components/divider.dart';
import 'package:frontend/user/auth/components/social_sign_in.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        await Future.delayed(const Duration(seconds: 2));
        context.go('/home');
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed: ${e.toString()}')),
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
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 800;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Admin toggle button
                    Container(
                      width: isLargeScreen ? 480 : double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 40 : 24,
                        vertical: 8,
                      ),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.admin_panel_settings,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            'Switch to Admin Login',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () async {
                              await Future.delayed(const Duration(seconds: 2));
                              context.go('/admin/login');
                            },
                          ),
                        ),
                      ),
                    ),
                    // Main container with the form
                    Container(
                      width: isLargeScreen ? 480 : double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 40 : 24,
                        vertical: 24,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 40 : 0,
                      ),
                      decoration:
                          isLargeScreen
                              ? BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).shadowColor.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              )
                              : null,
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
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Current Date Time
                            Text(
                              'Buddy,welcome to workshop universe',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value!)) {
                                  return 'Please enter a valid email';
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
                                  controller: _passwordController,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed:
                                          () => setState(
                                            () => _isObscure = !_isObscure,
                                          ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged:
                                          (value) => setState(
                                            () => _rememberMe = value ?? false,
                                          ),
                                    ),
                                    const Text('Remember me'),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        // Navigate to password reset
                                      },
                                      child: const Text('Forgot Password?'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Sign In Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSignIn,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : const Text(
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
                                  onPressed: () async {
                                    // Handle Google sign in
                                  },
                                ),
                                const SizedBox(width: 16),
                                SocialSignInButton(
                                  image: 'assets/images/phone-icon.png',
                                  onPressed: () async {
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );
                                    context.go('/phone');
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
                                  onPressed: () async {
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                    );
                                    context.go('/signup');
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
