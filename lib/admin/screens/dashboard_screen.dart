import 'package:flutter/material.dart';
import 'package:frontend/admin/screens/analytics_screen.dart';
import 'package:frontend/admin/screens/overview.dart';
import 'package:frontend/admin/screens/registration.dart';
import 'package:frontend/admin/screens/workshop_list.dart';
import 'package:frontend/user/home/screens/responsive_screen.dart';
import 'package:frontend/user/home/widgets/navigation_item.dart';


class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navItems = [
    NavigationItem(
      label: 'Overview',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
     // badge: '3',
    ),
    NavigationItem(
      label: 'Workshops',
      icon: Icons.event_outlined,
      selectedIcon: Icons.event,
    ),
    NavigationItem(
      label: 'Registrations',
      icon: Icons.how_to_reg_outlined,
      selectedIcon: Icons.how_to_reg,
     // badge: '12',
    ),
    NavigationItem(
      label: 'Analytics',
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
    ),
  ];

  final List<Widget> _screens = [
    const DashboardOverview(),
    const WorkshopList(),
    const RegistrationList(),
    const AnalyticsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavigation(
      
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      body: _screens[_selectedIndex],
      
      currentIndex:_selectedIndex ,
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_selectedIndex == 1) { // Workshops screen
      return FloatingActionButton.extended(
        onPressed: () {
          // Navigate to workshop creation
        },
        label: const Text('New Workshop'),
        icon: const Icon(Icons.add),
      );
    }
    return null;
  }
}