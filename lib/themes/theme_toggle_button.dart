// Current Date and Time (UTC): 2025-03-14 14:09:06
// Current User's Login: aorfile

import 'package:flutter/material.dart';
import 'package:frontend/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 36,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
              border: Border.all(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => themeProvider.toggleTheme(),
              child: Stack(
                children: [
                  // Sliding circle
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: isDarkMode ? 36 : 2,
                    top: 2,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isDarkMode
                                ? const Color(0xFF5B6EF5) // Dark mode accent
                                : const Color(0xFFFF8C42), // Light mode accent
                        boxShadow: [
                          BoxShadow(
                            color:
                                isDarkMode
                                    ? const Color(0xFF5B6EF5).withOpacity(0.3)
                                    : const Color(0xFFFF8C42).withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            isDarkMode
                                ? Icons.dark_mode_rounded
                                : Icons.light_mode_rounded,
                            key: ValueKey(isDarkMode),
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sun rays or stars animation
                  if (!isDarkMode) ...[
                    _buildSunRay(angle: 45, left: 48, top: 8),
                    _buildSunRay(angle: -45, left: 48, top: 24),
                  ] else ...[
                    _buildStar(left: 12, top: 8),
                    _buildStar(left: 22, top: 20),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSunRay({
    required double angle,
    required double left,
    required double top,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: angle * 3.14 / 180,
        child: Container(
          height: 4,
          width: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFFF8C42).withOpacity(0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildStar({required double left, required double top}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        height: 3,
        width: 3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
