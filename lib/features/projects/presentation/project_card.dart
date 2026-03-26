import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../l10n/app_localizations.dart';
import '../data/project_model.dart';
import 'project_card_corner_painter.dart';
import 'project_screenshots_dialog.dart';

/// Animated project card with hover lift, ink corner accent, and store links.
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.visible,
    required this.delay,
  });

  final ProjectModel project;
  final bool visible;
  final Duration delay;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final textDirection = Directionality.of(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final title = widget.project.localizedTitle(locale);
    final description = widget.project.localizedDescription(locale);
    final category = widget.project.localizedCategory(locale);

    return AnimatedFadeSlide(
      visible: widget.visible,
      delay: widget.delay,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(_hovered ? 40 : 18),
                blurRadius: _hovered ? 20 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withAlpha(20),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(160),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _TechTags(tags: widget.project.techTags),
                    const SizedBox(height: 20),
                    _StoreLinks(
                      project: widget.project,
                      l10n: l10n,
                      onLaunch: _launch,
                    ),
                  ],
                ),
              ),
              // Ink corner accent
              Positioned(
                top: 0,
                left: textDirection == TextDirection.ltr ? 0 : null,
                right: textDirection == TextDirection.rtl ? 0 : null,
                width: 40,
                height: 40,
                child: CustomPaint(
                  painter: ProjectCardCornerPainter(
                    textDirection: textDirection,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechTags extends StatelessWidget {
  const _TechTags({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: tags
          .map(
            (tag) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(40),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                tag,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(140),
                      letterSpacing: 0.5,
                    ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StoreLinks extends StatelessWidget {
  const _StoreLinks({
    required this.project,
    required this.l10n,
    required this.onLaunch,
  });

  final ProjectModel project;
  final AppLocalizations l10n;
  final ValueChanged<String> onLaunch;

  @override
  Widget build(BuildContext context) {
    final storeLinks = <Widget>[];

    if (project.playStoreUrl != null) {
      storeLinks.add(
        _StoreLinkButton(
          label: l10n.projectPlayStore,
          icon: FontAwesomeIcons.googlePlay,
          onTap: () => onLaunch(project.playStoreUrl!),
        ),
      );
    }

    if (project.appStoreUrl != null) {
      storeLinks.add(
        _StoreLinkButton(
          label: l10n.projectAppStore,
          icon: FontAwesomeIcons.appStore,
          onTap: () => onLaunch(project.appStoreUrl!),
        ),
      );
    }

    final hasScreenshots = project.imageUrls.isNotEmpty;
    final hasStoreLinks = storeLinks.isNotEmpty;

    if (!hasScreenshots && !hasStoreLinks) return const SizedBox.shrink();

    final locale = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (hasScreenshots)
          _ScreenshotsButton(
            label: l10n.projectScreenshots,
            onTap: () => showDialog<void>(
              context: context,
              builder: (_) => ProjectScreenshotsDialog(
                title: project.localizedTitle(locale),
                imageUrls: project.imageUrls,
              ),
            ),
          ),
        if (hasStoreLinks)
          Wrap(spacing: 12, runSpacing: 8, children: storeLinks),
      ],
    );
  }
}

/// Distinct ghost button with an image icon for the screenshots action.
class _ScreenshotsButton extends StatefulWidget {
  const _ScreenshotsButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_ScreenshotsButton> createState() => _ScreenshotsButtonState();
}

class _ScreenshotsButtonState extends State<_ScreenshotsButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.accent.withAlpha(15)
                  : Colors.transparent,
              border: Border.all(
                color: _hovered
                    ? AppColors.accent
                    : AppColors.accent.withAlpha(80),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                const Icon(
                  Icons.photo_library_outlined,
                  size: 14,
                  color: AppColors.accent,
                ),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreLinkButton extends StatefulWidget {
  const _StoreLinkButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final FaIconData icon;
  final VoidCallback onTap;

  @override
  State<_StoreLinkButton> createState() => _StoreLinkButtonState();
}

class _StoreLinkButtonState extends State<_StoreLinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      button: true,
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accent : Colors.transparent,
              border: Border.all(color: AppColors.accent, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                FaIcon(
                  widget.icon,
                  size: 12,
                  color: _hovered ? Colors.white : AppColors.accent,
                ),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: _hovered ? Colors.white : AppColors.accent,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
