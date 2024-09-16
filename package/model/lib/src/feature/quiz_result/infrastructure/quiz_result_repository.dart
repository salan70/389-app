import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/extension/date_time_extension.dart';
import '../../daily_quiz/domain/daily_quiz.dart';
import '../../quiz/domain/hitter_quiz.dart';
import '../../quiz/domain/hitter_quiz_state.dart';
import '../../quiz/domain/stats_value.dart';
import '../../search_condition/domain/search_condition.dart';
import '../../season/util/season_type.dart';
import '../domain/daily_hitter_quiz_result.dart';
import '../domain/hitter_quiz_result.dart';

part 'quiz_result_repository.g.dart';

@riverpod
QuizResultRepository quizResultRepository(QuizResultRepositoryRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return QuizResultRepository(firestore);
}

class QuizResultRepository {
  QuizResultRepository(this.firestore);

  final FirebaseFirestore firestore;

  Future<void> createDailyQuiz(User user, DailyQuiz dailyQuiz) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuiz.dailyQuizId)
        .set(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'targetSeasonType': dailyQuiz.seasonType.firestoreValue,
    });
  }

  Future<void> updateDailyQuizResult(
    User user,
    DailyQuiz dailyQuiz,
    HitterQuizState quizState,
  ) async {
    final hitterQuiz = quizState.hitterQuiz;
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('dailyQuizResult')
        .doc(dailyQuiz.dailyQuizId)
        // TODO(me): set 使っているため、 createdAt フィールドが削除されてしまっているかも。
        .set(<String, dynamic>{
      'questionedAt': dailyQuiz.questionedAt,
      'updatedAt': FieldValue.serverTimestamp(),
      'playerId': hitterQuiz.hitterId,
      'playerName': hitterQuiz.hitterName,
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
      'isCorrect': quizState.isCorrectEnteredHitter,
      'incorrectCount': hitterQuiz.incorrectCount,
      'targetSeasonType': dailyQuiz.seasonType.firestoreValue,
    });
  }

  Future<void> createNormalQuizResult(
    User user,
    HitterQuizState quizState,
    SearchCondition searchCondition,
  ) async {
    final hitterQuiz = quizState.hitterQuiz;
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .add(<String, dynamic>{
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'playerId': hitterQuiz.hitterId,
      'playerName': hitterQuiz.hitterName,
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
      'isCorrect': quizState.isCorrectEnteredHitter,
      'incorrectCount': hitterQuiz.incorrectCount,
      'searchCondition': searchCondition.toJson(),
      'targetSeasonType': hitterQuiz.seasonType.firestoreValue,
    });
  }

  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .orderBy('createdAt', descending: true)
        .get();

    final hitterQuizResultList = <HitterQuizResult>[];
    for (final document in snapshot.docs) {
      final hitterQuizResult = _toHitterQuizResult(document);
      hitterQuizResultList.add(hitterQuizResult);
    }

    return hitterQuizResultList;
  }

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
        final hitterQuizResult = _toHitterQuizResult(document);
        resultMap[formattedQuestionedAt] = hitterQuizResult;
      }
    }
    return DailyHitterQuizResult(resultMap: resultMap);
  }

  /// ドキュメントから [HitterQuizResult] を生成する。
  HitterQuizResult _toHitterQuizResult(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data()! as Map<String, dynamic>;
    final hitterQuiz = _toHitterQuiz(document);

    return HitterQuizResult(
      docId: document.id,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isCorrect: data['isCorrect'] as bool,
      hitterQuiz: hitterQuiz,
    );
  }

  /// ドキュメントから [HitterQuiz] を生成する。
  HitterQuiz _toHitterQuiz(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data()! as Map<String, dynamic>;

    return HitterQuiz(
      hitterId: data['playerId'] as String,
      hitterName: data['playerName'] as String,
      yearList:
          (data['yearList'] as List<dynamic>).map((e) => e as String).toList(),
      selectedStatsList: (data['selectedStatsList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      statsMapList: (data['statsMapList'] as List<dynamic>)
          .map(
            (e) => (e as Map<String, dynamic>).map(
              (k, e) =>
                  MapEntry(k, StatsValue.fromJson(e as Map<String, dynamic>)),
            ),
          )
          .toList(),
      unveilCount: data['unveilCount'] as int,
      incorrectCount: data['incorrectCount'] as int,
      seasonType: SeasonType.fromFirestoreValue(data['seasonType'] as String?),
    );
  }

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

  Future<int> fetchPlayedNormalQuizCount(User user) async {
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .count()
        .get();

    // TODO(me): ! でいいか確認する。
    return snapshot.count!;
  }

  Future<int> fetchCorrectedNormalQuizCount(User user) async {
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .where('isCorrect', isEqualTo: true)
        .count()
        .get();

    // TODO(me): ! でいいか確認する。
    return snapshot.count!;
  }

  Future<void> deleteNormalQuizResult(User user, String docId) async {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('normalQuizResult')
        .doc(docId)
        .delete();
  }
}
