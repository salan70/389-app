// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyQuiz {
  String get dailyQuizId => throw _privateConstructorUsedError;
  DateTime get questionedAt => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  List<String> get selectedStatsList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyQuizCopyWith<DailyQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyQuizCopyWith<$Res> {
  factory $DailyQuizCopyWith(DailyQuiz value, $Res Function(DailyQuiz) then) =
      _$DailyQuizCopyWithImpl<$Res, DailyQuiz>;
  @useResult
  $Res call(
      {String dailyQuizId,
      DateTime questionedAt,
      String playerId,
      List<String> selectedStatsList});
}

/// @nodoc
class _$DailyQuizCopyWithImpl<$Res, $Val extends DailyQuiz>
    implements $DailyQuizCopyWith<$Res> {
  _$DailyQuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyQuizId = null,
    Object? questionedAt = null,
    Object? playerId = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_value.copyWith(
      dailyQuizId: null == dailyQuizId
          ? _value.dailyQuizId
          : dailyQuizId // ignore: cast_nullable_to_non_nullable
              as String,
      questionedAt: null == questionedAt
          ? _value.questionedAt
          : questionedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      selectedStatsList: null == selectedStatsList
          ? _value.selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyQuizImplCopyWith<$Res>
    implements $DailyQuizCopyWith<$Res> {
  factory _$$DailyQuizImplCopyWith(
          _$DailyQuizImpl value, $Res Function(_$DailyQuizImpl) then) =
      __$$DailyQuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dailyQuizId,
      DateTime questionedAt,
      String playerId,
      List<String> selectedStatsList});
}

/// @nodoc
class __$$DailyQuizImplCopyWithImpl<$Res>
    extends _$DailyQuizCopyWithImpl<$Res, _$DailyQuizImpl>
    implements _$$DailyQuizImplCopyWith<$Res> {
  __$$DailyQuizImplCopyWithImpl(
      _$DailyQuizImpl _value, $Res Function(_$DailyQuizImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyQuizId = null,
    Object? questionedAt = null,
    Object? playerId = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_$DailyQuizImpl(
      dailyQuizId: null == dailyQuizId
          ? _value.dailyQuizId
          : dailyQuizId // ignore: cast_nullable_to_non_nullable
              as String,
      questionedAt: null == questionedAt
          ? _value.questionedAt
          : questionedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      selectedStatsList: null == selectedStatsList
          ? _value._selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DailyQuizImpl implements _DailyQuiz {
  const _$DailyQuizImpl(
      {required this.dailyQuizId,
      required this.questionedAt,
      required this.playerId,
      required final List<String> selectedStatsList})
      : _selectedStatsList = selectedStatsList;

  @override
  final String dailyQuizId;
  @override
  final DateTime questionedAt;
  @override
  final String playerId;
  final List<String> _selectedStatsList;
  @override
  List<String> get selectedStatsList {
    if (_selectedStatsList is EqualUnmodifiableListView)
      return _selectedStatsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  @override
  String toString() {
    return 'DailyQuiz(dailyQuizId: $dailyQuizId, questionedAt: $questionedAt, playerId: $playerId, selectedStatsList: $selectedStatsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyQuizImpl &&
            (identical(other.dailyQuizId, dailyQuizId) ||
                other.dailyQuizId == dailyQuizId) &&
            (identical(other.questionedAt, questionedAt) ||
                other.questionedAt == questionedAt) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyQuizId, questionedAt,
      playerId, const DeepCollectionEquality().hash(_selectedStatsList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      __$$DailyQuizImplCopyWithImpl<_$DailyQuizImpl>(this, _$identity);
}

abstract class _DailyQuiz implements DailyQuiz {
  const factory _DailyQuiz(
      {required final String dailyQuizId,
      required final DateTime questionedAt,
      required final String playerId,
      required final List<String> selectedStatsList}) = _$DailyQuizImpl;

  @override
  String get dailyQuizId;
  @override
  DateTime get questionedAt;
  @override
  String get playerId;
  @override
  List<String> get selectedStatsList;
  @override
  @JsonKey(ignore: true)
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
