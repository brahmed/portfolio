import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../l10n/app_localizations.dart';

/// Language switcher + light/dark mode toggle for the nav bar.
class LocaleThemeControls extends StatelessWidget {
  const LocaleThemeControls({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: <Widget>[
        _LanguageButton(label: 'EN', locale: Locale('en')),
        _LanguageButton(label: 'FR', locale: Locale('fr')),
        _LanguageButton(label: 'ع', locale: Locale('ar')),
        SizedBox(width: 8),
        _ThemeToggleButton(),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({required this.label, required this.locale});

  final String label;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isActive =
        context.watch<LocaleController>().locale.languageCode ==
            locale.languageCode;
    final color = Theme.of(context).colorScheme.onSurface;

    return TextButton(
      onPressed: () =>
          context.read<LocaleController>().setLocale(locale),
      style: TextButton.styleFrom(
        minimumSize: const Size(36, 36),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        foregroundColor: isActive
            ? Theme.of(context).colorScheme.primary
            : color.withAlpha(153),
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight:
                  isActive ? FontWeight.w600 : FontWeight.w400,
              letterSpacing: 1.1,
            ),
      ),
      child: Text(label),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () => context.read<ThemeController>().toggle(),
      tooltip: isDark ? l10n.themeToggleLight : l10n.themeToggleDark,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          size: 20,
        ),
      ),
    );
  }
}
