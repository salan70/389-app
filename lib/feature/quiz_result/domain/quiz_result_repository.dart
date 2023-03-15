// ignore_for_file: one_member_abstracts

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/hitter_quiz.dart';
import 'hitter_quiz_result.dart';

final quizResultRepositoryProvider = Provider<QuizResultRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class QuizResultRepository {
  /// dailyQuizの結果を作成する
  ///
  /// ここではプレイしたことを記録するだけで、
  /// クイズ結果等は更新する際に更新する
  Future<void> createDailyQuiz(User user, String dailyQuizId);

  /// dailyQuizの結果を更新する
  Future<void> updateDailyQuizResult(
    User user,
    String dailyQuizId,
    HitterQuiz hitterQuiz,
  );

  /// normalQuizの結果を作成する
  Future<void> createNormalQuizResult(User user, HitterQuiz hitterQuiz);

  /// normalQuizResultをリストで取得する
  Future<List<HitterQuizResult>> fetchNormalQuizResultList(User user);
}
