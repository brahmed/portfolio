import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_breakpoints.dart';
import '../../../l10n/app_localizations.dart';
import 'locale_theme_controls.dart';
import 'section_keys.dart';

/// Sticky navigation bar with section links and locale/theme controls.
/// Desktop: horizontal pill links. Mobile: hamburger + bottom sheet drawer.
class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.sectionKeys});

  final SectionKeys sectionKeys;

  static const double _height = 64;

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
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      toolbarHeight: _height,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withAlpha(230),
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: _NavBarContent(
        sectionKeys: sectionKeys,
        onScrollTo: _scrollTo,
      ),
      automaticallyImplyLeading: false,
    );
  }
}

class _NavBarContent extends StatelessWidget {
  const _NavBarContent({
    required this.sectionKeys,
    required this.onScrollTo,
  });

  final SectionKeys sectionKeys;
  final void Function(GlobalKey) onScrollTo;

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? _DesktopNav(sectionKeys: sectionKeys, onScrollTo: onScrollTo)
        : _MobileNav(sectionKeys: sectionKeys, onScrollTo: onScrollTo);
  }
}

class _DesktopNav extends StatelessWidget {
  const _DesktopNav({
    required this.sectionKeys,
    required this.onScrollTo,
  });

  final SectionKeys sectionKeys;
  final void Function(GlobalKey) onScrollTo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        children: [
          _NavLogo(onTap: () => onScrollTo(sectionKeys.hero)),
          const Spacer(),
          _NavLink(
            label: l10n.navAbout,
            onTap: () => onScrollTo(sectionKeys.about),
          ),
          _NavLink(
            label: l10n.navExperience,
            onTap: () => onScrollTo(sectionKeys.experience),
          ),
          _NavLink(
            label: l10n.navProjects,
            onTap: () => onScrollTo(sectionKeys.projects),
          ),
          _NavLink(
            label: l10n.navSkills,
            onTap: () => onScrollTo(sectionKeys.skills),
          ),
          _NavLink(
            label: l10n.navContact,
            onTap: () => onScrollTo(sectionKeys.contact),
          ),
          const SizedBox(width: 24),
          const LocaleThemeControls(),
        ],
      ),
    );
  }
}

class _MobileNav extends StatelessWidget {
  const _MobileNav({
    required this.sectionKeys,
    required this.onScrollTo,
  });

  final SectionKeys sectionKeys;
  final void Function(GlobalKey) onScrollTo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _NavLogo(onTap: () => onScrollTo(sectionKeys.hero)),
          const Spacer(),
          const LocaleThemeControls(),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _openDrawer(context),
          ),
        ],
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _MobileDrawer(
        l10n: l10n,
        sectionKeys: sectionKeys,
        onScrollTo: (key) {
          Navigator.pop(context);
          onScrollTo(key);
        },
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({
    required this.l10n,
    required this.sectionKeys,
    required this.onScrollTo,
  });

  final AppLocalizations l10n;
  final SectionKeys sectionKeys;
  final void Function(GlobalKey) onScrollTo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DrawerLink(
              label: l10n.navAbout,
              onTap: () => onScrollTo(sectionKeys.about),
            ),
            _DrawerLink(
              label: l10n.navExperience,
              onTap: () => onScrollTo(sectionKeys.experience),
            ),
            _DrawerLink(
              label: l10n.navProjects,
              onTap: () => onScrollTo(sectionKeys.projects),
            ),
            _DrawerLink(
              label: l10n.navSkills,
              onTap: () => onScrollTo(sectionKeys.skills),
            ),
            _DrawerLink(
              label: l10n.navContact,
              onTap: () => onScrollTo(sectionKeys.contact),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLogo extends StatelessWidget {
  const _NavLogo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'AMB.',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 3,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1.5,
                width: _hovered ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  const _DrawerLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      onTap: onTap,
    );
  }
}
