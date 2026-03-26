import 'package:flutter/material.dart';

import '../../../core/widgets/ink_brush_divider.dart';
import '../../../core/widgets/scroll_progress_indicator.dart';
import '../../about/presentation/about_section.dart';
import '../../hero/presentation/hero_section.dart';
import '../../projects/presentation/projects_section.dart';
import '../../contact/presentation/contact_section.dart';
import '../../skills/presentation/skills_section.dart';
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
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    _scrollProgress.value = _scrollController.offset / max;
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
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
              SliverToBoxAdapter(
                key: _sectionKeys.hero,
                child: HeroSection(
                  onCtaPressed: () => _scrollTo(_sectionKeys.projects),
                ),
              ),
              const SliverToBoxAdapter(child: InkBrushDivider()),
              SliverToBoxAdapter(
                key: _sectionKeys.about,
                child: const AboutSection(),
              ),
              const SliverToBoxAdapter(child: InkBrushDivider()),
              SliverToBoxAdapter(
                key: _sectionKeys.projects,
                child: const ProjectsSection(),
              ),
              const SliverToBoxAdapter(child: InkBrushDivider()),
              SliverToBoxAdapter(
                key: _sectionKeys.skills,
                child: const SkillsSection(),
              ),
              const SliverToBoxAdapter(child: InkBrushDivider()),
              SliverToBoxAdapter(
                key: _sectionKeys.contact,
                child: const ContactSection(),
              ),
            ],
          ),
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

