import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/constant/hitting_stats_constant.dart';
import '../../auth/domain/auth_repository.dart';
import '../../quiz/application/hitter_quiz_notifier.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../domain/review_history.dart';
import '../domain/review_history_repository.dart';
import '../util/app_rview_constant.dart';

part 'app_review_state.g.dart';

/// [ReviewHistory] を取得する。
///
/// 存在しない場合は null を返す。
@riverpod
Future<ReviewHistory?> reviewHistory(ReviewHistoryRef ref) async {
  final user = ref.read(authRepositoryProvider).getCurrentUser();
  return ref.read(reviewHistoryRepositoryProvider).fetch(user!.uid);
}

/// レビューを要求するかどうかを返すプロバイダー。
@riverpod
Future<bool> shouldRequestReview(ShouldRequestReviewRef ref) async {
  // ノーマルクイズの回答時に判別する想定のため、 HitterQuizType.normal を指定している。
  final hitterQuiz = await ref.watch(
    hitterQuizNotifierProvider(QuizType.normal, questionedAt: null).future,
  );

  // 直近のクイズで不正解している場合 false を返す。
  if (hitterQuiz.isCorrect == false) {
    return false;
  }

  final reviewHistory = ref.watch(reviewHistoryProvider);
  if (reviewHistory.value == null) {
    return false;
  }
  if (reviewHistory.value!.isDisplayedReviewDialog) {
    // updatedAt から7日経過していない場合は、レビューを要求しない。
    final updatedAt = reviewHistory.value!.updatedAt;
    if (DateTime.now().difference(updatedAt).inDays < minDays) {
      return false;
    }
  }

  final user = ref.read(authRepositoryProvider).getCurrentUser()!;
  final quizResultRepository = ref.read(quizResultRepositoryProvider);

  final playedCount =
      await quizResultRepository.fetchPlayedNormalQuizCount(user);
  if (playedCount < minPlayedCount) {
    return false;
  }

  final correctedCount =
      await quizResultRepository.fetchCorrectedNormalQuizCount(user);
  return correctedCount >= minCorrectedCount;
}
