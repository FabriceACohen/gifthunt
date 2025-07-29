import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gifthunt/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:gifthunt/src/features/game/presentation/screens/game_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/game',
      builder: (BuildContext context, GoRouterState state) {
        return const GameScreen();
      },
    ),
  ],
);
