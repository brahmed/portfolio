import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A hand-drawn brush-stroke divider between sections.
/// Adapts stroke color to the current theme.
class InkBrushDivider extends StatelessWidget {
  const InkBrushDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? const Color(0xFFD4CFC8) : const Color(0xFF2C2520);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SvgPicture.asset(
        'assets/svg/brush_stroke_divider.svg',
        colorFilter: ColorFilter.mode(
          color.withAlpha(90),
          BlendMode.srcIn,
        ),
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
