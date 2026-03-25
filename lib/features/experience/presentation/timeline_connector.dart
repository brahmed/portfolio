import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Animated vertical ink line connecting timeline items.
///
/// Draws progressively from top → bottom as [progress] goes 0.0 → 1.0.
/// The [progress] is driven by a [VisibilityDetector] in [ExperienceSection].
class TimelineConnector extends StatelessWidget {
  const TimelineConnector({
    super.key,
    required this.progress,
    this.height = 64,
  });

  final double progress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2,
      height: height,
      child: CustomPaint(
        painter: _TimelineLinePainter(
          progress: progress,
          color: AppColors.accent.withAlpha(120),
        ),
      ),
    );
  }
}

class _TimelineLinePainter extends CustomPainter {
  const _TimelineLinePainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height * progress),
      paint,
    );
  }

  @override
  bool shouldRepaint(_TimelineLinePainter old) =>
      old.progress != progress || old.color != color;
}
