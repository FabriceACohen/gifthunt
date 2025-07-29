
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthunt/src/features/game/application/game_notifier.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/application/product_providers.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/product/domain/repositories/product_repository.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('GameNotifier', () {
    late MockProductRepository mockProductRepository;

    setUpAll(() {
      registerFallbackValue(const GiftProfile());
    });

    setUp(() {
      mockProductRepository = MockProductRepository();
    });

    test('build should fetch initial products', () async {
      final expectedProducts = [
        const Product(id: '1', name: 'Product A', imageUrl: 'urlA', tags: []), 
        const Product(id: '2', name: 'Product B', imageUrl: 'urlB', tags: []),
      ];

      when(() => mockProductRepository.fetchInitialProducts(any()))
          .thenAnswer((_) async => expectedProducts);

      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
        ],
      );
      addTearDown(container.dispose);

      final gameNotifier = container.read(gameNotifierProvider.notifier);
      final products = await gameNotifier.future;

      expect(products, expectedProducts);
      verify(() => mockProductRepository.fetchInitialProducts(const GiftProfile())).called(1);
    });

    test('selectProduct should fetch next products', () async {
      final initialProducts = [
        const Product(id: '1', name: 'Product A', imageUrl: 'urlA', tags: []), 
        const Product(id: '2', name: 'Product B', imageUrl: 'urlB', tags: []),
        const Product(id: '3', name: 'Product C', imageUrl: 'urlC', tags: []),
      ];
      final newProductsFromRepo = [
        const Product(id: '4', name: 'Product D', imageUrl: 'urlD', tags: []), 
        const Product(id: '5', name: 'Product E', imageUrl: 'urlE', tags: []),
      ];

      when(() => mockProductRepository.fetchInitialProducts(any()))
          .thenAnswer((_) async => initialProducts);
      when(() => mockProductRepository.fetchNextProducts(initialProducts[0]))
          .thenAnswer((_) async => newProductsFromRepo);

      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
        ],
      );
      addTearDown(container.dispose);

      final gameNotifier = container.read(gameNotifierProvider.notifier);
      // Ensure initial products are loaded first
      await gameNotifier.future;

      await gameNotifier.selectProduct(initialProducts[0], 0); // Pass chosenIndex
      final products = await gameNotifier.future;

      // Expected products after selection: chosen product at index 0, followed by new products
      expect(products[0], initialProducts[0]);
      expect(products[1], newProductsFromRepo[0]);
      expect(products[2], newProductsFromRepo[1]);
      expect(products.length, 3);
      verify(() => mockProductRepository.fetchNextProducts(initialProducts[0])).called(1);
    });
  });
}
