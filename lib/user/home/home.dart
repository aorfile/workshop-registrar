import 'package:flutter/material.dart';
import 'package:frontend/admin/widgets/reponsive_container.dart';
import 'package:frontend/admin/widgets/reponsive_nav.dart';
import 'package:frontend/user/home/screens/main_screen.dart';
import 'package:frontend/user/home/screens/my_workshop_.dart';
import 'package:frontend/user/home/screens/profile_screen.dart';
import 'package:frontend/utils/responsive_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // Current Date and Time (UTC): 2025-03-17 15:27:23
  final DateTime currentTime = DateTime.parse('2025-03-17 15:27:23Z');

  // List of screens to toggle between
  final List<Widget> _screens = [
    const HomeScreen(),
    const MyWorkshopsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveNav(
      title: 'Workshop Registrar',
      currentUser: 'aorfile', // Current User's Login
      selectedIndex: _selectedIndex,
      navigationItems: [
        NavigationItem(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: 'Home',
        ),
        NavigationItem(
          icon: const Icon(Icons.event_outlined),
          selectedIcon: const Icon(Icons.event),
          label: 'My Workshops',
          badge: '2', // Optional: Show active workshops count
        ),
        NavigationItem(
          icon: const Icon(Icons.person_outlined),
          selectedIcon: const Icon(Icons.person),
          label: 'Profile',
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
              return FadeTransition(
                opacity: animation,
                child: child,
              );
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
      case 0: // Home
        return FloatingActionButton(
          onPressed: () => _showRegisterDialog(),
          tooltip: 'Register for Workshop',
          child: const Icon(Icons.add),
        );
      case 1: // My Workshops
        return FloatingActionButton(
          onPressed: () => _showWorkshopHistoryDialog(),
          tooltip: 'View History',
          child: const Icon(Icons.history),
        );
      default:
        return null;
    }
  }

  void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Register for Workshop'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Workshop Code',
                  hintText: 'Enter workshop registration code',
                  prefixIcon: const Icon(Icons.qr_code),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // Handle QR code scanning
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan QR Code'),
              ),
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
              // Handle workshop registration
              Navigator.pop(context);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  void _showWorkshopHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workshop History'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('Workshop ${index + 1}'),
                subtitle: Text('Completed on: March ${15 + index}, 2025'),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // Handle certificate download
                  },
                  tooltip: 'Download Certificate',
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}