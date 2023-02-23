// ignore_for_file: one_member_abstracts

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/daily_quiz.dart';

final dailyQuizRepositoryProvider = Provider<DailyQuizRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class DailyQuizRepository {
  /// dailyQuizを取得する
  Future<DailyQuiz> fetchDailyQuiz();
}
