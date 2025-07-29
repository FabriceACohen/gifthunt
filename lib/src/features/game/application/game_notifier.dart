
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/product/application/product_providers.dart';

part 'game_notifier.g.dart';

@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  Future<List<Product>> build() async {
    // Initial fetch of products using a dummy profile for now
    // This will be replaced by the actual GiftProfile from onboarding later
    return ref.read(productRepositoryProvider).fetchInitialProducts(const GiftProfile());
  }

  Future<void> selectProduct(Product chosenProduct, int chosenIndex) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newProducts = await ref.read(productRepositoryProvider).fetchNextProducts(chosenProduct);
      final List<Product> nextRoundProducts = List.filled(3, chosenProduct); // Initialize with chosen product

      // Fill the remaining slots with new products
      int newProductIndex = 0;
      for (int i = 0; i < 3; i++) {
        if (i != chosenIndex) {
          if (newProductIndex < newProducts.length) {
            nextRoundProducts[i] = newProducts[newProductIndex];
            newProductIndex++;
          } else {
            // Handle case where there are not enough new products (e.g., fill with dummy or previous)
            // For now, just use a placeholder or throw an error
            nextRoundProducts[i] = const Product(id: 'dummy', name: 'Placeholder', imageUrl: 'https://example.com/placeholder.jpg', tags: []);
          }
        }
      }
      return nextRoundProducts;
    });
  }
}
