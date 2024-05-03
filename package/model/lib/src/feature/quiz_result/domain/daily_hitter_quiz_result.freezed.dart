// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_hitter_quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyHitterQuizResult {
  Map<String, HitterQuizResult> get resultMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyHitterQuizResultCopyWith<DailyHitterQuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyHitterQuizResultCopyWith<$Res> {
  factory $DailyHitterQuizResultCopyWith(DailyHitterQuizResult value,
          $Res Function(DailyHitterQuizResult) then) =
      _$DailyHitterQuizResultCopyWithImpl<$Res, DailyHitterQuizResult>;
  @useResult
  $Res call({Map<String, HitterQuizResult> resultMap});
}

/// @nodoc
class _$DailyHitterQuizResultCopyWithImpl<$Res,
        $Val extends DailyHitterQuizResult>
    implements $DailyHitterQuizResultCopyWith<$Res> {
  _$DailyHitterQuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultMap = null,
  }) {
    return _then(_value.copyWith(
      resultMap: null == resultMap
          ? _value.resultMap
          : resultMap // ignore: cast_nullable_to_non_nullable
              as Map<String, HitterQuizResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyHitterQuizResultImplCopyWith<$Res>
    implements $DailyHitterQuizResultCopyWith<$Res> {
  factory _$$DailyHitterQuizResultImplCopyWith(
          _$DailyHitterQuizResultImpl value,
          $Res Function(_$DailyHitterQuizResultImpl) then) =
      __$$DailyHitterQuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, HitterQuizResult> resultMap});
}

/// @nodoc
class __$$DailyHitterQuizResultImplCopyWithImpl<$Res>
    extends _$DailyHitterQuizResultCopyWithImpl<$Res,
        _$DailyHitterQuizResultImpl>
    implements _$$DailyHitterQuizResultImplCopyWith<$Res> {
  __$$DailyHitterQuizResultImplCopyWithImpl(_$DailyHitterQuizResultImpl _value,
      $Res Function(_$DailyHitterQuizResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultMap = null,
  }) {
    return _then(_$DailyHitterQuizResultImpl(
      resultMap: null == resultMap
          ? _value._resultMap
          : resultMap // ignore: cast_nullable_to_non_nullable
              as Map<String, HitterQuizResult>,
    ));
  }
}

/// @nodoc

class _$DailyHitterQuizResultImpl implements _DailyHitterQuizResult {
  const _$DailyHitterQuizResultImpl(
      {required final Map<String, HitterQuizResult> resultMap})
      : _resultMap = resultMap;

  final Map<String, HitterQuizResult> _resultMap;
  @override
  Map<String, HitterQuizResult> get resultMap {
    if (_resultMap is EqualUnmodifiableMapView) return _resultMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_resultMap);
  }

  @override
  String toString() {
    return 'DailyHitterQuizResult(resultMap: $resultMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyHitterQuizResultImpl &&
            const DeepCollectionEquality()
                .equals(other._resultMap, _resultMap));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_resultMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyHitterQuizResultImplCopyWith<_$DailyHitterQuizResultImpl>
      get copyWith => __$$DailyHitterQuizResultImplCopyWithImpl<
          _$DailyHitterQuizResultImpl>(this, _$identity);
}

abstract class _DailyHitterQuizResult implements DailyHitterQuizResult {
  const factory _DailyHitterQuizResult(
          {required final Map<String, HitterQuizResult> resultMap}) =
      _$DailyHitterQuizResultImpl;

  @override
  Map<String, HitterQuizResult> get resultMap;
  @override
  @JsonKey(ignore: true)
  _$$DailyHitterQuizResultImplCopyWith<_$DailyHitterQuizResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
