// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSetting _$NotificationSettingFromJson(Map<String, dynamic> json) {
  return _NotificationSetting.fromJson(json);
}

/// @nodoc
mixin _$NotificationSetting {
  @HiveField(0)
  bool get allowStartDailyQuizNotification =>
      throw _privateConstructorUsedError;
  @HiveField(1)
  bool get allowRemindDailyQuizNotification =>
      throw _privateConstructorUsedError;
  @HiveField(2)
  bool get allowOtherNotification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingCopyWith<NotificationSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingCopyWith<$Res> {
  factory $NotificationSettingCopyWith(
          NotificationSetting value, $Res Function(NotificationSetting) then) =
      _$NotificationSettingCopyWithImpl<$Res, NotificationSetting>;
  @useResult
  $Res call(
      {@HiveField(0) bool allowStartDailyQuizNotification,
      @HiveField(1) bool allowRemindDailyQuizNotification,
      @HiveField(2) bool allowOtherNotification});
}

/// @nodoc
class _$NotificationSettingCopyWithImpl<$Res, $Val extends NotificationSetting>
    implements $NotificationSettingCopyWith<$Res> {
  _$NotificationSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowStartDailyQuizNotification = null,
    Object? allowRemindDailyQuizNotification = null,
    Object? allowOtherNotification = null,
  }) {
    return _then(_value.copyWith(
      allowStartDailyQuizNotification: null == allowStartDailyQuizNotification
          ? _value.allowStartDailyQuizNotification
          : allowStartDailyQuizNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemindDailyQuizNotification: null == allowRemindDailyQuizNotification
          ? _value.allowRemindDailyQuizNotification
          : allowRemindDailyQuizNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOtherNotification: null == allowOtherNotification
          ? _value.allowOtherNotification
          : allowOtherNotification // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingImplCopyWith<$Res>
    implements $NotificationSettingCopyWith<$Res> {
  factory _$$NotificationSettingImplCopyWith(_$NotificationSettingImpl value,
          $Res Function(_$NotificationSettingImpl) then) =
      __$$NotificationSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) bool allowStartDailyQuizNotification,
      @HiveField(1) bool allowRemindDailyQuizNotification,
      @HiveField(2) bool allowOtherNotification});
}

/// @nodoc
class __$$NotificationSettingImplCopyWithImpl<$Res>
    extends _$NotificationSettingCopyWithImpl<$Res, _$NotificationSettingImpl>
    implements _$$NotificationSettingImplCopyWith<$Res> {
  __$$NotificationSettingImplCopyWithImpl(_$NotificationSettingImpl _value,
      $Res Function(_$NotificationSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowStartDailyQuizNotification = null,
    Object? allowRemindDailyQuizNotification = null,
    Object? allowOtherNotification = null,
  }) {
    return _then(_$NotificationSettingImpl(
      allowStartDailyQuizNotification: null == allowStartDailyQuizNotification
          ? _value.allowStartDailyQuizNotification
          : allowStartDailyQuizNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRemindDailyQuizNotification: null == allowRemindDailyQuizNotification
          ? _value.allowRemindDailyQuizNotification
          : allowRemindDailyQuizNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOtherNotification: null == allowOtherNotification
          ? _value.allowOtherNotification
          : allowOtherNotification // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingImpl implements _NotificationSetting {
  const _$NotificationSettingImpl(
      {@HiveField(0) required this.allowStartDailyQuizNotification,
      @HiveField(1) required this.allowRemindDailyQuizNotification,
      @HiveField(2) required this.allowOtherNotification});

  factory _$NotificationSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingImplFromJson(json);

  @override
  @HiveField(0)
  final bool allowStartDailyQuizNotification;
  @override
  @HiveField(1)
  final bool allowRemindDailyQuizNotification;
  @override
  @HiveField(2)
  final bool allowOtherNotification;

  @override
  String toString() {
    return 'NotificationSetting(allowStartDailyQuizNotification: $allowStartDailyQuizNotification, allowRemindDailyQuizNotification: $allowRemindDailyQuizNotification, allowOtherNotification: $allowOtherNotification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingImpl &&
            (identical(other.allowStartDailyQuizNotification,
                    allowStartDailyQuizNotification) ||
                other.allowStartDailyQuizNotification ==
                    allowStartDailyQuizNotification) &&
            (identical(other.allowRemindDailyQuizNotification,
                    allowRemindDailyQuizNotification) ||
                other.allowRemindDailyQuizNotification ==
                    allowRemindDailyQuizNotification) &&
            (identical(other.allowOtherNotification, allowOtherNotification) ||
                other.allowOtherNotification == allowOtherNotification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, allowStartDailyQuizNotification,
      allowRemindDailyQuizNotification, allowOtherNotification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingImplCopyWith<_$NotificationSettingImpl> get copyWith =>
      __$$NotificationSettingImplCopyWithImpl<_$NotificationSettingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingImplToJson(
      this,
    );
  }
}

abstract class _NotificationSetting implements NotificationSetting {
  const factory _NotificationSetting(
          {@HiveField(0) required final bool allowStartDailyQuizNotification,
          @HiveField(1) required final bool allowRemindDailyQuizNotification,
          @HiveField(2) required final bool allowOtherNotification}) =
      _$NotificationSettingImpl;

  factory _NotificationSetting.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingImpl.fromJson;

  @override
  @HiveField(0)
  bool get allowStartDailyQuizNotification;
  @override
  @HiveField(1)
  bool get allowRemindDailyQuizNotification;
  @override
  @HiveField(2)
  bool get allowOtherNotification;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingImplCopyWith<_$NotificationSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
