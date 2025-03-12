import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/user/home/widgets/custom_nav_rail.dart';
import 'package:frontend/user/home/widgets/nav_item.dart';

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
      body: size.width <= 800
          ? _buildMobileLayout()
          : _buildDesktopLayout(size.width >= 800),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onDestinationSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            activeIcon: Icon(FontAwesomeIcons.houseChimney),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendar),
            activeIcon: Icon(FontAwesomeIcons.solidCalendar),
            label: 'Workshops',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            activeIcon: Icon(FontAwesomeIcons.solidUser),
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
            Container(
              constraints: BoxConstraints(
                maxWidth: extended ? 200 : 80,
                minHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(4, 0),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: CustomResponsiveNavRail(
                items: [
                  NavItem(
                    icon: FontAwesomeIcons.house,
                    selectedIcon: FontAwesomeIcons.houseChimney,
                    label: 'Home',
                    isExpanded: extended,
                    isSelected: currentIndex == 0,
                    onTap: () => onDestinationSelected(0),
                  ),
                  NavItem(
                    icon: FontAwesomeIcons.calendar,
                    selectedIcon: FontAwesomeIcons.solidCalendar,
                    label: 'Workshops',
                    isExpanded: extended,
                    isSelected: currentIndex == 1,
                    onTap: () => onDestinationSelected(1),
                  ),
                  NavItem(
                    icon: FontAwesomeIcons.user,
                    selectedIcon: FontAwesomeIcons.solidUser,
                    label: 'Profile',
                    isExpanded: extended,
                    isSelected: currentIndex == 2,
                    onTap: () => onDestinationSelected(2),
                  ),
                ],
                selectedIndex: currentIndex,
                onIndexChanged: onDestinationSelected,
              ),
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}