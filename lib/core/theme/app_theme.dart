import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_text_theme.dart';
import 'ink_theme_extension.dart';

/// Builds light and dark ThemeData for the "Digital Ink" design system.
abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final background =
        isLight ? AppColors.lightBackground : AppColors.darkBackground;
    final onBackground =
        isLight ? AppColors.lightText : AppColors.darkText;
    final cardBackground =
        isLight ? AppColors.cardLight : AppColors.cardDark;
    final brushStroke = isLight
        ? AppColors.brushStrokeLight
        : AppColors.brushStrokeDark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: brightness,
    ).copyWith(
      surface: background,
      onSurface: onBackground,
      primary: AppColors.accent,
      onPrimary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: buildCairoTextTheme(brightness),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        InkThemeExtension(
          cardBackground: cardBackground,
          brushStrokeColor: brushStroke,
          accentColor: AppColors.accent,
          sectionBackground: background,
        ),
      ],
    );
  }
}
