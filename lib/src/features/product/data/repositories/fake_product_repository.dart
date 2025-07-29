
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/product/domain/repositories/product_repository.dart';

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchInitialProducts(GiftProfile profile) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return dummy data based on profile (simplified for now)
    return [
      const Product(id: '1', name: 'Smartwatch', imageUrl: 'https://example.com/smartwatch.jpg', tags: ['tech', 'sport']),
      const Product(id: '2', name: 'Livre de cuisine', imageUrl: 'https://example.com/cookbook.jpg', tags: ['cuisine', 'lecture']),
      const Product(id: '3', name: 'Casque audio', imageUrl: 'https://example.com/headphones.jpg', tags: ['tech', 'musique']),
    ];
  }

  @override
  Future<List<Product>> fetchNextProducts(Product chosenProduct) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return more dummy data based on chosen product (simplified for now)
    return [
      Product(id: '5', name: 'Produit lié à ${chosenProduct.name}', imageUrl: 'https://example.com/related.jpg', tags: chosenProduct.tags),
      const Product(id: '6', name: 'Autre produit', imageUrl: 'https://example.com/other.jpg', tags: ['general']),
    ];
  }
}
