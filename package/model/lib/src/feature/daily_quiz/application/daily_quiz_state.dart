import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/extension/date_time_extension.dart';
import '../../auth/infrastructure/auth_repository.dart';
import '../../quiz_result/infrastructure/quiz_result_repository.dart';
import '../domain/daily_quiz.dart';
import '../infrastructure/daily_quiz_repository.dart';

part 'daily_quiz_state.g.dart';

/// [questionedAt] に出題された [DailyQuiz] を取得して保持する。
///
/// 有効な [DailyQuiz] が存在しなかった場合は、 `null` を返す。
@riverpod
Future<DailyQuiz?> dailyQuiz(DailyQuizRef ref, DateTime questionedAt) async =>
    ref.watch(dailyQuizRepositoryProvider).fetchByQuestionedAt(questionedAt);

/// dailyQuiz をプレイ済みかどうかを返す。
@riverpod
Future<bool> isPlayedTodaysDailyQuiz(
  IsPlayedTodaysDailyQuizRef ref,
) async {
  final now = await NTP.now();
  final nowInApp = now.calculateDateInApp();
  final dailyQuiz = await ref.watch(dailyQuizProvider(nowInApp).future);
  if (dailyQuiz == null) {
    return false;
  }

  final user = ref.watch(authRepositoryProvider).getCurrentUser();

  return ref.watch(quizResultRepositoryProvider).existSpecifiedDailyQuizResult(
        user!,
        dailyQuiz.dailyQuizId,
      );
}
