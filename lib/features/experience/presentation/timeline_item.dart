import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../domain/experience_entry.dart';
import 'timeline_connector.dart';

/// A single row in the experience timeline.
/// Renders the dot + connector on the leading side and entry content on the right.
class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.entry,
    required this.lineProgress,
    required this.animationDelay,
    required this.parentVisible,
  });

  final ExperienceEntry entry;

  /// 0.0 → 1.0 progress for the animated connector line below this dot.
  final double lineProgress;

  /// Stagger delay for the fade-slide entrance animation.
  final Duration animationDelay;

  final bool parentVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visible: parentVisible,
      delay: animationDelay,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineDotColumn(
            lineProgress: lineProgress,
            showConnector: !entry.isLast,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: _EntryContent(entry: entry),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDotColumn extends StatelessWidget {
  const _TimelineDotColumn({
    required this.lineProgress,
    required this.showConnector,
  });

  final double lineProgress;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6), // Align dot with role text
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
        ),
        if (showConnector)
          TimelineConnector(
            progress: lineProgress,
            height: 80,
          ),
      ],
    );
  }
}

class _EntryContent extends StatelessWidget {
  const _EntryContent({required this.entry});

  final ExperienceEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.role,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              entry.company,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              entry.period,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(120),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          entry.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(180),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
