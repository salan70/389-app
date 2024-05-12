// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_daily_quiz_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayDailyQuizPageState {
  InputQuizState get quizState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayDailyQuizPageStateCopyWith<PlayDailyQuizPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayDailyQuizPageStateCopyWith<$Res> {
  factory $PlayDailyQuizPageStateCopyWith(PlayDailyQuizPageState value,
          $Res Function(PlayDailyQuizPageState) then) =
      _$PlayDailyQuizPageStateCopyWithImpl<$Res, PlayDailyQuizPageState>;
  @useResult
  $Res call({InputQuizState quizState});
}

/// @nodoc
class _$PlayDailyQuizPageStateCopyWithImpl<$Res,
        $Val extends PlayDailyQuizPageState>
    implements $PlayDailyQuizPageStateCopyWith<$Res> {
  _$PlayDailyQuizPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizState = null,
  }) {
    return _then(_value.copyWith(
      quizState: null == quizState
          ? _value.quizState
          : quizState // ignore: cast_nullable_to_non_nullable
              as InputQuizState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayDailyQuizPageStateImplCopyWith<$Res>
    implements $PlayDailyQuizPageStateCopyWith<$Res> {
  factory _$$PlayDailyQuizPageStateImplCopyWith(
          _$PlayDailyQuizPageStateImpl value,
          $Res Function(_$PlayDailyQuizPageStateImpl) then) =
      __$$PlayDailyQuizPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputQuizState quizState});
}

/// @nodoc
class __$$PlayDailyQuizPageStateImplCopyWithImpl<$Res>
    extends _$PlayDailyQuizPageStateCopyWithImpl<$Res,
        _$PlayDailyQuizPageStateImpl>
    implements _$$PlayDailyQuizPageStateImplCopyWith<$Res> {
  __$$PlayDailyQuizPageStateImplCopyWithImpl(
      _$PlayDailyQuizPageStateImpl _value,
      $Res Function(_$PlayDailyQuizPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizState = null,
  }) {
    return _then(_$PlayDailyQuizPageStateImpl(
      quizState: null == quizState
          ? _value.quizState
          : quizState // ignore: cast_nullable_to_non_nullable
              as InputQuizState,
    ));
  }
}

/// @nodoc

class _$PlayDailyQuizPageStateImpl implements _PlayDailyQuizPageState {
  const _$PlayDailyQuizPageStateImpl({required this.quizState});

  @override
  final InputQuizState quizState;

  @override
  String toString() {
    return 'PlayDailyQuizPageState(quizState: $quizState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayDailyQuizPageStateImpl &&
            (identical(other.quizState, quizState) ||
                other.quizState == quizState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quizState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayDailyQuizPageStateImplCopyWith<_$PlayDailyQuizPageStateImpl>
      get copyWith => __$$PlayDailyQuizPageStateImplCopyWithImpl<
          _$PlayDailyQuizPageStateImpl>(this, _$identity);
}

abstract class _PlayDailyQuizPageState implements PlayDailyQuizPageState {
  const factory _PlayDailyQuizPageState(
      {required final InputQuizState quizState}) = _$PlayDailyQuizPageStateImpl;

  @override
  InputQuizState get quizState;
  @override
  @JsonKey(ignore: true)
  _$$PlayDailyQuizPageStateImplCopyWith<_$PlayDailyQuizPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
