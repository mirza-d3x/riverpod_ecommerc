// import 'package:ecommerce_app/data/models/product_model.dart';
// import 'package:ecommerce_app/presentation/screens/products/products_details_screen.dart';
// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   const ProductCard({super.key, required this.product});

//   final ProductModel product;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(product.image),
//       title: Text(product.title),
//       subtitle: Text('\$${product.price}'),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailScreen(
//               product: product,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
