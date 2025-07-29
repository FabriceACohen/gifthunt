
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifthunt/src/features/game/presentation/screens/game_screen.dart';
import 'package:gifthunt/src/features/product/application/product_providers.dart';
import 'package:gifthunt/src/features/product/data/repositories/fake_product_repository.dart';

void main() {
  group('GameScreen', () {
    testWidgets('GameScreen displays products and handles interactions', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productRepositoryProvider.overrideWithValue(FakeProductRepository()),
          ],
          child: const MaterialApp(
            home: Scaffold(body: GameScreen()),
          ),
        ),
      );

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for products to load
      await tester.pumpAndSettle();

      // Verify products are displayed
      expect(find.text('Smartwatch'), findsOneWidget);
      expect(find.text('Livre de cuisine'), findsOneWidget);

      // Scroll to make sure all items are rendered
      await tester.drag(find.byType(ListView), const Offset(0.0, -500.0));
      await tester.pumpAndSettle();

      expect(find.text('Casque audio'), findsOneWidget);
      expect(find.text('Billet de concert'), findsOneWidget);

      // Simulate tapping the "Dislike" button for Smartwatch
      await tester.tap(find.widgetWithText(ElevatedButton, 'Dislike').first);
      await tester.pumpAndSettle();

      // Simulate tapping the "Like" button for Livre de cuisine
      await tester.tap(find.widgetWithText(ElevatedButton, 'Like').at(1));
      await tester.pumpAndSettle();
    });
  });
}
