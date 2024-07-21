// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/presentation/providers/auth/auth_provider.dart';
import 'package:ecommerce_app/presentation/providers/firestore/firestore_provider.dart';
import 'package:ecommerce_app/presentation/providers/products/products_provider.dart';
import 'package:ecommerce_app/presentation/screens/login/login_screen.dart';
import 'package:ecommerce_app/presentation/screens/products/products_details_screen.dart';
import 'package:ecommerce_app/presentation/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/presentation/screens/registration/registration_screen.dart';

class ProductListingScreen extends ConsumerWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productProvider = ref.watch(productListProvider);
    final authState = ref.watch(authStateProvider);
    final user = authState.asData?.value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Products'),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
        ],
      ),
      body: user == null
          ? _buildLoginPrompt(context)
          : productProvider.when(
              data: (products) {
                final favorites =
                    ref.watch(favoritesProvider(user.uid)).asData?.value ?? [];

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isFavorite =
                        favorites.contains(product.id.toString());
                    return Card(
                      elevation: 4, // Adds shadow to the list item
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price}'),
                        leading: Image.network(product.image),
                        trailing: user != null
                            ? IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : null,
                                ),
                                onPressed: () {
                                  final firestoreService =
                                      ref.watch(firestoreServiceProvider);
                                  if (isFavorite) {
                                    firestoreService.removeFavorite(
                                        user.uid, product.id.toString());
                                  } else {
                                    firestoreService.addFavorite(
                                        user.uid, product.id.toString());
                                  }
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  _showLoginDialog(context);
                                },
                              ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
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

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please log in to view products and add favorites.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegistrationScreen(),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content:
              const Text('You need to be logged in to add items to favorites.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
