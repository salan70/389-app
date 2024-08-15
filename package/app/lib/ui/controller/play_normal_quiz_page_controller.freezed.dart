// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_normal_quiz_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayNormalQuizPageState {
  HitterQuizState get normalQuizState => throw _privateConstructorUsedError;

  /// 回答が未入力の旨のエラーメッセージを表示するかどうか。
  bool get showNotEnteredError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayNormalQuizPageStateCopyWith<PlayNormalQuizPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayNormalQuizPageStateCopyWith<$Res> {
  factory $PlayNormalQuizPageStateCopyWith(PlayNormalQuizPageState value,
          $Res Function(PlayNormalQuizPageState) then) =
      _$PlayNormalQuizPageStateCopyWithImpl<$Res, PlayNormalQuizPageState>;
  @useResult
  $Res call({HitterQuizState normalQuizState, bool showNotEnteredError});
}

/// @nodoc
class _$PlayNormalQuizPageStateCopyWithImpl<$Res,
        $Val extends PlayNormalQuizPageState>
    implements $PlayNormalQuizPageStateCopyWith<$Res> {
  _$PlayNormalQuizPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? normalQuizState = null,
    Object? showNotEnteredError = null,
  }) {
    return _then(_value.copyWith(
      normalQuizState: null == normalQuizState
          ? _value.normalQuizState
          : normalQuizState // ignore: cast_nullable_to_non_nullable
              as HitterQuizState,
      showNotEnteredError: null == showNotEnteredError
          ? _value.showNotEnteredError
          : showNotEnteredError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayNormalQuizPageStateImplCopyWith<$Res>
    implements $PlayNormalQuizPageStateCopyWith<$Res> {
  factory _$$PlayNormalQuizPageStateImplCopyWith(
          _$PlayNormalQuizPageStateImpl value,
          $Res Function(_$PlayNormalQuizPageStateImpl) then) =
      __$$PlayNormalQuizPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HitterQuizState normalQuizState, bool showNotEnteredError});
}

/// @nodoc
class __$$PlayNormalQuizPageStateImplCopyWithImpl<$Res>
    extends _$PlayNormalQuizPageStateCopyWithImpl<$Res,
        _$PlayNormalQuizPageStateImpl>
    implements _$$PlayNormalQuizPageStateImplCopyWith<$Res> {
  __$$PlayNormalQuizPageStateImplCopyWithImpl(
      _$PlayNormalQuizPageStateImpl _value,
      $Res Function(_$PlayNormalQuizPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? normalQuizState = null,
    Object? showNotEnteredError = null,
  }) {
    return _then(_$PlayNormalQuizPageStateImpl(
      normalQuizState: null == normalQuizState
          ? _value.normalQuizState
          : normalQuizState // ignore: cast_nullable_to_non_nullable
              as HitterQuizState,
      showNotEnteredError: null == showNotEnteredError
          ? _value.showNotEnteredError
          : showNotEnteredError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PlayNormalQuizPageStateImpl implements _PlayNormalQuizPageState {
  const _$PlayNormalQuizPageStateImpl(
      {required this.normalQuizState, required this.showNotEnteredError});

  @override
  final HitterQuizState normalQuizState;

  /// 回答が未入力の旨のエラーメッセージを表示するかどうか。
  @override
  final bool showNotEnteredError;

  @override
  String toString() {
    return 'PlayNormalQuizPageState(normalQuizState: $normalQuizState, showNotEnteredError: $showNotEnteredError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayNormalQuizPageStateImpl &&
            (identical(other.normalQuizState, normalQuizState) ||
                other.normalQuizState == normalQuizState) &&
            (identical(other.showNotEnteredError, showNotEnteredError) ||
                other.showNotEnteredError == showNotEnteredError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, normalQuizState, showNotEnteredError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayNormalQuizPageStateImplCopyWith<_$PlayNormalQuizPageStateImpl>
      get copyWith => __$$PlayNormalQuizPageStateImplCopyWithImpl<
          _$PlayNormalQuizPageStateImpl>(this, _$identity);
}

abstract class _PlayNormalQuizPageState implements PlayNormalQuizPageState {
  const factory _PlayNormalQuizPageState(
      {required final HitterQuizState normalQuizState,
      required final bool showNotEnteredError}) = _$PlayNormalQuizPageStateImpl;

  @override
  HitterQuizState get normalQuizState;
  @override

  /// 回答が未入力の旨のエラーメッセージを表示するかどうか。
  bool get showNotEnteredError;
  @override
  @JsonKey(ignore: true)
  _$$PlayNormalQuizPageStateImplCopyWith<_$PlayNormalQuizPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
