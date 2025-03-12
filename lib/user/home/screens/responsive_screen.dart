import 'package:flutter/material.dart';
import 'package:frontend/user/home/widgets/navigation_item.dart';


class ResponsiveNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;
  final Widget body;

  const ResponsiveNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.body,
  });

  static final List<NavigationItem> navigationItems = [
    NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavigationItem(
      label: 'Workshops',
      icon: Icons.calendar_today_outlined,
      selectedIcon: Icons.calendar_today,
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileLayout(context);
        } else {
          return _buildDesktopLayout(context, constraints);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: navigationItems
            .map((item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: constraints.maxWidth >= 800,
            destinations: navigationItems
                .map((item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.selectedIcon),
                      label: Text(item.label),
                    ))
                .toList(),
            selectedIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}