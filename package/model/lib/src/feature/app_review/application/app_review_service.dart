import 'package:common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app_info/application/app_info_service.dart';
import '../../auth/infrastructure/auth_repository.dart';
import '../infrastructure/review_history_repository.dart';
import 'app_review_state.dart';

part 'app_review_service.g.dart';

@riverpod
AppReviewService appReviewService(AppReviewServiceRef ref) =>
    AppReviewService(ref);

/// アプリのレビュー関連の処理を行うサービスクラス
class AppReviewService {
  AppReviewService(this.ref);

  final Ref ref;

  /// アプリのレビューを依頼する。
  ///
  /// レビュー用のダイアログを表示できない場合、ストアを開く。
  Future<void> requestAppReview() async {
    final inAppReview = InAppReview.instance;

    try {
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      } else {
        await ref.read(appInfoServiceProvider).launchStore();
      }
    } on Exception catch (e, s) {
      // TODO(me): エラーが発生したことをスナックバーなどでユーザーに伝える。（presentationで）
      logger.e('レビューリクエストに失敗しました。', e, s);
    }
  }

  Future<void> updateReviewHistory() async {
    final userId = ref.read(authRepositoryProvider).getCurrentUser()!.uid;
    await ref.read(reviewHistoryRepositoryProvider).update(userId);

    // 更新が反映されるよう、 invalidate する。
    ref.invalidate(reviewHistoryProvider);
  }
}
