import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context, size.width >= 800),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onDestinationSelected,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/nav-home.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color ?? Colors.grey,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/nav-home-active.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/nav-workshops.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color ?? Colors.grey,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/nav-workshops-active.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            label: 'Workshops',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/nav-profile.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color ?? Colors.grey,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/nav-profile-active.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool extended) {
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
                    icon: _buildSvgIcon(context, 'nav-home.svg'),
                    selectedIcon: _buildSvgIcon(context, 'nav-home-active.svg', isSelected: true),
                    label: 'Home',
                    isExpanded: extended,
                    isSelected: currentIndex == 0,
                    onTap: () => onDestinationSelected(0),
                  ),
                  NavItem(
                    icon: _buildSvgIcon(context, 'nav-workshops.svg'),
                    selectedIcon: _buildSvgIcon(context, 'nav-workshops-active.svg', isSelected: true),
                    label: 'Workshops',
                    isExpanded: extended,
                    isSelected: currentIndex == 1,
                    onTap: () => onDestinationSelected(1),
                  ),
                  NavItem(
                    icon: _buildSvgIcon(context, 'nav-profile.svg'),
                    selectedIcon: _buildSvgIcon(context, 'nav-profile-active.svg', isSelected: true),
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

  Widget _buildSvgIcon(BuildContext context, String assetName, {bool isSelected = false}) {
    return SvgPicture.asset(
      'assets/images/$assetName',
      colorFilter: ColorFilter.mode(
        isSelected 
            ? Theme.of(context).primaryColor
            : Theme.of(context).iconTheme.color ?? Colors.grey,
        BlendMode.srcIn,
      ),
      height: 24,
    );
  }
}