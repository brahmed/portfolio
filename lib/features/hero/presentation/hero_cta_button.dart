import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Primary call-to-action button for the hero section.
/// Shows a subtle ink-border hover effect on desktop.
class HeroCtaButton extends StatefulWidget {
  const HeroCtaButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  State<HeroCtaButton> createState() => _HeroCtaButtonState();
}

class _HeroCtaButtonState extends State<HeroCtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      button: true,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accent : Colors.transparent,
            border: Border.all(color: AppColors.accent, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 18,
              ),
              foregroundColor:
                  _hovered ? Colors.white : AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: _hovered ? Colors.white : AppColors.accent,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
