
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

  Future<void> selectProduct(Product chosenProduct) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(productRepositoryProvider).fetchNextProducts(chosenProduct);
    });
  }
}
