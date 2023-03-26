// ignore_for_file: one_member_abstracts

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../daily_quiz/domain/daily_quiz.dart';
import '../../quiz/domain/hitter_quiz.dart';
import 'daily_hitter_quiz_result.dart';
import 'hitter_quiz_result.dart';

final quizResultRepositoryProvider = Provider<QuizResultRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class QuizResultRepository {
  /// dailyQuizの結果を作成する
  ///
  /// ここではプレイしたことを記録するだけで、
  /// クイズ結果等は更新する際に更新する
  Future<void> createDailyQuiz(User user, DailyQuiz dailyQuiz);

  /// dailyQuizの結果を更新する
  Future<void> updateDailyQuizResult(
    User user,
    DailyQuiz dailyQuiz,
    HitterQuiz hitterQuiz,
  );

  /// normalQuizの結果を作成する
  Future<void> createNormalQuizResult(User user, HitterQuiz hitterQuiz);

  /// normalQuizの結果をリストで取得する（作成日の降順）
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user);

  /// dailyQuizの結果をリストで取得する（出題日の降順）
  Future<DailyHitterQuizResult> fetchDailyHitterQuizResult(User user);

  /// 指定したdailyQuizの結果が存在するかどうかを返す
  Future<bool> existSpecifiedDailyQuizResult(User user, String dailyQuizId);
}
