// ignore_for_file: one_member_abstracts

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'daily_quiz.dart';

part 'daily_quiz_repository.g.dart';

@riverpod
DailyQuizRepository dailyQuizRepository(DailyQuizRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

abstract class DailyQuizRepository {
  /// dailyQuiz を取得する。
  ///
  /// 有効な dailyQuiz が存在しなかった場合は、 `null` を返す。
  Future<DailyQuiz?> fetchDailyQuiz();
}
