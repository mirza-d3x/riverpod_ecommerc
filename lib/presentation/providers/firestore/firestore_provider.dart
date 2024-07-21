import 'package:ecommerce_app/data/services/firestore/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

final favoritesProvider =
    StreamProvider.family<List<String>, String>((ref, userId) {
  return ref.watch(firestoreServiceProvider).getFavorites(userId);
});
