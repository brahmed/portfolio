import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Paints a single ink-brush corner accent on the top-leading corner of a card.
/// Mirrors to top-trailing in RTL layout.
class ProjectCardCornerPainter extends CustomPainter {
  const ProjectCardCornerPainter({required this.textDirection});

  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (textDirection == TextDirection.rtl) {
      canvas
        ..save()
        ..scale(-1, 1)
        ..translate(-size.width, 0);
    }

    final path = Path()
      ..moveTo(0, 28)
      ..lineTo(0, 4)
      ..quadraticBezierTo(0, 0, 4, 0)
      ..lineTo(28, 0);

    canvas.drawPath(path, paint);

    if (textDirection == TextDirection.rtl) {
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ProjectCardCornerPainter old) =>
      old.textDirection != textDirection;
}
