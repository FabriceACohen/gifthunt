import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifthunt/src/features/game/application/game_notifier.dart';
import 'package:gifthunt/src/features/game/presentation/screens/game_screen.dart';
import 'package:gifthunt/src/features/product/application/product_providers.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/product/domain/repositories/product_repository.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

// Define a type for the launch URL function
typedef LaunchUrlFunction = Future<void> Function(String urlString);

// Create a mockable launch URL function
class MockLaunchUrlFunction extends Mock {
  Future<void> call(String urlString);
}

void main() {
  group('GameScreen', () {
    late MockProductRepository mockProductRepository;
    late MockLaunchUrlFunction mockLaunchUrl;

    setUpAll(() {
      registerFallbackValue(const GiftProfile());
      registerFallbackValue(const Product(id: '', name: '', imageUrl: '', tags: []));
    });

    setUp(() {
      mockProductRepository = MockProductRepository();
      mockLaunchUrl = MockLaunchUrlFunction();

      // Mock initial products
      when(() => mockProductRepository.fetchInitialProducts(any()))
          .thenAnswer((_) async => [
                const Product(id: '1', name: 'Smartwatch', imageUrl: 'url1', tags: [], affiliationLink: 'https://amazon.com/smartwatch'), 
                const Product(id: '2', name: 'Livre de cuisine', imageUrl: 'url2', tags: [], affiliationLink: 'https://amazon.com/cookbook'),
                const Product(id: '3', name: 'Casque audio', imageUrl: 'url3', tags: [], affiliationLink: 'https://amazon.com/headphones'),
              ]);
      // Mock next products
      when(() => mockProductRepository.fetchNextProducts(any()))
          .thenAnswer((_) async => [
                const Product(id: '4', name: 'Nouveau Produit 1', imageUrl: 'url4', tags: [], affiliationLink: 'https://amazon.com/newprod1'),
                const Product(id: '5', name: 'Nouveau Produit 2', imageUrl: 'url5', tags: [], affiliationLink: 'https://amazon.com/newprod2'),
              ]);

      // Mock the _launchUrl function
      when(() => mockLaunchUrl(any())).thenAnswer((_) async => {});
    });

    testWidgets('GameScreen displays products and handles interactions', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith(() => GameNotifier()),
            productRepositoryProvider.overrideWithValue(mockProductRepository),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: GameScreen(
                // Pass the mock launch function to the GameScreen
                launchUrl: mockLaunchUrl,
              ),
            ),
          ),
        ),
      );

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for products to load
      await tester.pumpAndSettle();

      // Verify initial products are displayed
      expect(find.text('Smartwatch'), findsOneWidget);
      expect(find.text('Livre de cuisine'), findsOneWidget);
      expect(find.text('Casque audio'), findsOneWidget);

      // Simulate tapping on the first product card (Smartwatch) - assuming it's at index 0
      await tester.tap(find.text('Smartwatch'));
      await tester.pumpAndSettle();

      // Verify that the selected product (Smartwatch) is still present and new products are loaded
      expect(find.text('Smartwatch'), findsOneWidget); // Smartwatch should remain
      expect(find.text('Nouveau Produit 1'), findsOneWidget);
      expect(find.text('Nouveau Produit 2'), findsOneWidget);
      expect(find.text('Livre de cuisine'), findsNothing); // Old product should be replaced
      expect(find.text('Casque audio'), findsNothing); // Old product should be replaced

      // Simulate tapping the "Acheter sur Amazon" button for Smartwatch
      await tester.tap(find.widgetWithText(ElevatedButton, 'Acheter sur Amazon').first);
      await tester.pumpAndSettle();
      verify(() => mockLaunchUrl('https://amazon.com/smartwatch')).called(1);

      // Simulate tapping the "Voir sur Amazon" button for Nouveau Produit 1 (assuming it's at index 1 now)
      await tester.tap(find.widgetWithText(OutlinedButton, 'Voir sur Amazon').at(1));
      await tester.pumpAndSettle();
      verify(() => mockLaunchUrl('https://amazon.com/newprod1')).called(1);
    });
  });
}