import 'package:common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:model/model.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/app_constant.dart';

part 'hide_ad_dialog_page_controller.freezed.dart';
part 'hide_ad_dialog_page_controller.g.dart';

@freezed
class HideAdDialogPageControllerState with _$HideAdDialogPageControllerState {
  const factory HideAdDialogPageControllerState({
    /// ページの状態。
    required HideAdDialogPageState pageState,

    /// リワード広告の視聴数。
    required int rewardedAdWatchCount,

    /// 広告費表示期間の終了日時。
    required DateTime? adFreePeriodEndDate,

    /// デイリークイズをプレイ済みかどうか。
    required bool isDailyQuizPlayed,
  }) = _HideAdDialogPageControllerState;
  const HideAdDialogPageControllerState._();

  /// これ以上リワード広告を視聴できるかどうか。
  bool get canWatchRewardedAd =>
      rewardedAdWatchCount <= maxRewardedAdWatchCount;
}

enum HideAdDialogPageState {
  /// ロード中。
  loading,

  /// 通常状態。
  normal,

  /// エラー。
  error;

  /// [RewardAdState] に応じた [HideAdDialogPageState] を返す。
  static HideAdDialogPageState fromRewardedAdState(RewardAdState state) {
    switch (state.stateType) {
      case RewardAdStateType.loading:
        return HideAdDialogPageState.loading;
      case RewardAdStateType.loaded:
        return HideAdDialogPageState.normal;
      case RewardAdStateType.error:
        return HideAdDialogPageState.error;
    }
  }
}

@riverpod
class HideAdDialogPageController extends _$HideAdDialogPageController {
  @override
  Future<HideAdDialogPageControllerState> build() async {
    // リワード広告をロードする。
    final rewardedAdState = ref.watch(rewardedAdNotifierProvider);
    final pageState =
        HideAdDialogPageState.fromRewardedAdState(rewardedAdState);
    await ref.watch(rewardedAdNotifierProvider.notifier).loadAd();

    final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
    final rewardedAdWatchCount = await _fetchRewardedAdWatchCount(userId);

    final adFreePeriodEndDate = await _fetchEndTime();

    final isDailyQuizPlayed =
        await ref.watch(isPlayedTodaysDailyQuizProvider.future);

    return HideAdDialogPageControllerState(
      pageState: pageState,
      rewardedAdWatchCount: rewardedAdWatchCount,
      adFreePeriodEndDate: adFreePeriodEndDate,
      isDailyQuizPlayed: isDailyQuizPlayed,
    );
  }

  Future<void> onTapWatchRewardedAd() async {
    ref.read(rewardedAdNotifierProvider.notifier).showAd(
      onUserEarnedReward: () async {
        final userId = ref.read(authRepositoryProvider).getCurrentUser()!.uid;
        await ref
            .read(rewardedAdHistoryRepositoryProvider)
            .createRewardedAdHistory(userId);

        // `state.adFreePeriodEndDate` の更新に時間がかかるため、500ms待機する。
        // ※`state.adFreePeriodEndDate` の更新は Cloud Functions で行っている。
        await Future<void>.delayed(const Duration(milliseconds: 500));

        // 更新を反映させるために再生成する。
        ref.invalidate(endAtAdFreePeriodProvider);

        // データを更新するために再生成し、待機する。
        ref.invalidateSelf();
        await future;
      },
    );
  }

  void onTapRetry() {
    ref.invalidate(rewardedAdNotifierProvider);
    ref.invalidateSelf();
  }

  Future<int> _fetchRewardedAdWatchCount(String userId) async {
    final todayInApp = await _todayInApp();
    final startOfDay = todayInApp.getChangeTime(0);
    final endOfDay = todayInApp.getChangeTime(1);
    return ref
        .watch(rewardedAdHistoryRepositoryProvider)
        .fetchWatchAdCount(userId, startOfDay, endOfDay);
  }

  // `build()` 内で呼び出されるため、 `ref.watch()` を使っている。
  Future<DateTime?> _fetchEndTime() async {
    final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
    try {
      final endTime =
          await ref.watch(adFreePeriodRepositoryProvider).fetchEndTime(userId);

      final now = await NTP.now();
      // * 広告非表示期間が終了している場合。
      if (endTime.isBefore(now)) {
        return null;
      }

      // * 広告非表示期間が終了していない場合。
      return endTime;
    } on FirestoreException catch (e) {
      // * データが存在しない場合。
      if (e == FirestoreException.notFound()) {
        return null;
      }
      rethrow;
    }
  }

  Future<DateTime> _todayInApp() async {
    final now = await NTP.now();
    return now.calculateDateInApp();
  }
}
