// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hitter_quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HitterQuizState {
  /// 回答となる [Hitter] の id.
  String get id => throw _privateConstructorUsedError;

  /// 回答となる [Hitter] の名前。
  String get name => throw _privateConstructorUsedError;

  /// ユーザーが回答として入力した [Hitter].
  Hitter? get enteredHitter => throw _privateConstructorUsedError;
  QuizType? get quizType => throw _privateConstructorUsedError;
  List<String> get yearList => throw _privateConstructorUsedError;
  List<String> get selectedStatsList => throw _privateConstructorUsedError;
  List<Map<String, StatsValue>> get statsMapList =>
      throw _privateConstructorUsedError;
  int get unveilCount => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get incorrectCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterQuizStateCopyWith<HitterQuizState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterQuizStateCopyWith<$Res> {
  factory $HitterQuizStateCopyWith(
          HitterQuizState value, $Res Function(HitterQuizState) then) =
      _$HitterQuizStateCopyWithImpl<$Res, HitterQuizState>;
  @useResult
  $Res call(
      {String id,
      String name,
      Hitter? enteredHitter,
      QuizType? quizType,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      bool isCorrect,
      int incorrectCount});

  $HitterCopyWith<$Res>? get enteredHitter;
}

/// @nodoc
class _$HitterQuizStateCopyWithImpl<$Res, $Val extends HitterQuizState>
    implements $HitterQuizStateCopyWith<$Res> {
  _$HitterQuizStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? enteredHitter = freezed,
    Object? quizType = freezed,
    Object? yearList = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? unveilCount = null,
    Object? isCorrect = null,
    Object? incorrectCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      enteredHitter: freezed == enteredHitter
          ? _value.enteredHitter
          : enteredHitter // ignore: cast_nullable_to_non_nullable
              as Hitter?,
      quizType: freezed == quizType
          ? _value.quizType
          : quizType // ignore: cast_nullable_to_non_nullable
              as QuizType?,
      yearList: null == yearList
          ? _value.yearList
          : yearList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedStatsList: null == selectedStatsList
          ? _value.selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      statsMapList: null == statsMapList
          ? _value.statsMapList
          : statsMapList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, StatsValue>>,
      unveilCount: null == unveilCount
          ? _value.unveilCount
          : unveilCount // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HitterCopyWith<$Res>? get enteredHitter {
    if (_value.enteredHitter == null) {
      return null;
    }

    return $HitterCopyWith<$Res>(_value.enteredHitter!, (value) {
      return _then(_value.copyWith(enteredHitter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HitterQuizStateImplCopyWith<$Res>
    implements $HitterQuizStateCopyWith<$Res> {
  factory _$$HitterQuizStateImplCopyWith(_$HitterQuizStateImpl value,
          $Res Function(_$HitterQuizStateImpl) then) =
      __$$HitterQuizStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Hitter? enteredHitter,
      QuizType? quizType,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      bool isCorrect,
      int incorrectCount});

  @override
  $HitterCopyWith<$Res>? get enteredHitter;
}

/// @nodoc
class __$$HitterQuizStateImplCopyWithImpl<$Res>
    extends _$HitterQuizStateCopyWithImpl<$Res, _$HitterQuizStateImpl>
    implements _$$HitterQuizStateImplCopyWith<$Res> {
  __$$HitterQuizStateImplCopyWithImpl(
      _$HitterQuizStateImpl _value, $Res Function(_$HitterQuizStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? enteredHitter = freezed,
    Object? quizType = freezed,
    Object? yearList = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? unveilCount = null,
    Object? isCorrect = null,
    Object? incorrectCount = null,
  }) {
    return _then(_$HitterQuizStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      enteredHitter: freezed == enteredHitter
          ? _value.enteredHitter
          : enteredHitter // ignore: cast_nullable_to_non_nullable
              as Hitter?,
      quizType: freezed == quizType
          ? _value.quizType
          : quizType // ignore: cast_nullable_to_non_nullable
              as QuizType?,
      yearList: null == yearList
          ? _value._yearList
          : yearList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedStatsList: null == selectedStatsList
          ? _value._selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      statsMapList: null == statsMapList
          ? _value._statsMapList
          : statsMapList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, StatsValue>>,
      unveilCount: null == unveilCount
          ? _value.unveilCount
          : unveilCount // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HitterQuizStateImpl extends _HitterQuizState {
  const _$HitterQuizStateImpl(
      {required this.id,
      required this.name,
      required this.enteredHitter,
      required this.quizType,
      required final List<String> yearList,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required this.unveilCount,
      required this.isCorrect,
      required this.incorrectCount})
      : _yearList = yearList,
        _selectedStatsList = selectedStatsList,
        _statsMapList = statsMapList,
        super._();

  /// 回答となる [Hitter] の id.
  @override
  final String id;

  /// 回答となる [Hitter] の名前。
  @override
  final String name;

  /// ユーザーが回答として入力した [Hitter].
  @override
  final Hitter? enteredHitter;
  @override
  final QuizType? quizType;
  final List<String> _yearList;
  @override
  List<String> get yearList {
    if (_yearList is EqualUnmodifiableListView) return _yearList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearList);
  }

  final List<String> _selectedStatsList;
  @override
  List<String> get selectedStatsList {
    if (_selectedStatsList is EqualUnmodifiableListView)
      return _selectedStatsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  final List<Map<String, StatsValue>> _statsMapList;
  @override
  List<Map<String, StatsValue>> get statsMapList {
    if (_statsMapList is EqualUnmodifiableListView) return _statsMapList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statsMapList);
  }

  @override
  final int unveilCount;
  @override
  final bool isCorrect;
  @override
  final int incorrectCount;

  @override
  String toString() {
    return 'HitterQuizState(id: $id, name: $name, enteredHitter: $enteredHitter, quizType: $quizType, yearList: $yearList, selectedStatsList: $selectedStatsList, statsMapList: $statsMapList, unveilCount: $unveilCount, isCorrect: $isCorrect, incorrectCount: $incorrectCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HitterQuizStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.enteredHitter, enteredHitter) ||
                other.enteredHitter == enteredHitter) &&
            (identical(other.quizType, quizType) ||
                other.quizType == quizType) &&
            const DeepCollectionEquality().equals(other._yearList, _yearList) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList) &&
            const DeepCollectionEquality()
                .equals(other._statsMapList, _statsMapList) &&
            (identical(other.unveilCount, unveilCount) ||
                other.unveilCount == unveilCount) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      enteredHitter,
      quizType,
      const DeepCollectionEquality().hash(_yearList),
      const DeepCollectionEquality().hash(_selectedStatsList),
      const DeepCollectionEquality().hash(_statsMapList),
      unveilCount,
      isCorrect,
      incorrectCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HitterQuizStateImplCopyWith<_$HitterQuizStateImpl> get copyWith =>
      __$$HitterQuizStateImplCopyWithImpl<_$HitterQuizStateImpl>(
          this, _$identity);
}

abstract class _HitterQuizState extends HitterQuizState {
  const factory _HitterQuizState(
      {required final String id,
      required final String name,
      required final Hitter? enteredHitter,
      required final QuizType? quizType,
      required final List<String> yearList,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required final int unveilCount,
      required final bool isCorrect,
      required final int incorrectCount}) = _$HitterQuizStateImpl;
  const _HitterQuizState._() : super._();

  @override

  /// 回答となる [Hitter] の id.
  String get id;
  @override

  /// 回答となる [Hitter] の名前。
  String get name;
  @override

  /// ユーザーが回答として入力した [Hitter].
  Hitter? get enteredHitter;
  @override
  QuizType? get quizType;
  @override
  List<String> get yearList;
  @override
  List<String> get selectedStatsList;
  @override
  List<Map<String, StatsValue>> get statsMapList;
  @override
  int get unveilCount;
  @override
  bool get isCorrect;
  @override
  int get incorrectCount;
  @override
  @JsonKey(ignore: true)
  _$$HitterQuizStateImplCopyWith<_$HitterQuizStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
