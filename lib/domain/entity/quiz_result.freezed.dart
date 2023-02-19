// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizResult {
  String get playerId => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get totalStatsCount => throw _privateConstructorUsedError;
  int get openStatsCount => throw _privateConstructorUsedError;
  int get incorrectCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
          QuizResult value, $Res Function(QuizResult) then) =
      _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call(
      {String playerId,
      bool isCorrect,
      int totalStatsCount,
      int openStatsCount,
      int incorrectCount});
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? isCorrect = null,
    Object? totalStatsCount = null,
    Object? openStatsCount = null,
    Object? incorrectCount = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      totalStatsCount: null == totalStatsCount
          ? _value.totalStatsCount
          : totalStatsCount // ignore: cast_nullable_to_non_nullable
              as int,
      openStatsCount: null == openStatsCount
          ? _value.openStatsCount
          : openStatsCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuizResultCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$_QuizResultCopyWith(
          _$_QuizResult value, $Res Function(_$_QuizResult) then) =
      __$$_QuizResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId,
      bool isCorrect,
      int totalStatsCount,
      int openStatsCount,
      int incorrectCount});
}

/// @nodoc
class __$$_QuizResultCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$_QuizResult>
    implements _$$_QuizResultCopyWith<$Res> {
  __$$_QuizResultCopyWithImpl(
      _$_QuizResult _value, $Res Function(_$_QuizResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? isCorrect = null,
    Object? totalStatsCount = null,
    Object? openStatsCount = null,
    Object? incorrectCount = null,
  }) {
    return _then(_$_QuizResult(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      totalStatsCount: null == totalStatsCount
          ? _value.totalStatsCount
          : totalStatsCount // ignore: cast_nullable_to_non_nullable
              as int,
      openStatsCount: null == openStatsCount
          ? _value.openStatsCount
          : openStatsCount // ignore: cast_nullable_to_non_nullable
              as int,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_QuizResult implements _QuizResult {
  const _$_QuizResult(
      {required this.playerId,
      required this.isCorrect,
      required this.totalStatsCount,
      required this.openStatsCount,
      required this.incorrectCount});

  @override
  final String playerId;
  @override
  final bool isCorrect;
  @override
  final int totalStatsCount;
  @override
  final int openStatsCount;
  @override
  final int incorrectCount;

  @override
  String toString() {
    return 'QuizResult(playerId: $playerId, isCorrect: $isCorrect, totalStatsCount: $totalStatsCount, openStatsCount: $openStatsCount, incorrectCount: $incorrectCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuizResult &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.totalStatsCount, totalStatsCount) ||
                other.totalStatsCount == totalStatsCount) &&
            (identical(other.openStatsCount, openStatsCount) ||
                other.openStatsCount == openStatsCount) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId, isCorrect,
      totalStatsCount, openStatsCount, incorrectCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuizResultCopyWith<_$_QuizResult> get copyWith =>
      __$$_QuizResultCopyWithImpl<_$_QuizResult>(this, _$identity);
}

abstract class _QuizResult implements QuizResult {
  const factory _QuizResult(
      {required final String playerId,
      required final bool isCorrect,
      required final int totalStatsCount,
      required final int openStatsCount,
      required final int incorrectCount}) = _$_QuizResult;

  @override
  String get playerId;
  @override
  bool get isCorrect;
  @override
  int get totalStatsCount;
  @override
  int get openStatsCount;
  @override
  int get incorrectCount;
  @override
  @JsonKey(ignore: true)
  _$$_QuizResultCopyWith<_$_QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}
