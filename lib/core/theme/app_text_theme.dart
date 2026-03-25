import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Builds the Cairo-based text theme.
/// Cairo covers both Latin and Arabic scripts — no font switching needed.
/// Dramatic weight contrast: w300 body, w800 display.
TextTheme buildCairoTextTheme(Brightness brightness) {
  final color = brightness == Brightness.light
      ? AppColors.lightText
      : AppColors.darkText;

  return TextTheme(
    displayLarge: GoogleFonts.cairo(
      fontSize: 72,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.1,
    ),
    displayMedium: GoogleFonts.cairo(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    ),
    displaySmall: GoogleFonts.cairo(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    ),
    titleLarge: GoogleFonts.cairo(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    titleMedium: GoogleFonts.cairo(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
    ),
    bodyLarge: GoogleFonts.cairo(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: color,
      height: 1.6,
    ),
    bodyMedium: GoogleFonts.cairo(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: color,
      height: 1.5,
    ),
    labelSmall: GoogleFonts.cairo(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: color.withAlpha(153),
      letterSpacing: 1.2,
    ),
  );
}
