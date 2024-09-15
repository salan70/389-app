// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rewarded_ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RewardAdState {
  RewardedAd? get rewardedAd => throw _privateConstructorUsedError;
  RewardAdStateType get stateType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RewardAdStateCopyWith<RewardAdState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardAdStateCopyWith<$Res> {
  factory $RewardAdStateCopyWith(
          RewardAdState value, $Res Function(RewardAdState) then) =
      _$RewardAdStateCopyWithImpl<$Res, RewardAdState>;
  @useResult
  $Res call({RewardedAd? rewardedAd, RewardAdStateType stateType});
}

/// @nodoc
class _$RewardAdStateCopyWithImpl<$Res, $Val extends RewardAdState>
    implements $RewardAdStateCopyWith<$Res> {
  _$RewardAdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardedAd = freezed,
    Object? stateType = null,
  }) {
    return _then(_value.copyWith(
      rewardedAd: freezed == rewardedAd
          ? _value.rewardedAd
          : rewardedAd // ignore: cast_nullable_to_non_nullable
              as RewardedAd?,
      stateType: null == stateType
          ? _value.stateType
          : stateType // ignore: cast_nullable_to_non_nullable
              as RewardAdStateType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RewardAdStateImplCopyWith<$Res>
    implements $RewardAdStateCopyWith<$Res> {
  factory _$$RewardAdStateImplCopyWith(
          _$RewardAdStateImpl value, $Res Function(_$RewardAdStateImpl) then) =
      __$$RewardAdStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RewardedAd? rewardedAd, RewardAdStateType stateType});
}

/// @nodoc
class __$$RewardAdStateImplCopyWithImpl<$Res>
    extends _$RewardAdStateCopyWithImpl<$Res, _$RewardAdStateImpl>
    implements _$$RewardAdStateImplCopyWith<$Res> {
  __$$RewardAdStateImplCopyWithImpl(
      _$RewardAdStateImpl _value, $Res Function(_$RewardAdStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardedAd = freezed,
    Object? stateType = null,
  }) {
    return _then(_$RewardAdStateImpl(
      rewardedAd: freezed == rewardedAd
          ? _value.rewardedAd
          : rewardedAd // ignore: cast_nullable_to_non_nullable
              as RewardedAd?,
      stateType: null == stateType
          ? _value.stateType
          : stateType // ignore: cast_nullable_to_non_nullable
              as RewardAdStateType,
    ));
  }
}

/// @nodoc

class _$RewardAdStateImpl implements _RewardAdState {
  const _$RewardAdStateImpl({this.rewardedAd, required this.stateType});

  @override
  final RewardedAd? rewardedAd;
  @override
  final RewardAdStateType stateType;

  @override
  String toString() {
    return 'RewardAdState(rewardedAd: $rewardedAd, stateType: $stateType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardAdStateImpl &&
            (identical(other.rewardedAd, rewardedAd) ||
                other.rewardedAd == rewardedAd) &&
            (identical(other.stateType, stateType) ||
                other.stateType == stateType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rewardedAd, stateType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardAdStateImplCopyWith<_$RewardAdStateImpl> get copyWith =>
      __$$RewardAdStateImplCopyWithImpl<_$RewardAdStateImpl>(this, _$identity);
}

abstract class _RewardAdState implements RewardAdState {
  const factory _RewardAdState(
      {final RewardedAd? rewardedAd,
      required final RewardAdStateType stateType}) = _$RewardAdStateImpl;

  @override
  RewardedAd? get rewardedAd;
  @override
  RewardAdStateType get stateType;
  @override
  @JsonKey(ignore: true)
  _$$RewardAdStateImplCopyWith<_$RewardAdStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
