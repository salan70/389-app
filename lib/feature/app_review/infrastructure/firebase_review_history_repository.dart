import 'package:baseball_quiz_app/feature/app_review/domain/review_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/review_history_repository.dart';

class FirebaseReviewHistoryRepository implements ReviewHistoryRepository {
  FirebaseReviewHistoryRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static const String _collectionName = 'userReviewHistories';

  @override
  Future<ReviewHistory?> fetch(String userId) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(_collectionName).doc(userId).get();

    if (snapshot.data() == null) {
      return null;
    }

    return ReviewHistory.fromJson(snapshot.data()! as Map<String, dynamic>);
  }

  @override
  Future<void> create(String userId) async {
    await _firestore
        .collection(_collectionName)
        .doc(userId)
        .set(<String, dynamic>{
      'isDisplayedReviewDialog': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> update(String userId) async {
    await _firestore
        .collection(_collectionName)
        .doc(userId)
        .update(<String, dynamic>{
      'isDisplayedReviewDialog': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
