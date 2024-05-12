import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/infrastructure/auth_repository.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../quiz/domain/hitter_quiz_state.dart';
import '../../search_condition/application/search_condition_state.dart';
import '../infrastructure/quiz_result_repository.dart';
import 'quiz_result_state.dart';

part 'quiz_result_service.g.dart';

@riverpod
QuizResultService quizResultService(QuizResultServiceRef ref) =>
    QuizResultService(ref);

/// quizResult関連の処理を行うサービスクラス
class QuizResultService {
  const QuizResultService(this.ref);

  final Ref ref;

  /// dailyQuizResult を作成する。
  Future<void> createDailyQuizResult(DateTime questionedAt) async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final dailyQuiz = await ref.read(dailyQuizProvider(questionedAt).future);

    await ref
        .read(quizResultRepositoryProvider)
        .createDailyQuiz(user!, dailyQuiz!);
  }

  /// dailyQuizResult を更新する。
  Future<void> updateDailyQuizResult(
    DateTime questionedAt,
    ResultQuizState resultQuizState,
  ) async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final dailyQuiz = await ref.read(dailyQuizProvider(questionedAt).future);

    await ref.read(quizResultRepositoryProvider).updateDailyQuizResult(
          user!,
          dailyQuiz!,
          resultQuizState,
        );
  }

  /// normalQuizResult を作成する。
  Future<void> createNormalQuizResult(ResultQuizState resultQuizState) async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final searchCondition = ref.read(searchConditionProvider);

    await ref.read(quizResultRepositoryProvider).createNormalQuizResult(
          user!,
          resultQuizState,
          searchCondition,
        );
  }

  Future<void> deleteNormalQuizResult(String docId) async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    await ref.read(quizResultRepositoryProvider).deleteNormalQuizResult(
          user!,
          docId,
        );
    ref.invalidate(normalQuizResultListProvider);
  }
}
