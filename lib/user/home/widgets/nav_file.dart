import 'package:flutter/material.dart';

class NavRailFAB extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;
  final double expandedWidth;

  const NavRailFAB({
    super.key,
    required this.isExpanded,
    required this.onTap,
    required this.expandedWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: isExpanded ? expandedWidth - 24 : 48,
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: isExpanded ? 12 : 0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: isExpanded 
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
            children: [
              SizedBox(width: isExpanded ? 16 : 0),
              Icon(
                Icons.add,
                color: theme.colorScheme.onPrimary,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Text(
                  'Create New',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}