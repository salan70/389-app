import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../auth/domain/auth_repository.dart';
import '../../quiz/application/hitter_quiz_state.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../util/app_rview_constant.dart';
import 'app_review_state.dart';

final appReviewServiceProvider = Provider.autoDispose<AppReviewService>(
  AppReviewService.new,
);

/// アプリのレビュー関連の処理を行うサービスクラス
class AppReviewService {
  AppReviewService(this.ref);

  final Ref ref;

  Future<bool> shouldRequestAppReview() async {
    final notifier = ref.read(checkRequestAppReviewStateProvider.notifier);
    notifier.state = const AsyncValue.loading();

    // 直近のクイズで不正解している場合falseを返す
    if (ref.read(hitterQuizStateProvider).value!.isCorrect == false) {
      return false;
    }

    final user = ref.read(authRepositoryProvider).getCurrentUser()!;
    final quizResultRepository = ref.read(quizResultRepositoryProvider);

    late int playedCount;
    late int correctedCount;
    notifier.state = await AsyncValue.guard(() async {
      playedCount = await quizResultRepository.fetchPlayedNormalQuizCount(user);
      correctedCount =
          await quizResultRepository.fetchCorrectedNormalQuizCount(user);
    });

    return playedCount >= minPlayedCount && correctedCount >= minCorrectedCount;
  }

  Future<void> maybeRequestAppReview() async {
    final inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      // Random().nextDouble()は、0.0から1.0 の範囲でランダムな実数を返す
      if (Random().nextDouble() < appReviewRequestProbability) {
        await inAppReview.requestReview();
      }
    }
  }
}
