import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../util/extension/date_time_extension.dart';
import '../domain/daily_quiz.dart';
import '../domain/daily_quiz_repository.dart';

class FirebaseDailyQuizRepository implements DailyQuizRepository {
  FirebaseDailyQuizRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<DailyQuiz?> fetchByQuestionedAt(DateTime questionedAt) async {
    final startDateInApp = questionedAt.calculateDateInApp();
    final endDateInApp = DateTime(
      startDateInApp.year,
      startDateInApp.month,
      startDateInApp.day,
      23,
      59,
      59,
      999,
    );

    final QuerySnapshot snapshot = await firestore
        .collection('dailyQuiz')
        .orderBy('questionedAt')
        .startAt([Timestamp.fromDate(startDateInApp)])
        .endAt([Timestamp.fromDate(endDateInApp)])
        .limit(1)
        .get();

    final dailyQuizList = snapshot.docs.map((DocumentSnapshot document) {
      // TODO(me): fromDocumentメソッドをdomain/daily_quiz.dartに作成する
      final data = document.data()! as Map<String, dynamic>;
      final questionedAt = (data['questionedAt'] as Timestamp).toDate();
      final playerId = data['playerId'] as String;
      final selectedStatsList =
          formatSelectedStatsList(data['selectedStatsList'] as List<dynamic>);

      return DailyQuiz(
        dailyQuizId: document.id,
        questionedAt: questionedAt,
        playerId: playerId,
        selectedStatsList: selectedStatsList,
      );
    }).toList();

    if (dailyQuizList.isEmpty) {
      return null;
    }

    return dailyQuizList[0];
  }

  /// selectedStatsListに年度が含まれている場合は、年度を削除する
  @visibleForTesting
  List<String> formatSelectedStatsList(List<dynamic> selectedStatsList) {
    final formattedSelectedStatsList = <String>[];
    for (final item in selectedStatsList) {
      if (item != '年度') {
        formattedSelectedStatsList.add(item.toString());
      }
    }
    return formattedSelectedStatsList;
  }
}
