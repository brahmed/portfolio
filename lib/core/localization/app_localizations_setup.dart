import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../l10n/app_localizations.dart';

/// Supported locales for the portfolio.
const supportedLocales = <Locale>[
  Locale('en'),
  Locale('fr'),
  Locale('ar'),
];

/// Localization delegates required by [MaterialApp].
const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
