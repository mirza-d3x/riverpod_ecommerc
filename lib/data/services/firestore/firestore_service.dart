import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFavorite(String userId, String productId) async {
    await _firestore.collection('favorites').doc(userId).set({
      'favorites': FieldValue.arrayUnion([productId])
    }, SetOptions(merge: true));
  }

  Future<void> removeFavorite(String userId, String productId) async {
    await _firestore.collection('favorites').doc(userId).set({
      'favorites': FieldValue.arrayRemove([productId])
    }, SetOptions(merge: true));
  }

  Stream<List<String>> getFavorites(String userId) {
    return _firestore.collection('favorites').doc(userId).snapshots().map(
      (doc) {
        if (doc.exists && doc.data() != null) {
          return List<String>.from(
            doc.data()!['favorites'],
          );
        }
        return [];
      },
    );
  }
}
