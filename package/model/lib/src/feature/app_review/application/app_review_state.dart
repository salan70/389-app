import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/infrastructure/auth_repository.dart';
import '../../quiz_result/infrastructure/quiz_result_repository.dart';
import '../domain/review_history.dart';
import '../infrastructure/review_history_repository.dart';
import '../util/app_rview_constant.dart';

part 'app_review_state.g.dart';

/// [ReviewHistory] を取得する。
///
/// 存在しない場合は null を返す。
@riverpod
Future<ReviewHistory?> reviewHistory(ReviewHistoryRef ref) async {
  final user = ref.watch(authRepositoryProvider).getCurrentUser();
  return ref.watch(reviewHistoryRepositoryProvider).fetch(user!.uid);
}

/// レビューを要求するかどうかを返すプロバイダー。
@riverpod
Future<bool> shouldRequestReview(ShouldRequestReviewRef ref) async {
  final reviewHistory = await ref.watch(reviewHistoryProvider.future);
  if (reviewHistory == null) {
    return false;
  }
  // 最後にレビューダイアログを表示してから、一定日数経過していない場合 false を返す。
  if (reviewHistory.isReviewDialogPastMinDayCount == false) {
    return false;
  }

  final user = ref.watch(authRepositoryProvider).getCurrentUser()!;
  final quizResultRepository = ref.watch(quizResultRepositoryProvider);

  final playedCount =
      await quizResultRepository.fetchPlayedNormalQuizCount(user);
  if (playedCount < minPlayedCount) {
    return false;
  }

  final correctedCount =
      await quizResultRepository.fetchCorrectedNormalQuizCount(user);
  return correctedCount >= minCorrectedCount;
}
