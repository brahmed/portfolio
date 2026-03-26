import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/ink_brush_divider.dart';
import '../../../l10n/app_localizations.dart';
import 'hero_cta_button.dart';
import 'hero_name_painter.dart';

/// Full-viewport hero section with animated brush-stroke name underline.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onCtaPressed});

  final VoidCallback onCtaPressed;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _strokeController;
  late final Animation<double> _strokeProgress;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _strokeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _strokeProgress = CurvedAnimation(
      parent: _strokeController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _strokeController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.2) return;
    _triggered = true;
    _strokeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textDirection = Directionality.of(context);

    return VisibilityDetector(
      key: const Key('hero-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: context.isMobile
            ? _MobileLayout(
                l10n: l10n,
                strokeProgress: _strokeProgress,
                textDirection: textDirection,
                onCtaPressed: widget.onCtaPressed,
              )
            : _DesktopLayout(
                l10n: l10n,
                strokeProgress: _strokeProgress,
                textDirection: textDirection,
                onCtaPressed: widget.onCtaPressed,
              ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.l10n,
    required this.strokeProgress,
    required this.textDirection,
    required this.onCtaPressed,
  });

  final AppLocalizations l10n;
  final Animation<double> strokeProgress;
  final TextDirection textDirection;
  final VoidCallback onCtaPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _HeroContent(
            l10n: l10n,
            strokeProgress: strokeProgress,
            textDirection: textDirection,
            onCtaPressed: onCtaPressed,
          ),
        ),
        const Spacer(),
        const Expanded(
          flex: 4,
          child: _HeroDecoration(),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.l10n,
    required this.strokeProgress,
    required this.textDirection,
    required this.onCtaPressed,
  });

  final AppLocalizations l10n;
  final Animation<double> strokeProgress;
  final TextDirection textDirection;
  final VoidCallback onCtaPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 40,
      children: [
        const Center(
          child: SizedBox(
            width: 160,
            height: 160,
            child: _HeroDecoration(maxSize: 160),
          ),
        ),
        _HeroContent(
          l10n: l10n,
          strokeProgress: strokeProgress,
          textDirection: textDirection,
          onCtaPressed: onCtaPressed,
        ),
        const InkBrushDivider(),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.l10n,
    required this.strokeProgress,
    required this.textDirection,
    required this.onCtaPressed,
  });

  final AppLocalizations l10n;
  final Animation<double> strokeProgress;
  final TextDirection textDirection;
  final VoidCallback onCtaPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        _AnimatedName(
          strokeProgress: strokeProgress,
          textDirection: textDirection,
        ),
        Text(
          l10n.heroTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(180),
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.heroSubtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(153),
              ),
        ),
        const SizedBox(height: 16),
        HeroCtaButton(
          label: l10n.heroCta,
          onPressed: onCtaPressed,
        ),
      ],
    );
  }
}

class _AnimatedName extends StatelessWidget {
  const _AnimatedName({
    required this.strokeProgress,
    required this.textDirection,
  });

  final Animation<double> strokeProgress;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          'Mohamed Amine',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'Brahmi',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Positioned(
              bottom: -14,
              left: 0,
              right: 0,
              height: 20,
              child: AnimatedBuilder(
                animation: strokeProgress,
                builder: (context, _) => CustomPaint(
                  painter: HeroNamePainter(
                    progress: strokeProgress.value,
                    textDirection: textDirection,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Avatar image with an ink-style accent border.
/// Always renders as a perfect circle — size is capped at [maxSize].
class _HeroDecoration extends StatelessWidget {
  const _HeroDecoration({this.maxSize = 220});

  final double maxSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxWidth.isFinite
              ? constraints.maxWidth.clamp(0.0, maxSize)
              : maxSize;
          return SizedBox(
            width: size,
            height: size,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(40),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
