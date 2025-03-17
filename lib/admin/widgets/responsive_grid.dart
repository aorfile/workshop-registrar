import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final double minChildWidth;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.minChildWidth = 300,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final count = (width / minChildWidth).floor();
        final childWidth = width / count - spacing;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) => SizedBox(
            width: childWidth,
            child: child,
          )).toList(),
        );
      },
    );
  }
}