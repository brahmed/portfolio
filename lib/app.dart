import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localizations_setup.dart';
import 'core/localization/locale_controller.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/projects/data/project_repository.dart';
import 'features/projects/presentation/projects_view_model.dart';

/// Root application widget.
///
/// Provides [ThemeController] and [LocaleController] to the widget tree.
/// All other ViewModels and Repositories are constructed in their respective
/// feature subtrees and passed by constructor.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider<LocaleController>(
          create: (_) => LocaleController(),
        ),
        ChangeNotifierProvider<ProjectsViewModel>(
          create: (_) => ProjectsViewModel(
            repository: ProjectRepository(),
          ),
        ),
      ],
      child: Consumer2<ThemeController, LocaleController>(
        builder: (context, theme, locale, _) {
          return MaterialApp.router(
            title: 'Amine Brahmi — Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: theme.themeMode,
            locale: locale.locale,
            supportedLocales: supportedLocales,
            localizationsDelegates: localizationsDelegates,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
