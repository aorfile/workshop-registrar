import 'package:flutter/material.dart';
import 'package:frontend/admin/screens/workshop_list.dart';
import 'package:frontend/admin/widgets/reponsive_container.dart';
import 'package:frontend/admin/widgets/reponsive_nav.dart';
import 'package:frontend/utils/responsive_helper.dart';


class WorkshopManager extends StatefulWidget {
  const WorkshopManager({super.key});

  @override
  State<WorkshopManager> createState() => _WorkshopManagerState();
}

class _WorkshopManagerState extends State<WorkshopManager> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveNav(
      title: 'Workshop Manager',
      currentUser: 'aorfile',
      selectedIndex: _selectedIndex,
      navigationItems: [
        NavigationItem(
          icon: const Icon(Icons.dashboard_outlined),
          selectedIcon: const Icon(Icons.dashboard),
          label: 'Overview',
          badge: '3',
        ),
        NavigationItem(
          icon: const Icon(Icons.event_outlined),
          selectedIcon: const Icon(Icons.event),
          label: 'Workshops',
        ),
        NavigationItem(
          icon: const Icon(Icons.people_outlined),
          selectedIcon: const Icon(Icons.people),
          label: 'Registrations',
          badge: '12',
        ),
        NavigationItem(
          icon: const Icon(Icons.analytics_outlined),
          selectedIcon: const Icon(Icons.analytics),
          label: 'Analytics',
        ),
      ],
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      body: _buildBody(),
      floatingActionButton: _selectedIndex == 1 
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Text('New Workshop'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildBody() {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return const ResponsiveContainer(
          child: WorkshopList(),
        );
      },
    );
  }
}