// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hitter_quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HitterQuizResult {
  String get docId => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  HitterQuiz get hitterQuiz => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterQuizResultCopyWith<HitterQuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterQuizResultCopyWith<$Res> {
  factory $HitterQuizResultCopyWith(
          HitterQuizResult value, $Res Function(HitterQuizResult) then) =
      _$HitterQuizResultCopyWithImpl<$Res, HitterQuizResult>;
  @useResult
  $Res call(
      {String docId,
      DateTime updatedAt,
      bool isCorrect,
      HitterQuiz hitterQuiz});

  $HitterQuizCopyWith<$Res> get hitterQuiz;
}

/// @nodoc
class _$HitterQuizResultCopyWithImpl<$Res, $Val extends HitterQuizResult>
    implements $HitterQuizResultCopyWith<$Res> {
  _$HitterQuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? updatedAt = null,
    Object? isCorrect = null,
    Object? hitterQuiz = null,
  }) {
    return _then(_value.copyWith(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      hitterQuiz: null == hitterQuiz
          ? _value.hitterQuiz
          : hitterQuiz // ignore: cast_nullable_to_non_nullable
              as HitterQuiz,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HitterQuizCopyWith<$Res> get hitterQuiz {
    return $HitterQuizCopyWith<$Res>(_value.hitterQuiz, (value) {
      return _then(_value.copyWith(hitterQuiz: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HitterQuizResultImplCopyWith<$Res>
    implements $HitterQuizResultCopyWith<$Res> {
  factory _$$HitterQuizResultImplCopyWith(_$HitterQuizResultImpl value,
          $Res Function(_$HitterQuizResultImpl) then) =
      __$$HitterQuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docId,
      DateTime updatedAt,
      bool isCorrect,
      HitterQuiz hitterQuiz});

  @override
  $HitterQuizCopyWith<$Res> get hitterQuiz;
}

/// @nodoc
class __$$HitterQuizResultImplCopyWithImpl<$Res>
    extends _$HitterQuizResultCopyWithImpl<$Res, _$HitterQuizResultImpl>
    implements _$$HitterQuizResultImplCopyWith<$Res> {
  __$$HitterQuizResultImplCopyWithImpl(_$HitterQuizResultImpl _value,
      $Res Function(_$HitterQuizResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? updatedAt = null,
    Object? isCorrect = null,
    Object? hitterQuiz = null,
  }) {
    return _then(_$HitterQuizResultImpl(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      hitterQuiz: null == hitterQuiz
          ? _value.hitterQuiz
          : hitterQuiz // ignore: cast_nullable_to_non_nullable
              as HitterQuiz,
    ));
  }
}

/// @nodoc

class _$HitterQuizResultImpl extends _HitterQuizResult {
  const _$HitterQuizResultImpl(
      {required this.docId,
      required this.updatedAt,
      required this.isCorrect,
      required this.hitterQuiz})
      : super._();

  @override
  final String docId;
  @override
  final DateTime updatedAt;
  @override
  final bool isCorrect;
  @override
  final HitterQuiz hitterQuiz;

  @override
  String toString() {
    return 'HitterQuizResult(docId: $docId, updatedAt: $updatedAt, isCorrect: $isCorrect, hitterQuiz: $hitterQuiz)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HitterQuizResultImpl &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.hitterQuiz, hitterQuiz) ||
                other.hitterQuiz == hitterQuiz));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, docId, updatedAt, isCorrect, hitterQuiz);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HitterQuizResultImplCopyWith<_$HitterQuizResultImpl> get copyWith =>
      __$$HitterQuizResultImplCopyWithImpl<_$HitterQuizResultImpl>(
          this, _$identity);
}

abstract class _HitterQuizResult extends HitterQuizResult {
  const factory _HitterQuizResult(
      {required final String docId,
      required final DateTime updatedAt,
      required final bool isCorrect,
      required final HitterQuiz hitterQuiz}) = _$HitterQuizResultImpl;
  const _HitterQuizResult._() : super._();

  @override
  String get docId;
  @override
  DateTime get updatedAt;
  @override
  bool get isCorrect;
  @override
  HitterQuiz get hitterQuiz;
  @override
  @JsonKey(ignore: true)
  _$$HitterQuizResultImplCopyWith<_$HitterQuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
