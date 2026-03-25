import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/contact_links.dart';
import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/section_title.dart';
import '../../../l10n/app_localizations.dart';

/// About section with bio text and social links.
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;
  bool _triggered = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.15) return;
    _triggered = true;
    setState(() => _visible = true);
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: context.isMobile
            ? _MobileAbout(
                l10n: l10n,
                visible: _visible,
                onLaunch: _launch,
              )
            : _DesktopAbout(
                l10n: l10n,
                visible: _visible,
                onLaunch: _launch,
              ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  const _DesktopAbout({
    required this.l10n,
    required this.visible,
    required this.onLaunch,
  });

  final AppLocalizations l10n;
  final bool visible;
  final ValueChanged<String> onLaunch;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: AnimatedFadeSlide(
            visible: visible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: l10n.aboutTitle),
                const SizedBox(height: 32),
                Text(
                  l10n.aboutBody,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(200),
                        height: 1.7,
                      ),
                ),
                const SizedBox(height: 32),
                _SocialLinks(l10n: l10n, onLaunch: onLaunch),
              ],
            ),
          ),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 4,
          child: AnimatedFadeSlide(
            visible: visible,
            delay: const Duration(milliseconds: 150),
            child: const _AboutDecoration(),
          ),
        ),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  const _MobileAbout({
    required this.l10n,
    required this.visible,
    required this.onLaunch,
  });

  final AppLocalizations l10n;
  final bool visible;
  final ValueChanged<String> onLaunch;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visible: visible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: l10n.aboutTitle),
          const SizedBox(height: 32),
          Text(
            l10n.aboutBody,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(200),
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 32),
          _SocialLinks(l10n: l10n, onLaunch: onLaunch),
        ],
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks({required this.l10n, required this.onLaunch});

  final AppLocalizations l10n;
  final ValueChanged<String> onLaunch;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _LinkChip(
          label: l10n.aboutLinkedIn,
          url: ContactLinks.linkedIn,
          onLaunch: onLaunch,
        ),
        _LinkChip(
          label: l10n.aboutGitHub,
          url: ContactLinks.gitHub,
          onLaunch: onLaunch,
        ),
        _LinkChip(
          label: l10n.aboutEmail,
          url: ContactLinks.email,
          onLaunch: onLaunch,
        ),
      ],
    );
  }
}

class _LinkChip extends StatefulWidget {
  const _LinkChip({
    required this.label,
    required this.url,
    required this.onLaunch,
  });

  final String label;
  final String url;
  final ValueChanged<String> onLaunch;

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onLaunch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : AppColors.accent.withAlpha(100),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
            color: _hovered ? AppColors.accent.withAlpha(20) : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
          ),
        ),
      ),
    );
  }
}

/// Decorative element — large faint initials as ink wash.
class _AboutDecoration extends StatelessWidget {
  const _AboutDecoration();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        'م',
        style: TextStyle(
          fontSize: 240,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(6),
          height: 1,
        ),
      ),
    );
  }
}
