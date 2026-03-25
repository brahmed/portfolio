import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Single skill tag with a hover colour transition.
class SkillChip extends StatefulWidget {
  const SkillChip({super.key, required this.label});

  final String label;

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.accent.withAlpha(15) : Colors.transparent,
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.accent.withAlpha(60),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _hovered
                    ? AppColors.accent
                    : Theme.of(context).colorScheme.onSurface.withAlpha(180),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
        ),
      ),
    );
  }
}
