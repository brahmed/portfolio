import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/section_title.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/skill_group.dart';
import 'skill_chip.dart';

/// Skills section — Wrap layout with one group per row label + chips.
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;
  bool _triggered = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.1) return;
    _triggered = true;
    setState(() => _visible = true);
  }

  String _groupTitle(AppLocalizations l10n, String titleKey) =>
      switch (titleKey) {
        'skillsGroupFlutter' => l10n.skillsGroupFlutter,
        'skillsGroupFirebase' => l10n.skillsGroupFirebase,
        'skillsGroupArchitecture' => l10n.skillsGroupArchitecture,
        'skillsGroupTools' => l10n.skillsGroupTools,
        'skillsGroupLanguages' => l10n.skillsGroupLanguages,
        _ => titleKey,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: l10n.skillsTitle),
            const SizedBox(height: 48),
            for (var i = 0; i < skillGroups.length; i++)
              AnimatedFadeSlide(
                visible: _visible,
                delay: Duration(milliseconds: 80 * i),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: _SkillGroupRow(
                    title: _groupTitle(l10n, skillGroups[i].titleKey),
                    skills: skillGroups[i].skills,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SkillGroupRow extends StatelessWidget {
  const _SkillGroupRow({required this.title, required this.skills});

  final String title;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((s) => SkillChip(label: s)).toList(),
        ),
      ],
    );
  }
}
