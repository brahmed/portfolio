import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Thin bar at the top of the page that fills like ink as the user scrolls.
class ScrollProgressIndicator extends StatelessWidget {
  const ScrollProgressIndicator({
    super.key,
    required this.progress,
  });

  /// Value between 0.0 and 1.0.
  final double progress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _InkFillPainter(progress: progress),
      child: const SizedBox(height: 3, width: double.infinity),
    );
  }
}

class _InkFillPainter extends CustomPainter {
  const _InkFillPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final filledWidth = size.width * progress.clamp(0.0, 1.0);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, filledWidth, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_InkFillPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
