import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entity/hitter_quiz.dart';
import '../../../domain/entity/hitter_quiz_result.dart';
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

  @override
  Future<void> updateDailyQuizResult(
    User user,
    String dailyQuizId,
    HitterQuiz hitterQuiz,
  ) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuizId)
        .set(<String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
      'playerId': hitterQuiz.id,
      'playerName': hitterQuiz.name,
      'selectedStatsList': hitterQuiz.selectedStatsList,
      'yearList': hitterQuiz.yearList,
      'statsMapList': hitterQuiz.statsMapList
          .map(
            (statsMap) => statsMap.map(
              (key, value) => MapEntry(
                key,
                {
                  'unveilOrder': value.unveilOrder,
                  'data': value.data,
                },
              ),
            ),
          )
          .toList(),
      'unveilCount': hitterQuiz.unveilCount,
      'isCorrect': hitterQuiz.isCorrect,
      'incorrectCount': hitterQuiz.incorrectCount,
    });
  }

  @override
  Future<void> createNormalQuizResult(User user, HitterQuiz hitterQuiz) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .add(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'playerId': hitterQuiz.id,
      'playerName': hitterQuiz.name,
      'selectedStatsList': hitterQuiz.selectedStatsList,
      'yearList': hitterQuiz.yearList,
      'statsMapList': hitterQuiz.statsMapList
          .map(
            (statsMap) => statsMap.map(
              (key, value) => MapEntry(
                key,
                {
                  'unveilOrder': value.unveilOrder,
                  'data': value.data,
                },
              ),
            ),
          )
          .toList(),
      'unveilCount': hitterQuiz.unveilCount,
      'isCorrect': hitterQuiz.isCorrect,
      'incorrectCount': hitterQuiz.incorrectCount,
    });
  }

  @override
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .orderBy('createdAt', descending: true)
        .get();

    final hitterQuizResultList = <HitterQuizResult>[];
    for (final document in snapshot.docs) {
      final hitterQuizResult =
          HitterQuizResult.fromJson(document.data()! as Map<String, dynamic>);
      hitterQuizResultList.add(hitterQuizResult);
    }

    return hitterQuizResultList;
  }
}
