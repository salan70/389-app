import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/repository/user_info_repository.dart';

class FirebaseUserInfoRepository implements UserInfoRepository {
  FirebaseUserInfoRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<void> updateUserInfo(User user) async {
    await firestore.collection('users').doc(user.uid).set(<String, dynamic>{
      'createdAt': user.metadata.creationTime,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<bool> existSpecifiedDailyQuizResult(
    User user,
    String dailyQuizId,
  ) async {
    final DocumentSnapshot snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuizId)
        .get();

    return snapshot.exists;
  }

  @override
  Future<void> createDailyQuiz(User user, String dailyQuizId) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuizId)
        .set(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
