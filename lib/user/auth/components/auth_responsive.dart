// Current Date and Time (UTC): 2025-03-14 13:54:12
// Current User's Login: aorfile

import 'package:flutter/material.dart';
import 'package:frontend/user/auth/components/divider.dart';
import 'package:frontend/user/auth/components/social_sign_in.dart';

class AuthResponsive extends StatefulWidget {
  final Widget child;
  const AuthResponsive({super.key, required this.child});

  @override
  _AuthResponsiveState createState() => _AuthResponsiveState();
}

class _AuthResponsiveState extends State<AuthResponsive> {
  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Get colors from theme
    final backgroundColor =
        isDarkMode
            ? Theme.of(context)
                .colorScheme
                .surface // neutral800 in dark mode
            : Colors.white; // white in light mode
    final shadowColor =
        isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey[100]!;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
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
                  decoration:
                      isLargeScreen
                          ? BoxDecoration(
                            color:
                                backgroundColor, // Theme-aware background color
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor, // Theme-aware shadow color
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          )
                          : null,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
