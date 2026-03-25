import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/shell/presentation/shell_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ShellScreen(),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    ),
  ],
);
