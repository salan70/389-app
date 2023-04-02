import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../util/extension/date_time_extension.dart';
import '../../daily_quiz/domain/daily_quiz.dart';
import '../../quiz/domain/hitter_quiz.dart';
import '../domain/daily_hitter_quiz_result.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';

class FirebaseQuizResultRepository implements QuizResultRepository {
  FirebaseQuizResultRepository(this.firestore);

  final FirebaseFirestore firestore;
  @override
  Future<void> createDailyQuiz(User user, DailyQuiz dailyQuiz) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuiz.dailyQuizId)
        .set(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateDailyQuizResult(
    User user,
    DailyQuiz dailyQuiz,
    HitterQuiz hitterQuiz,
  ) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuiz.dailyQuizId)
        .set(<String, dynamic>{
      'questionedAt': dailyQuiz.questionedAt,
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

  @override
  Future<DailyHitterQuizResult> fetchDailyHitterQuizResult(
    User user,
  ) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .orderBy('questionedAt', descending: true)
        .get();

    final resultMap = <String, HitterQuizResult>{};
    for (final document in snapshot.docs) {
      final data = document.data()! as Map<String, dynamic>;

      // documentに「questionedAt」フィールドがある場合のみ、dailyHitterQuizResultListに格納する
      // 「questionedAt」がないということは、ギャラリー（プレイ履歴）として表示することを
      // 想定する前に保存されたdailyQuizResultを意味するため
      if (data.containsKey('questionedAt')) {
        final formattedQuestionedAt =
            (data['questionedAt'] as Timestamp).toDate().toFormattedString();
        final hitterQuizResult = HitterQuizResult.fromJson(data);
        resultMap[formattedQuestionedAt] = hitterQuizResult;
      }
    }
    return DailyHitterQuizResult(resultMap: resultMap);
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
}
