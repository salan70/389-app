// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_setting_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizSettingPageState {
  SearchCondition get searchCondition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizSettingPageStateCopyWith<QuizSettingPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizSettingPageStateCopyWith<$Res> {
  factory $QuizSettingPageStateCopyWith(QuizSettingPageState value,
          $Res Function(QuizSettingPageState) then) =
      _$QuizSettingPageStateCopyWithImpl<$Res, QuizSettingPageState>;
  @useResult
  $Res call({SearchCondition searchCondition});
}

/// @nodoc
class _$QuizSettingPageStateCopyWithImpl<$Res,
        $Val extends QuizSettingPageState>
    implements $QuizSettingPageStateCopyWith<$Res> {
  _$QuizSettingPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchCondition = null,
  }) {
    return _then(_value.copyWith(
      searchCondition: null == searchCondition
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as SearchCondition,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizSettingPageStateImplCopyWith<$Res>
    implements $QuizSettingPageStateCopyWith<$Res> {
  factory _$$QuizSettingPageStateImplCopyWith(_$QuizSettingPageStateImpl value,
          $Res Function(_$QuizSettingPageStateImpl) then) =
      __$$QuizSettingPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SearchCondition searchCondition});
}

/// @nodoc
class __$$QuizSettingPageStateImplCopyWithImpl<$Res>
    extends _$QuizSettingPageStateCopyWithImpl<$Res, _$QuizSettingPageStateImpl>
    implements _$$QuizSettingPageStateImplCopyWith<$Res> {
  __$$QuizSettingPageStateImplCopyWithImpl(_$QuizSettingPageStateImpl _value,
      $Res Function(_$QuizSettingPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchCondition = null,
  }) {
    return _then(_$QuizSettingPageStateImpl(
      searchCondition: null == searchCondition
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as SearchCondition,
    ));
  }
}

/// @nodoc

class _$QuizSettingPageStateImpl implements _QuizSettingPageState {
  const _$QuizSettingPageStateImpl({required this.searchCondition});

  @override
  final SearchCondition searchCondition;

  @override
  String toString() {
    return 'QuizSettingPageState(searchCondition: $searchCondition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizSettingPageStateImpl &&
            (identical(other.searchCondition, searchCondition) ||
                other.searchCondition == searchCondition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchCondition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizSettingPageStateImplCopyWith<_$QuizSettingPageStateImpl>
      get copyWith =>
          __$$QuizSettingPageStateImplCopyWithImpl<_$QuizSettingPageStateImpl>(
              this, _$identity);
}

abstract class _QuizSettingPageState implements QuizSettingPageState {
  const factory _QuizSettingPageState(
          {required final SearchCondition searchCondition}) =
      _$QuizSettingPageStateImpl;

  @override
  SearchCondition get searchCondition;
  @override
  @JsonKey(ignore: true)
  _$$QuizSettingPageStateImplCopyWith<_$QuizSettingPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
