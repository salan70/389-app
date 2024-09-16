import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'rewarded_ad_state.freezed.dart';

@freezed
class RewardAdState with _$RewardAdState {
  const factory RewardAdState({
    RewardedAd? rewardedAd,
    required RewardAdStateType stateType,
  }) = _RewardAdState;
}

enum RewardAdStateType {
  /// 広告を読み込み中。
  loading,

  /// 広告を読み込み完了。
  loaded,

  /// 広告を読み込みに失敗。
  error,
}
