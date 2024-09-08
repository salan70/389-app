import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/infrastructure/auth_repository.dart';
import 'ad_free_period_repository.dart';

part 'ad_free_state.g.dart';

/// 広告非表示期間の終了日時を取得する。
///
/// 広告非表示期間が設定されていない場合は `null` を返す。
@riverpod
Future<DateTime?> endAtAdFreePeriod(EndAtAdFreePeriodRef ref) async {
  final adFreePeriodRepository = ref.watch(adFreePeriodRepositoryProvider);
  final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
  final endTime = await adFreePeriodRepository.fetchEndTime(userId);

  return endTime;
}

/// 広告非表示期間中かどうかを返す。
@riverpod
Future<bool> isAdFreePeriod(IsAdFreePeriodRef ref) async {
  final endTime = await ref.watch(endAtAdFreePeriodProvider.future);

  if (endTime == null) {
    return false;
  }

  final now = await NTP.now();
  return now.isBefore(endTime);
}