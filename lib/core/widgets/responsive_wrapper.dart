import 'package:flutter/material.dart';

import '../utils/responsive_breakpoints.dart';

/// Provides responsive layout context via [LayoutBuilder].
/// Use [ResponsiveWrapper.builder] to get mobile/tablet/desktop variants.
class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= Breakpoints.tablet) {
          return desktop ?? tablet ?? mobile;
        }
        if (width >= Breakpoints.mobile) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
