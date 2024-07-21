import 'package:ecommerce_app/presentation/providers/firestore/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StreamProvider.family<List<String>, String>((ref, userId) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getFavorites(userId);
});
