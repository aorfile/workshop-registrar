import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool light;

  const InfoChip({
    super.key,
    required this.icon,
    required this.text,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = light ? Colors.white : theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: light ? Colors.white.withOpacity(0.2) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: light ? color : color.withOpacity(0.7)),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: light ? color : color.withOpacity(0.7),
              fontWeight: light ? FontWeight.w500 : null,
            ),
          ),
        ],
      ),
    );
  }
}
