import 'package:flutter/material.dart';

/// Custom design tokens for the "Digital Ink" design system.
/// Access via: Theme.of(context).extension< InkThemeExtension>()!
@immutable
class InkThemeExtension extends ThemeExtension<InkThemeExtension> {
  const InkThemeExtension({
    required this.cardBackground,
    required this.brushStrokeColor,
    required this.accentColor,
    required this.sectionBackground,
  });

  final Color cardBackground;
  final Color brushStrokeColor;
  final Color accentColor;
  final Color sectionBackground;

  @override
  InkThemeExtension copyWith({
    Color? cardBackground,
    Color? brushStrokeColor,
    Color? accentColor,
    Color? sectionBackground,
  }) =>
      InkThemeExtension(
        cardBackground: cardBackground ?? this.cardBackground,
        brushStrokeColor: brushStrokeColor ?? this.brushStrokeColor,
        accentColor: accentColor ?? this.accentColor,
        sectionBackground: sectionBackground ?? this.sectionBackground,
      );

  @override
  InkThemeExtension lerp(
    ThemeExtension<InkThemeExtension>? other,
    double t,
  ) {
    if (other is! InkThemeExtension) return this;
    return InkThemeExtension(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      brushStrokeColor:
          Color.lerp(brushStrokeColor, other.brushStrokeColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      sectionBackground:
          Color.lerp(sectionBackground, other.sectionBackground, t)!,
    );
  }
}
