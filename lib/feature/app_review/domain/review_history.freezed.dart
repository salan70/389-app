// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
abstract class _$$ReviewHistoryImplCopyWith<$Res>
    implements $ReviewHistoryCopyWith<$Res> {
  factory _$$ReviewHistoryImplCopyWith(
          _$ReviewHistoryImpl value, $Res Function(_$ReviewHistoryImpl) then) =
      __$$ReviewHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDisplayedReviewDialog, @DateTimeConverter() DateTime updatedAt});
}

/// @nodoc
class __$$ReviewHistoryImplCopyWithImpl<$Res>
    extends _$ReviewHistoryCopyWithImpl<$Res, _$ReviewHistoryImpl>
    implements _$$ReviewHistoryImplCopyWith<$Res> {
  __$$ReviewHistoryImplCopyWithImpl(
      _$ReviewHistoryImpl _value, $Res Function(_$ReviewHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDisplayedReviewDialog = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ReviewHistoryImpl(
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
class _$ReviewHistoryImpl extends _ReviewHistory {
  const _$ReviewHistoryImpl(
      {required this.isDisplayedReviewDialog,
      @DateTimeConverter() required this.updatedAt})
      : super._();

  factory _$ReviewHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewHistoryImplFromJson(json);

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
            other is _$ReviewHistoryImpl &&
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
  _$$ReviewHistoryImplCopyWith<_$ReviewHistoryImpl> get copyWith =>
      __$$ReviewHistoryImplCopyWithImpl<_$ReviewHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewHistoryImplToJson(
      this,
    );
  }
}

abstract class _ReviewHistory extends ReviewHistory {
  const factory _ReviewHistory(
          {required final bool isDisplayedReviewDialog,
          @DateTimeConverter() required final DateTime updatedAt}) =
      _$ReviewHistoryImpl;
  const _ReviewHistory._() : super._();

  factory _ReviewHistory.fromJson(Map<String, dynamic> json) =
      _$ReviewHistoryImpl.fromJson;

  @override
  bool get isDisplayedReviewDialog;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ReviewHistoryImplCopyWith<_$ReviewHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
