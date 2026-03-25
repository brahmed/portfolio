import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/section_title.dart';
import '../../../l10n/app_localizations.dart';
import 'project_card.dart';
import 'projects_view_model.dart';

/// Projects section — reads from [ProjectsViewModel] provided above.
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;
  bool _triggered = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.05) return;
    _triggered = true;
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<ProjectsViewModel>();

    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: l10n.projectsTitle),
            const SizedBox(height: 48),
            _buildBody(context, vm, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProjectsViewModel vm,
    AppLocalizations l10n,
  ) {
    return switch (vm.status) {
      ProjectsStatus.loading => const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 64),
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: AppColors.accent,
            ),
          ),
        ),
      ProjectsStatus.error => _ErrorState(
          message: l10n.projectsError,
          retryLabel: l10n.projectsRetry,
          onRetry: context.read<ProjectsViewModel>().retry,
        ),
      ProjectsStatus.success when vm.projects.isEmpty => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Text(
              l10n.projectsEmpty,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(120),
                  ),
            ),
          ),
        ),
      ProjectsStatus.success => _ProjectsGrid(
          projects: vm.projects
              .map((p) => (project: p, index: vm.projects.indexOf(p)))
              .toList(),
          visible: _visible,
        ),
    };
  }
}

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.projects, required this.visible});

  final List<({dynamic project, int index})> projects;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final columns = context.isMobile ? 1 : (context.isTablet ? 2 : 3);

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 24.0;
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects
              .map(
                (item) => SizedBox(
                  width: cardWidth,
                  child: ProjectCard(
                    project: item.project,
                    visible: visible,
                    delay: Duration(milliseconds: 100 + item.index * 120),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Column(
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(160),
                  ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: Text(
                retryLabel,
                style: const TextStyle(color: AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
