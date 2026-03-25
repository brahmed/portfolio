import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Animates a brush-stroke underline beneath the hero name.
///
/// The stroke is drawn progressively from 0 → full length as
/// [progress] goes from 0.0 → 1.0. Mirrors horizontally in RTL.
class HeroNamePainter extends CustomPainter {
  const HeroNamePainter({
    required this.progress,
    required this.textDirection,
  });

  final double progress;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = _buildPath(size);
    final metrics = path.computeMetrics().first;
    final drawn = metrics.extractPath(0, metrics.length * progress);

    if (textDirection == TextDirection.rtl) {
      canvas
        ..save()
        ..scale(-1, 1)
        ..translate(-size.width, 0);
      canvas.drawPath(drawn, paint);
      canvas.restore();
    } else {
      canvas.drawPath(drawn, paint);
    }
  }

  /// Calligraphic curve that sweeps across the full width.
  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w * 0.01, h * 0.75)
      ..cubicTo(
        w * 0.25, h * 0.35,
        w * 0.55, h * 0.15,
        w * 0.75, h * 0.55,
      )
      ..cubicTo(
        w * 0.85, h * 0.75,
        w * 0.92, h * 0.85,
        w * 0.99, h * 0.65,
      );
  }

  @override
  bool shouldRepaint(HeroNamePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.textDirection != textDirection;
}
