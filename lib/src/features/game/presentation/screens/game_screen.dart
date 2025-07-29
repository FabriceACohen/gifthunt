
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthunt/src/features/game/application/game_notifier.dart';
import 'package:gifthunt/src/features/product/domain/models/product.dart';
import 'package:gifthunt/src/features/onboarding/domain/models/gift_profile.dart';
import 'package:url_launcher/url_launcher.dart';

// Wrapper function for launching URLs, to make it testable
Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $urlString';
  }
}

class GameScreen extends ConsumerStatefulWidget {
  final Future<void> Function(String urlString) launchUrl;

  const GameScreen({super.key, this.launchUrl = _launchUrl});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameNotifierState = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Hunt Game'),
      ),
      body: gameNotifierState.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Display 3 products horizontally
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7, // Adjust as needed for content
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                clipBehavior: Clip.antiAlias, // For rounded corners on image
                child: InkWell(
                  onTap: () {
                    gameNotifier.selectProduct(product, index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected ${product.name}')),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(), // Pushes buttons to the bottom
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (product.affiliationLink != null) {
                                    try {
                                      await widget.launchUrl(product.affiliationLink!); // Use widget.launchUrl
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error launching URL: $e')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('No affiliation link available')),
                                    );
                                  }
                                },
                                child: const Text('Acheter sur Amazon'),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  if (product.affiliationLink != null) {
                                    try {
                                      await widget.launchUrl(product.affiliationLink!); // Use widget.launchUrl
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error launching URL: $e')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('No affiliation link available')),
                                    );
                                  }
                                },
                                child: const Text('Voir sur Amazon'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
