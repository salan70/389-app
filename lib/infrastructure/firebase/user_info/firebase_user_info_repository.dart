import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entity/hitter_quiz.dart';
import '../../../domain/repository/user_info_repository.dart';
import '../../../util/logger.dart';

class FirebaseUserInfoRepository implements UserInfoRepository {
  FirebaseUserInfoRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<void> updateUserInfo(User user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(<String, dynamic>{
        'createdAt': user.metadata.creationTime,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      // TODO(me): エラーハンドリングもうちょいいい感じにする
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> existSpecifiedDailyQuizResult(
    User user,
    String dailyQuizId,
  ) async {
    try {
      final DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('dailyQuizResult')
          .doc(dailyQuizId)
          .get();

      return snapshot.exists;
      // TODO(me): エラーハンドリングもうちょいいい感じにする
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createDailyQuiz(User user, String dailyQuizId) async {
    try {
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('dailyQuizResult')
          .doc(dailyQuizId)
          .set(<String, dynamic>{
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      // TODO(me): エラーハンドリングもうちょいいい感じにする
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> updateDailyQuizResult(
    User user,
    String dailyQuizId,
    HitterQuiz hitterQuiz,
  ) async {
    try {
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
      // TODO(me): エラーハンドリングもうちょいいい感じにする
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createNormalQuizResult(User user, HitterQuiz hitterQuiz) async {
    try {
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
      // TODO(me): エラーハンドリングもうちょいいい感じにする
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
