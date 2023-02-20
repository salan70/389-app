// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'daily_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyQuiz {
  String get dailyQuizId => throw _privateConstructorUsedError;
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
      {String dailyQuizId, String playerId, List<String> selectedStatsList});
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
    Object? playerId = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_value.copyWith(
      dailyQuizId: null == dailyQuizId
          ? _value.dailyQuizId
          : dailyQuizId // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_DailyQuizCopyWith<$Res> implements $DailyQuizCopyWith<$Res> {
  factory _$$_DailyQuizCopyWith(
          _$_DailyQuiz value, $Res Function(_$_DailyQuiz) then) =
      __$$_DailyQuizCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dailyQuizId, String playerId, List<String> selectedStatsList});
}

/// @nodoc
class __$$_DailyQuizCopyWithImpl<$Res>
    extends _$DailyQuizCopyWithImpl<$Res, _$_DailyQuiz>
    implements _$$_DailyQuizCopyWith<$Res> {
  __$$_DailyQuizCopyWithImpl(
      _$_DailyQuiz _value, $Res Function(_$_DailyQuiz) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyQuizId = null,
    Object? playerId = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_$_DailyQuiz(
      dailyQuizId: null == dailyQuizId
          ? _value.dailyQuizId
          : dailyQuizId // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$_DailyQuiz implements _DailyQuiz {
  const _$_DailyQuiz(
      {required this.dailyQuizId,
      required this.playerId,
      required final List<String> selectedStatsList})
      : _selectedStatsList = selectedStatsList;

  @override
  final String dailyQuizId;
  @override
  final String playerId;
  final List<String> _selectedStatsList;
  @override
  List<String> get selectedStatsList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  @override
  String toString() {
    return 'DailyQuiz(dailyQuizId: $dailyQuizId, playerId: $playerId, selectedStatsList: $selectedStatsList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyQuiz &&
            (identical(other.dailyQuizId, dailyQuizId) ||
                other.dailyQuizId == dailyQuizId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyQuizId, playerId,
      const DeepCollectionEquality().hash(_selectedStatsList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyQuizCopyWith<_$_DailyQuiz> get copyWith =>
      __$$_DailyQuizCopyWithImpl<_$_DailyQuiz>(this, _$identity);
}

abstract class _DailyQuiz implements DailyQuiz {
  const factory _DailyQuiz(
      {required final String dailyQuizId,
      required final String playerId,
      required final List<String> selectedStatsList}) = _$_DailyQuiz;

  @override
  String get dailyQuizId;
  @override
  String get playerId;
  @override
  List<String> get selectedStatsList;
  @override
  @JsonKey(ignore: true)
  _$$_DailyQuizCopyWith<_$_DailyQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}
