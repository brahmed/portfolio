import 'package:flutter/material.dart';

import 'core/localization/app_localizations_setup.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root application widget.
///
/// Owns [AppViewModel] which drives theme mode and locale.
/// All child ViewModels and Repositories are constructed here
/// and passed down by constructor — no service locator.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appViewModel = AppViewModel();

  @override
  void dispose() {
    _appViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _appViewModel,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Amine Brahmi — Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: _appViewModel.themeMode,
          locale: _appViewModel.locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          routerConfig: appRouter,
        );
      },
    );
  }
}

/// Manages app-wide theme and locale state.
class AppViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = switch (_themeMode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.system => ThemeMode.dark,
    };
    notifyListeners();
  }
}
