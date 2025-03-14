import 'package:flutter/material.dart';
import 'package:frontend/user/home/screens/my_workshop_.dart';
import 'package:frontend/user/home/screens/profile_screen.dart';
import 'package:frontend/user/home/screens/responsive_screen.dart';
import 'package:frontend/user/home/screens/workshop_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyWorkshopsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigation(
      currentIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      body: _screens[_selectedIndex],
    );
  }
}
