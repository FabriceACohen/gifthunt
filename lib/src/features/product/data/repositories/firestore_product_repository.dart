
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/product/domain/repositories/product_repository.dart';

class FirestoreProductRepository implements ProductRepository {
  final FirebaseFirestore _firestore;

  FirestoreProductRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Product>> fetchInitialProducts(GiftProfile profile) async {
    try {
      // For simplicity, fetch a fixed set of products initially.
      // In a real app, this would involve more complex queries based on the profile.
      final querySnapshot = await _firestore.collection('products').limit(3).get();
      return querySnapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching initial products: $e');
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchNextProducts(Product chosenProduct) async {
    try {
      // For simplicity, fetch two more random products.
      // In a real app, this would involve more complex logic based on the chosen product.
      final querySnapshot = await _firestore.collection('products').limit(2).get();
      return querySnapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching next products: $e');
      rethrow;
    }
  }
}
