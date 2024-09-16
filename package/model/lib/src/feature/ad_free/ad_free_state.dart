import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/infrastructure/auth_repository.dart';
import 'ad_free_period_repository.dart';

part 'ad_free_state.g.dart';

/// 広告非表示期間の終了日時を取得する。
///
/// 広告非表示期間が設定されていない場合は `null` を返す。
@riverpod
Stream<DateTime?> endAtAdFreePeriodStream(EndAtAdFreePeriodStreamRef ref) {
  final adFreePeriodRepository = ref.watch(adFreePeriodRepositoryProvider);
  final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;

  return adFreePeriodRepository.streamEndTime(userId);
}

/// 広告非表示期間中かどうかを返す。
@riverpod
Future<bool> isAdFreePeriod(IsAdFreePeriodRef ref) async {
  final asyncEndTime = ref.watch(endAtAdFreePeriodStreamProvider).asData;

  if (asyncEndTime == null) {
    return false;
  }

  final endTime = asyncEndTime.value;
  if (endTime == null) {
    return false;
  }

  final now = await NTP.now();
  return now.isBefore(endTime);
}
