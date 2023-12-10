// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'review_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReviewHistory _$ReviewHistoryFromJson(Map<String, dynamic> json) {
  return _ReviewHistory.fromJson(json);
}

/// @nodoc
mixin _$ReviewHistory {
  bool get isDisplayedReviewDialog => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewHistoryCopyWith<ReviewHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewHistoryCopyWith<$Res> {
  factory $ReviewHistoryCopyWith(
          ReviewHistory value, $Res Function(ReviewHistory) then) =
      _$ReviewHistoryCopyWithImpl<$Res, ReviewHistory>;
  @useResult
  $Res call(
      {bool isDisplayedReviewDialog, @DateTimeConverter() DateTime updatedAt});
}

/// @nodoc
class _$ReviewHistoryCopyWithImpl<$Res, $Val extends ReviewHistory>
    implements $ReviewHistoryCopyWith<$Res> {
  _$ReviewHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDisplayedReviewDialog = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      isDisplayedReviewDialog: null == isDisplayedReviewDialog
          ? _value.isDisplayedReviewDialog
          : isDisplayedReviewDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReviewHistoryCopyWith<$Res>
    implements $ReviewHistoryCopyWith<$Res> {
  factory _$$_ReviewHistoryCopyWith(
          _$_ReviewHistory value, $Res Function(_$_ReviewHistory) then) =
      __$$_ReviewHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDisplayedReviewDialog, @DateTimeConverter() DateTime updatedAt});
}

/// @nodoc
class __$$_ReviewHistoryCopyWithImpl<$Res>
    extends _$ReviewHistoryCopyWithImpl<$Res, _$_ReviewHistory>
    implements _$$_ReviewHistoryCopyWith<$Res> {
  __$$_ReviewHistoryCopyWithImpl(
      _$_ReviewHistory _value, $Res Function(_$_ReviewHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDisplayedReviewDialog = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_ReviewHistory(
      isDisplayedReviewDialog: null == isDisplayedReviewDialog
          ? _value.isDisplayedReviewDialog
          : isDisplayedReviewDialog // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReviewHistory extends _ReviewHistory {
  const _$_ReviewHistory(
      {required this.isDisplayedReviewDialog,
      @DateTimeConverter() required this.updatedAt})
      : super._();

  factory _$_ReviewHistory.fromJson(Map<String, dynamic> json) =>
      _$$_ReviewHistoryFromJson(json);

  @override
  final bool isDisplayedReviewDialog;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ReviewHistory(isDisplayedReviewDialog: $isDisplayedReviewDialog, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewHistory &&
            (identical(
                    other.isDisplayedReviewDialog, isDisplayedReviewDialog) ||
                other.isDisplayedReviewDialog == isDisplayedReviewDialog) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDisplayedReviewDialog, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewHistoryCopyWith<_$_ReviewHistory> get copyWith =>
      __$$_ReviewHistoryCopyWithImpl<_$_ReviewHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReviewHistoryToJson(
      this,
    );
  }
}

abstract class _ReviewHistory extends ReviewHistory {
  const factory _ReviewHistory(
          {required final bool isDisplayedReviewDialog,
          @DateTimeConverter() required final DateTime updatedAt}) =
      _$_ReviewHistory;
  const _ReviewHistory._() : super._();

  factory _ReviewHistory.fromJson(Map<String, dynamic> json) =
      _$_ReviewHistory.fromJson;

  @override
  bool get isDisplayedReviewDialog;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewHistoryCopyWith<_$_ReviewHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
