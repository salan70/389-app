import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/domain/auth_repository.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../domain/daily_quiz.dart';
import '../domain/daily_quiz_repository.dart';

part 'daily_quiz_state.g.dart';

/// [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
@riverpod
Future<DailyQuiz?> dailyQuiz(DailyQuizRef ref) async =>
    ref.watch(dailyQuizRepositoryProvider).fetchDailyQuiz();

/// dailyQuiz をプレイ済みかどうかを返す。
@riverpod
Future<bool> isPlayedDailyQuiz(
  IsPlayedDailyQuizRef ref,
) async {
  final dailyQuiz = await ref.watch(dailyQuizProvider.future);
  if (dailyQuiz == null) {
    return false;
  }

  final user = ref.read(authRepositoryProvider).getCurrentUser();

  return ref.read(quizResultRepositoryProvider).existSpecifiedDailyQuizResult(
        user!,
        dailyQuiz.dailyQuizId,
      );
}
