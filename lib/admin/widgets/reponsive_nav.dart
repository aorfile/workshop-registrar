import 'dart:async';
import 'package:flutter/material.dart';

class ResponsiveNav extends StatelessWidget {
  final String title;
  final String currentUser;
  final int selectedIndex;
  final List<NavigationItem> navigationItems;
  final Function(int) onDestinationSelected;
  final Widget body;
  final Widget? floatingActionButton;
  
  // Initialize with specific UTC time
 
  const ResponsiveNav({
    super.key,
    required this.title,
    required this.currentUser,
    required this.selectedIndex,
    required this.navigationItems,
    required this.onDestinationSelected,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
     final DateTime currentTime = DateTime.now();

    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = _getDeviceType(constraints.maxWidth);
        return Scaffold(
          body: Row(
            children: [
              if (deviceType.showSideNav) 
                _NavigationSidebar(
                  title: title,
                  selectedIndex: selectedIndex,
                  navigationItems: navigationItems,
                  onDestinationSelected: onDestinationSelected,
                  isExpanded: deviceType == DeviceType.desktop,
                ),
              Expanded(
                child: Column(
                  children: [
                    if (deviceType.showHeader) 
                      _HeaderBar(
                        title: title,
                        currentUser: currentUser,
                        currentTime: currentTime,
                      ),
                    Expanded(
                      child: body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: deviceType == DeviceType.mobile
              ? _BottomNavBar(
                  selectedIndex: selectedIndex,
                  navigationItems: navigationItems,
                  onDestinationSelected: onDestinationSelected,
                )
              : null,
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }

  DeviceType _getDeviceType(double width) {
    if (width >= 1200) return DeviceType.desktop;
    if (width >= 800) return DeviceType.tablet;
    return DeviceType.mobile;
  }
}

enum DeviceType {
  mobile(showSideNav: false, showHeader: false),
  tablet(showSideNav: true, showHeader: true),
  desktop(showSideNav: true, showHeader: true);

  final bool showSideNav;
  final bool showHeader;

  const DeviceType({
    required this.showSideNav,
    required this.showHeader,
  });
}

class _HeaderBar extends StatefulWidget {
  final String title;
  final String currentUser;
  final DateTime currentTime;

  const _HeaderBar({
    required this.title,
    required this.currentUser,
    required this.currentTime,
  });

  @override
  State<_HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<_HeaderBar> {
  late DateTime _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.currentTime;
    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          _buildTimeDisplay(context),
          const SizedBox(width: 24),
          _buildUserMenu(context),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          _formatDateTime(_currentTime),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildUserMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              widget.currentUser[0].toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.currentUser,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Workshop Manager',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
      itemBuilder: (context) => [
        _buildMenuItem(Icons.person_outline, 'Profile'),
        _buildMenuItem(Icons.settings_outlined, 'Settings'),
        const PopupMenuDivider(),
        _buildMenuItem(Icons.logout_outlined, 'Logout', isDestructive: true),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    IconData icon,
    String label, {
    bool isDestructive = false,
  }) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDestructive ? Colors.red : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isDestructive ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final year = dateTime.year.toString();
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    
    return '$year-$month-$day $hour:$minute:$second UTC';
  }
}

class _NavigationSidebar extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final List<NavigationItem> navigationItems;
  final Function(int) onDestinationSelected;
  final bool isExpanded;

  const _NavigationSidebar({
    required this.title,
    required this.selectedIndex,
    required this.navigationItems,
    required this.onDestinationSelected,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExpanded ? 256 : 72,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (var i = 0; i < navigationItems.length; i++)
                    _NavigationItemTile(
                      item: navigationItems[i],
                      isSelected: i == selectedIndex,
                      isExpanded: isExpanded,
                      onTap: () => onDestinationSelected(i),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: isExpanded
          ? Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            )
          : Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ),
    );
  }
}

class _NavigationItemTile extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const _NavigationItemTile({
    required this.item,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
      leading: isSelected ? item.selectedIcon : item.icon,
      title: isExpanded
          ? Text(
              item.label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.w600 : null,
              ),
            )
          : null,
      trailing: isExpanded && item.badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavigationItem> navigationItems;
  final Function(int) onDestinationSelected;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.navigationItems,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: navigationItems.map((item) => NavigationDestination(
        icon: item.icon,
        selectedIcon: item.selectedIcon,
        label: item.label,
      )).toList(),
    );
  }
}

class NavigationItem {
  final Widget icon;
  final Widget selectedIcon;
  final String label;
  final String? badge;

  const NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badge,
  });
}