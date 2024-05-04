import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/infrastructure/auth_repository.dart';
import '../domain/daily_hitter_quiz_result.dart';
import '../domain/hitter_quiz_result.dart';
import '../infrastructure/quiz_result_repository.dart';

part 'quiz_result_state.g.dart';

// TODO(me): ref.watch に修正する。

/// normalQuiz の結果をリストで返すプロバイダー。
@riverpod
Future<List<HitterQuizResult>> normalQuizResultList(
  NormalQuizResultListRef ref,
) async {
  final user = ref.watch(authRepositoryProvider).getCurrentUser();
  return ref.watch(quizResultRepositoryProvider).fetchNormalQuizResultList(
        user!,
      );
}

/// dailyQuiz の結果を返すプロバイダー。
@riverpod
Future<DailyHitterQuizResult> dailyQuizResult(DailyQuizResultRef ref) async {
  final user = ref.watch(authRepositoryProvider).getCurrentUser();
  return ref.watch(quizResultRepositoryProvider).fetchDailyHitterQuizResult(
        user!,
      );
}
