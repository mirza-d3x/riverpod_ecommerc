import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/presentation/screens/products/product_listing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: EcommerApp(),
    ),
  );
}

class EcommerApp extends StatelessWidget {
  const EcommerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductListingScreen(),
    );
  }
}
