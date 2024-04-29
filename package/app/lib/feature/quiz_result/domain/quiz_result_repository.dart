import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../daily_quiz/domain/daily_quiz.dart';
import '../../quiz/domain/hitter_quiz.dart';
import '../../search_condition/domain/search_condition.dart';
import 'daily_hitter_quiz_result.dart';
import 'hitter_quiz_result.dart';

part 'quiz_result_repository.g.dart';

@riverpod
QuizResultRepository quizResultRepository(QuizResultRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

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
  Future<void> createNormalQuizResult(
    User user,
    HitterQuiz hitterQuiz,
    SearchCondition searchCondition,
  );

  /// normalQuiz の結果をリストで取得する（作成日の降順）。
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user);

  /// dailyQuiz の結果をリストで取得する（出題日の降順）。
  Future<DailyHitterQuizResult> fetchDailyHitterQuizResult(User user);

  /// 指定した dailyQuiz の結果が存在するかどうかを返す。
  Future<bool> existSpecifiedDailyQuizResult(User user, String dailyQuizId);

  /// normalQuiz のプレイ回数を返す。
  Future<int> fetchPlayedNormalQuizCount(User user);

  /// normalQuiz の正解数を返す。
  Future<int> fetchCorrectedNormalQuizCount(User user);

  /// normalQuiz を削除する。
  Future<void> deleteNormalQuizResult(User user, String docId);
}
