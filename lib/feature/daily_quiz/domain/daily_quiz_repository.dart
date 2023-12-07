// ignore_for_file: one_member_abstracts

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'daily_quiz.dart';

final dailyQuizRepositoryProvider = Provider<DailyQuizRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class DailyQuizRepository {
  /// dailyQuiz を取得する。
  /// 
  /// 有効な dailyQuiz が存在しなかった場合は、 `null` を返す。
  Future<DailyQuiz?> fetchDailyQuiz();
}
