
import 'package:flutter_test/flutter_test.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/data/repositories/fake_product_repository.dart';

void main() {
  group('FakeProductRepository', () {
    late FakeProductRepository repository;

    setUp(() {
      repository = FakeProductRepository();
    });

    test('fetchInitialProducts returns a list of products', () async {
      final products = await repository.fetchInitialProducts(const GiftProfile());
      expect(products, isNotEmpty);
      expect(products.length, 4);
      expect(products[0].name, 'Smartwatch');
    });

    test('fetchNextProducts returns a list of products based on chosen product', () async {
      final initialProducts = await repository.fetchInitialProducts(const GiftProfile());
      final chosenProduct = initialProducts[0]; // Choose the first product

      final nextProducts = await repository.fetchNextProducts(chosenProduct);
      expect(nextProducts, isNotEmpty);
      expect(nextProducts.length, 2);
      expect(nextProducts[0].name, contains(chosenProduct.name));
    });
  });
}
