import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidthPercentage;
  final EdgeInsets padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidthPercentage = 0.9,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * maxWidthPercentage,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}