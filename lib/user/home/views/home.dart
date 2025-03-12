import 'package:flutter/material.dart';
import 'package:frontend/user/home/views/adaptive_screen.dart';
import 'package:frontend/user/home/views/home_screen.dart';
import 'package:frontend/user/home/views/profile_screen.dart';
import 'package:frontend/user/home/views/resource_screen.dart';
import 'package:frontend/user/home/views/workshop_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<(Widget, String, NavigationDestination)> _screens = [
    (
      const HomeScreen(),

      'Home',
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
    
    ),
    (
      const WorkshopsScreen(),
      'Workshops',
      const NavigationDestination(
        icon: Icon(Icons.event_note_outlined),
        selectedIcon: Icon(Icons.event_note),
        label: 'Workshops',
      ),
     
    ),
    (
      const ResourcesScreen(),
      'Resources',
      const NavigationDestination(
        icon: Icon(Icons.folder_outlined),
        selectedIcon: Icon(Icons.folder),
        label: 'Resources',
      ),
     
    ),
    (
      const ProfileScreen(),
      'Profile',
      const NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
      
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final (screen, title,_) = _screens[_selectedIndex];
    return AdaptiveScaffold(
      
      selectedIndex: _selectedIndex,
      destinations: _screens.map((s) => s.$3).toList(),
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      title: title,
      body: screen,
    );
  }
}