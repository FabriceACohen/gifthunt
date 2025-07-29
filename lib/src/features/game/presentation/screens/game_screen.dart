
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthunt/src/features/product/application/product_providers.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final productRepository = ref.read(productRepositoryProvider);
    // For now, we pass a dummy GiftProfile. This will be replaced by the actual profile later.
    return productRepository.fetchInitialProducts(const GiftProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Hunt Game'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8.0),
                        Text('ID: ${product.id}'),
                        Text('Image URL: ${product.imageUrl}'),
                        Text('Tags: ${product.tags.join(', ')}'),
                        if (product.affiliationLink != null)
                          Text('Affiliation Link: ${product.affiliationLink}'),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement dislike logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Disliked ${product.name}')),
                                );
                              },
                              child: const Text('Dislike'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement like logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Liked ${product.name}')),
                                );
                              },
                              child: const Text('Like'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
