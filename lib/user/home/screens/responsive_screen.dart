import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: size.width <= 800 ?
            _buildMobileLayout():
          
          _buildDesktopLayout(size.width >= 800),
        
      
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Workshops',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(bool extended) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: extended ? 200 : 80,
                minHeight: double.infinity,
              ),
              child: NavigationRail(
                extended: extended,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.calendar_today_outlined),
                    selectedIcon: Icon(Icons.calendar_today),
                    label: Text('Workshops'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
                selectedIndex: currentIndex,
                onDestinationSelected: onDestinationSelected,
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}