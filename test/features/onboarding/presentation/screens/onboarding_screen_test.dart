
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gifthunt/src/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:gifthunt/src/features/game/presentation/screens/game_screen.dart';

void main() {
  group('OnboardingScreen', () {
    testWidgets('OnboardingScreen displays and navigates', (WidgetTester tester) async {
      // Create a mock GoRouter to capture navigation
      final GoRouter router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/game',
            builder: (context, state) => const GameScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Verify that the OnboardingScreen is displayed
      expect(find.text('Onboarding'), findsOneWidget);
      expect(find.text("Quels sont les centres d'intérêt de la personne ?"), findsOneWidget);

      // Simulate advancing through the pages
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text("Pour quelle occasion est ce cadeau ?"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text("Quel type de cadeau recherchez-vous ?"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text("Quel est votre budget ?"), findsOneWidget);

      // Simulate tapping the "Lancer la chasse" button
      await tester.tap(find.text('Lancer la chasse'));
      await tester.pumpAndSettle();

      // Verify navigation to the GameScreen
      expect(find.text('Game Screen Placeholder'), findsOneWidget);
    });
  });
}
