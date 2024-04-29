import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/review_history.dart';

part 'review_history_repository.g.dart';

@riverpod
ReviewHistoryRepository reviewHistoryRepository(
  ReviewHistoryRepositoryRef ref,
) {
  final firestore = ref.watch(firestoreProvider);
  return ReviewHistoryRepository(firestore);
}

class ReviewHistoryRepository {
  ReviewHistoryRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static const String _collectionName = 'userReviewHistories';

  Future<ReviewHistory?> fetch(String userId) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(_collectionName).doc(userId).get();

    if (snapshot.data() == null) {
      return null;
    }

    return ReviewHistory.fromJson(snapshot.data()! as Map<String, dynamic>);
  }

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
