import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/section_title.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/experience_entry.dart';
import 'timeline_item.dart';

/// Experience section with an animated ink-line timeline.
class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lineController;
  late final Animation<double> _lineProgress;
  bool _visible = false;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _lineProgress = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeInOut,
    );
    _lineController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.1) return;
    _triggered = true;
    setState(() => _visible = true);
    _lineController.forward();
  }

  List<ExperienceEntry> _buildEntries(AppLocalizations l10n) => [
        ExperienceEntry(
          role: l10n.exp1Role,
          company: l10n.exp1Company,
          period: l10n.exp1Period,
          description: l10n.exp1Description,
        ),
        ExperienceEntry(
          role: l10n.exp2Role,
          company: l10n.exp2Company,
          period: l10n.exp2Period,
          description: l10n.exp2Description,
        ),
        ExperienceEntry(
          role: l10n.exp3Role,
          company: l10n.exp3Company,
          period: l10n.exp3Period,
          description: l10n.exp3Description,
          isLast: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = _buildEntries(l10n);

    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: l10n.experienceTitle),
            const SizedBox(height: 48),
            for (var i = 0; i < entries.length; i++)
              TimelineItem(
                entry: entries[i],
                lineProgress: _lineProgress.value,
                parentVisible: _visible,
                animationDelay: Duration(milliseconds: 100 + i * 150),
              ),
          ],
        ),
      ),
    );
  }
}
