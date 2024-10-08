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
    required RewardAdStateType stateType,

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

@riverpod
class HideAdDialogPageController extends _$HideAdDialogPageController {
  @override
  Future<HideAdDialogPageControllerState> build() async {
    final rewardAdState = ref.watch(rewardedAdNotifierProvider);
    await ref.watch(rewardedAdNotifierProvider.notifier).loadAd();

    final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
    final rewardedAdWatchCount = await _fetchRewardedAdWatchCount(userId);

    final adFreePeriodEndDate = await _fetchEndTime();

    final isDailyQuizPlayed =
        await ref.watch(isPlayedTodaysDailyQuizProvider.future);

    return HideAdDialogPageControllerState(
      stateType: rewardAdState.stateType,
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
    final asyncEndTime = ref.watch(endAtAdFreePeriodStreamProvider);
    final endTime = asyncEndTime.asData?.value;

    if (endTime == null) {
      return null;
    }

    final now = await NTP.now();
    // * 広告非表示期間が終了している場合。
    if (endTime.isBefore(now)) {
      return null;
    }

    // * 広告非表示期間が終了していない場合。
    return endTime;
  }

  Future<DateTime> _todayInApp() async {
    final now = await NTP.now();
    return now.calculateDateInApp();
  }
}
