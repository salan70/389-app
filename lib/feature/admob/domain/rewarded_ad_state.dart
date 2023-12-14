import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'rewarded_ad_state.freezed.dart';

@freezed
class RewardAdState with _$RewardAdState {
  const factory RewardAdState({
    RewardedAd? rewardedAd,
    @Default(false) bool isLoaded,
  }) = _RewardAdState;
}
