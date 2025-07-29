
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchInitialProducts(GiftProfile profile);
  Future<List<Product>> fetchNextProducts(Product chosenProduct);
}
