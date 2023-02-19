import 'package:baseball_quiz_app/domain/entity/daily_quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/repository/daily_quiz_repository.dart';

class FirebaseDailyQuizRepository implements DailyQuizRepository {
  FirebaseDailyQuizRepository(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<DailyQuiz> fetchDailyQuiz(String playerId) async {
    final nowServerTimestamp = FieldValue.serverTimestamp() as Timestamp;
    final todayInApp = calculateTodayInApp(nowServerTimestamp);

    final QuerySnapshot snapshot = await firestore
        .collection('dailyQuiz')
        .where('questionedAt', isEqualTo: todayInApp)
        .limit(1)
        .get();

    final dailyQuizList = snapshot.docs.map((DocumentSnapshot document) {
      if (document.data() == null) {
        throw Exception();
      }

      final data = document.data()! as Map<String, dynamic>;

      final playerId = data['playerId'] as String;
      final selectedStatsList = data['selectedStatsList'] as List<String>;

      return DailyQuiz(
        dailyQuizId: document.id,
        playerId: playerId,
        selectedStatsList: selectedStatsList,
      );
    }).toList();

    return dailyQuizList[0];
  }

  /// アプリ内の「今日の日付」を取得する
  ///
  /// UT作成済み
  DateTime calculateTodayInApp(Timestamp nowServerTimestamp) {
    const borderHour = 19;

    final nowInApp = nowServerTimestamp.toDate().subtract(
          const Duration(hours: borderHour),
        );
    final todayInApp = DateTime(nowInApp.year, nowInApp.month, nowInApp.day);

    return todayInApp;
  }
}
