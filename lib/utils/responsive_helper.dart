import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}
// cole
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, DeviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return builder(context, DeviceType.desktop);
        } else if (constraints.maxWidth > 600) {
          return builder(context, DeviceType.tablet);
        } else {
          return builder(context, DeviceType.mobile);
        }
      },
    );
  }
}
