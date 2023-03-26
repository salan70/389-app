import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart';

import '../domain/daily_quiz.dart';
import '../domain/daily_quiz_repository.dart';
import '../util/daily_quiz_constant.dart';

class FirebaseDailyQuizRepository implements DailyQuizRepository {
  FirebaseDailyQuizRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<DailyQuiz> fetchDailyQuiz() async {
    final now = await NTP.now();
    final startTodayInApp = calculateTodayInApp(now);
    final endTodayInApp = DateTime(
      startTodayInApp.year,
      startTodayInApp.month,
      startTodayInApp.day,
      23,
      59,
      59,
      999,
    );

    final QuerySnapshot snapshot = await firestore
        .collection('dailyQuiz')
        .orderBy('questionedAt')
        .startAt([Timestamp.fromDate(startTodayInApp)])
        .endAt([Timestamp.fromDate(endTodayInApp)])
        .limit(1)
        .get();

    final dailyQuizList = snapshot.docs.map((DocumentSnapshot document) {
      if (document.data() == null) {
        throw Exception();
      }

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

  /// アプリ内の「今日の日付」を取得する
  ///
  /// UT作成済み
  @visibleForTesting
  DateTime calculateTodayInApp(DateTime now) {
    final nowInApp = now.subtract(
      const Duration(hours: borderHourForTodayInApp),
    );
    final todayInApp = DateTime(nowInApp.year, nowInApp.month, nowInApp.day);

    return todayInApp;
  }
}
