import 'package:flutter/material.dart';
import 'nav_item.dart';

class CustomResponsiveNavRail extends StatefulWidget {
  final void Function(int) onIndexChanged;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final List<NavItem> items;
  
  const CustomResponsiveNavRail({
    super.key,
    required this.onIndexChanged,
    required this.items,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  State<CustomResponsiveNavRail> createState() => _CustomResponsiveNavRailState();
}

class _CustomResponsiveNavRailState extends State<CustomResponsiveNavRail> {
  static const double compactWidth = 72.0;
  static const double expandedWidth = 200.0;
  static const double breakpoint = 1100.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isExpanded = screenWidth >= breakpoint;
    final currentWidth = isExpanded ? expandedWidth : compactWidth;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: currentWidth,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(
              horizontal: isExpanded ? 24 : 12,
            ),
            color: theme.dividerColor.withOpacity(0.1),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return NavItem(
                  icon: item.icon,
                  selectedIcon: item.selectedIcon,
                  label: item.label,
                  isExpanded: isExpanded,
                  isSelected: widget.selectedIndex == index,
                  selectedItemColor: widget.selectedItemColor,
                  unselectedItemColor: widget.unselectedItemColor,
                  onTap: () => widget.onIndexChanged(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}