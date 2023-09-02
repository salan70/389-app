// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HitterQuizResult _$HitterQuizResultFromJson(Map<String, dynamic> json) {
  return _HitterQuizResult.fromJson(json);
}

/// @nodoc
mixin _$HitterQuizResult {
  @JsonKey(name: 'playerId')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'playerName')
  String get name => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<String> get yearList => throw _privateConstructorUsedError;
  List<String> get selectedStatsList => throw _privateConstructorUsedError;
  List<Map<String, StatsValue>> get statsMapList =>
      throw _privateConstructorUsedError;
  int get unveilCount => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get incorrectCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {@JsonKey(name: 'playerId') String id,
      @JsonKey(name: 'playerName') String name,
      @DateTimeConverter() DateTime updatedAt,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      bool isCorrect,
      int incorrectCount});
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
    Object? id = null,
    Object? name = null,
    Object? updatedAt = null,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
}

/// @nodoc
abstract class _$$_HitterQuizResultCopyWith<$Res>
    implements $HitterQuizResultCopyWith<$Res> {
  factory _$$_HitterQuizResultCopyWith(
          _$_HitterQuizResult value, $Res Function(_$_HitterQuizResult) then) =
      __$$_HitterQuizResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'playerId') String id,
      @JsonKey(name: 'playerName') String name,
      @DateTimeConverter() DateTime updatedAt,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      bool isCorrect,
      int incorrectCount});
}

/// @nodoc
class __$$_HitterQuizResultCopyWithImpl<$Res>
    extends _$HitterQuizResultCopyWithImpl<$Res, _$_HitterQuizResult>
    implements _$$_HitterQuizResultCopyWith<$Res> {
  __$$_HitterQuizResultCopyWithImpl(
      _$_HitterQuizResult _value, $Res Function(_$_HitterQuizResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? updatedAt = null,
    Object? yearList = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? unveilCount = null,
    Object? isCorrect = null,
    Object? incorrectCount = null,
  }) {
    return _then(_$_HitterQuizResult(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
@JsonSerializable()
class _$_HitterQuizResult extends _HitterQuizResult {
  const _$_HitterQuizResult(
      {@JsonKey(name: 'playerId') required this.id,
      @JsonKey(name: 'playerName') required this.name,
      @DateTimeConverter() required this.updatedAt,
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

  factory _$_HitterQuizResult.fromJson(Map<String, dynamic> json) =>
      _$$_HitterQuizResultFromJson(json);

  @override
  @JsonKey(name: 'playerId')
  final String id;
  @override
  @JsonKey(name: 'playerName')
  final String name;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;
  final List<String> _yearList;
  @override
  List<String> get yearList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearList);
  }

  final List<String> _selectedStatsList;
  @override
  List<String> get selectedStatsList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  final List<Map<String, StatsValue>> _statsMapList;
  @override
  List<Map<String, StatsValue>> get statsMapList {
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
    return 'HitterQuizResult(id: $id, name: $name, updatedAt: $updatedAt, yearList: $yearList, selectedStatsList: $selectedStatsList, statsMapList: $statsMapList, unveilCount: $unveilCount, isCorrect: $isCorrect, incorrectCount: $incorrectCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterQuizResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      updatedAt,
      const DeepCollectionEquality().hash(_yearList),
      const DeepCollectionEquality().hash(_selectedStatsList),
      const DeepCollectionEquality().hash(_statsMapList),
      unveilCount,
      isCorrect,
      incorrectCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterQuizResultCopyWith<_$_HitterQuizResult> get copyWith =>
      __$$_HitterQuizResultCopyWithImpl<_$_HitterQuizResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HitterQuizResultToJson(
      this,
    );
  }
}

abstract class _HitterQuizResult extends HitterQuizResult {
  const factory _HitterQuizResult(
      {@JsonKey(name: 'playerId') required final String id,
      @JsonKey(name: 'playerName') required final String name,
      @DateTimeConverter() required final DateTime updatedAt,
      required final List<String> yearList,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required final int unveilCount,
      required final bool isCorrect,
      required final int incorrectCount}) = _$_HitterQuizResult;
  const _HitterQuizResult._() : super._();

  factory _HitterQuizResult.fromJson(Map<String, dynamic> json) =
      _$_HitterQuizResult.fromJson;

  @override
  @JsonKey(name: 'playerId')
  String get id;
  @override
  @JsonKey(name: 'playerName')
  String get name;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
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
  _$$_HitterQuizResultCopyWith<_$_HitterQuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}
