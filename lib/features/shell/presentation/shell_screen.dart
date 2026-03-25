import 'package:flutter/material.dart';

import '../../../core/widgets/scroll_progress_indicator.dart';
import 'nav_bar.dart';
import 'section_keys.dart';

/// Outer scaffold owning the [ScrollController] and all section [GlobalKey]s.
/// All portfolio sections are mounted as slivers in a [CustomScrollView].
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  late final ScrollController _scrollController;
  final _sectionKeys = SectionKeys();
  final _scrollProgress = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    _scrollProgress.value = _scrollController.offset / max;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _scrollProgress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              NavBar(sectionKeys: _sectionKeys),
              // Sections wired in subsequent phases
              SliverToBoxAdapter(
                key: _sectionKeys.hero,
                child: const _PlaceholderSection(
                  label: 'Hero',
                  height: 600,
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys.about,
                child: const _PlaceholderSection(
                  label: 'About',
                  height: 400,
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys.experience,
                child: const _PlaceholderSection(
                  label: 'Experience',
                  height: 500,
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys.projects,
                child: const _PlaceholderSection(
                  label: 'Projects',
                  height: 600,
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys.skills,
                child: const _PlaceholderSection(
                  label: 'Skills',
                  height: 400,
                ),
              ),
              SliverToBoxAdapter(
                key: _sectionKeys.contact,
                child: const _PlaceholderSection(
                  label: 'Contact',
                  height: 400,
                ),
              ),
            ],
          ),
          // Ink scroll progress bar pinned at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollProgress,
              builder: (context, progress, _) =>
                  ScrollProgressIndicator(progress: progress),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderSection extends StatelessWidget {
  const _PlaceholderSection({
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withAlpha(30),
            ),
      ),
    );
  }
}
