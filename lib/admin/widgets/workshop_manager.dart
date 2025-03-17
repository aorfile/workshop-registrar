import 'package:flutter/material.dart';
import 'package:frontend/admin/screens/analytics_screen.dart';
import 'package:frontend/admin/screens/overview.dart';
import 'package:frontend/admin/screens/registration.dart';
import 'package:frontend/admin/screens/workshop_list.dart';

import 'package:frontend/admin/widgets/reponsive_container.dart';
import 'package:frontend/admin/widgets/reponsive_nav.dart';
import 'package:frontend/utils/responsive_helper.dart';
import 'package:go_router/go_router.dart';

class WorkshopManager extends StatefulWidget {
  const WorkshopManager({super.key});

  @override
  State<WorkshopManager> createState() => _WorkshopManagerState();
}

class _WorkshopManagerState extends State<WorkshopManager> {
  int _selectedIndex = 0;
  final DateTime currentTime = DateTime.now();

  // List of screens to toggle between
  final List<Widget> _screens = [
    const DashboardOverview(),
    const WorkshopList(),
    const RegistrationList(),
    const AnalyticsView(),
  ];

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
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        return ResponsiveContainer(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: KeyedSubtree(
              key: ValueKey<int>(_selectedIndex),
              child: _screens[_selectedIndex],
            ),
          ),
        );
      },
    );
  }

  Widget? _buildFloatingActionButton() {
    switch (_selectedIndex) {
      case 1: // Workshops
        return FloatingActionButton.extended(
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 2));
            context.go('/admin/create');
          },
          label: const Text('New Workshop'),
          icon: const Icon(Icons.add),
        );
      case 2: // Registrations
        return FloatingActionButton(
          onPressed: () => _showExportDialog(),
          child: const Icon(Icons.download),
        );
      default:
        return null;
    }
  }

  void _showAddWorkshopDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Workshop'),
            content: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Workshop Title',
                      hintText: 'Enter workshop title',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter workshop description',
                    ),
                    maxLines: 3,
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  // Handle workshop creation
                  Navigator.pop(context);
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Export Registrations'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose export format:'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [Icon(Icons.table_chart), Text('Excel')]),
                    Column(children: [Icon(Icons.picture_as_pdf), Text('PDF')]),
                    Column(children: [Icon(Icons.code), Text('CSV')]),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              FilledButton(onPressed: () {}, child: Text('Export')),
            ],
          ),
    );
  }
}
