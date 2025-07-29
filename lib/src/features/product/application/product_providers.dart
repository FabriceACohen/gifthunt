
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gifthunt/src/features/product/data/repositories/fake_product_repository.dart';
import 'package:gifthunt/src/features/product/domain/repositories/product_repository.dart';

part 'product_providers.g.dart';

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return FakeProductRepository();
}
