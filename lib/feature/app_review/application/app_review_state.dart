import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../../quiz/application/hitter_quiz_state.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../domain/review_history.dart';
import '../domain/review_history_repository.dart';
import '../util/app_rview_constant.dart';

/// アプリレビューのリクエストを送るかどうか確認する処理の状態をAsyncValueとして返すプロバイダー
final checkRequestAppReviewStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);

/// [ReviewHistory] を取得する。
///
/// 存在しない場合は null を返す。
final reviewHistoryProvider = FutureProvider<ReviewHistory?>((ref) async {
  final user = ref.read(authRepositoryProvider).getCurrentUser();
  return ref.read(reviewHistoryRepositoryProvider).fetch(user!.uid);
});

/// レビューを要求するかどうかを返すプロバイダー。
final shouldRequestReviewProvider = FutureProvider<bool>((ref) async {
  // 直近のクイズで不正解している場合 false を返す。
  if (ref.read(hitterQuizStateProvider).value?.isCorrect ?? false == false) {
    return false;
  }

  final reviewHistory = await ref.watch(reviewHistoryProvider.future);
  if (reviewHistory == null) {
    return false;
  }
  if (reviewHistory.isDisplayedReviewDialog == true) {
    return false;
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
});
