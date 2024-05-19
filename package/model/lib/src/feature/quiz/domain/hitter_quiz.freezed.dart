// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hitter_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HitterQuiz {
  /// 回答となる [Hitter] の id.
  String get hitterId => throw _privateConstructorUsedError;

  /// 回答となる [Hitter] の名前。
  String get hitterName => throw _privateConstructorUsedError;

  /// クイズの対象となる年度のリスト。
  List<String> get yearList => throw _privateConstructorUsedError;

  /// クイズの対象となる成績の種類リスト。
  ///
  /// 例: ['打率', '本塁打', '打点', '盗塁']
  List<String> get selectedStatsList => throw _privateConstructorUsedError;

  /// クイズの対象となる成績の値のリスト。
  List<Map<String, StatsValue>> get statsMapList =>
      throw _privateConstructorUsedError;

  /// 公開された成績の数。
  int get unveilCount => throw _privateConstructorUsedError;

  /// 不正解した回数。
  int get incorrectCount => throw _privateConstructorUsedError;

  /// 対象となるシーズンの種類。
  SeasonType get seasonType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterQuizCopyWith<HitterQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterQuizCopyWith<$Res> {
  factory $HitterQuizCopyWith(
          HitterQuiz value, $Res Function(HitterQuiz) then) =
      _$HitterQuizCopyWithImpl<$Res, HitterQuiz>;
  @useResult
  $Res call(
      {String hitterId,
      String hitterName,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      int incorrectCount,
      SeasonType seasonType});
}

/// @nodoc
class _$HitterQuizCopyWithImpl<$Res, $Val extends HitterQuiz>
    implements $HitterQuizCopyWith<$Res> {
  _$HitterQuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hitterId = null,
    Object? hitterName = null,
    Object? yearList = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? unveilCount = null,
    Object? incorrectCount = null,
    Object? seasonType = null,
  }) {
    return _then(_value.copyWith(
      hitterId: null == hitterId
          ? _value.hitterId
          : hitterId // ignore: cast_nullable_to_non_nullable
              as String,
      hitterName: null == hitterName
          ? _value.hitterName
          : hitterName // ignore: cast_nullable_to_non_nullable
              as String,
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
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      seasonType: null == seasonType
          ? _value.seasonType
          : seasonType // ignore: cast_nullable_to_non_nullable
              as SeasonType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HitterQuizImplCopyWith<$Res>
    implements $HitterQuizCopyWith<$Res> {
  factory _$$HitterQuizImplCopyWith(
          _$HitterQuizImpl value, $Res Function(_$HitterQuizImpl) then) =
      __$$HitterQuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String hitterId,
      String hitterName,
      List<String> yearList,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      int unveilCount,
      int incorrectCount,
      SeasonType seasonType});
}

/// @nodoc
class __$$HitterQuizImplCopyWithImpl<$Res>
    extends _$HitterQuizCopyWithImpl<$Res, _$HitterQuizImpl>
    implements _$$HitterQuizImplCopyWith<$Res> {
  __$$HitterQuizImplCopyWithImpl(
      _$HitterQuizImpl _value, $Res Function(_$HitterQuizImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hitterId = null,
    Object? hitterName = null,
    Object? yearList = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? unveilCount = null,
    Object? incorrectCount = null,
    Object? seasonType = null,
  }) {
    return _then(_$HitterQuizImpl(
      hitterId: null == hitterId
          ? _value.hitterId
          : hitterId // ignore: cast_nullable_to_non_nullable
              as String,
      hitterName: null == hitterName
          ? _value.hitterName
          : hitterName // ignore: cast_nullable_to_non_nullable
              as String,
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
      incorrectCount: null == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int,
      seasonType: null == seasonType
          ? _value.seasonType
          : seasonType // ignore: cast_nullable_to_non_nullable
              as SeasonType,
    ));
  }
}

/// @nodoc

class _$HitterQuizImpl extends _HitterQuiz {
  const _$HitterQuizImpl(
      {required this.hitterId,
      required this.hitterName,
      required final List<String> yearList,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required this.unveilCount,
      required this.incorrectCount,
      required this.seasonType})
      : _yearList = yearList,
        _selectedStatsList = selectedStatsList,
        _statsMapList = statsMapList,
        super._();

  /// 回答となる [Hitter] の id.
  @override
  final String hitterId;

  /// 回答となる [Hitter] の名前。
  @override
  final String hitterName;

  /// クイズの対象となる年度のリスト。
  final List<String> _yearList;

  /// クイズの対象となる年度のリスト。
  @override
  List<String> get yearList {
    if (_yearList is EqualUnmodifiableListView) return _yearList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearList);
  }

  /// クイズの対象となる成績の種類リスト。
  ///
  /// 例: ['打率', '本塁打', '打点', '盗塁']
  final List<String> _selectedStatsList;

  /// クイズの対象となる成績の種類リスト。
  ///
  /// 例: ['打率', '本塁打', '打点', '盗塁']
  @override
  List<String> get selectedStatsList {
    if (_selectedStatsList is EqualUnmodifiableListView)
      return _selectedStatsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  /// クイズの対象となる成績の値のリスト。
  final List<Map<String, StatsValue>> _statsMapList;

  /// クイズの対象となる成績の値のリスト。
  @override
  List<Map<String, StatsValue>> get statsMapList {
    if (_statsMapList is EqualUnmodifiableListView) return _statsMapList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statsMapList);
  }

  /// 公開された成績の数。
  @override
  final int unveilCount;

  /// 不正解した回数。
  @override
  final int incorrectCount;

  /// 対象となるシーズンの種類。
  @override
  final SeasonType seasonType;

  @override
  String toString() {
    return 'HitterQuiz(hitterId: $hitterId, hitterName: $hitterName, yearList: $yearList, selectedStatsList: $selectedStatsList, statsMapList: $statsMapList, unveilCount: $unveilCount, incorrectCount: $incorrectCount, seasonType: $seasonType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HitterQuizImpl &&
            (identical(other.hitterId, hitterId) ||
                other.hitterId == hitterId) &&
            (identical(other.hitterName, hitterName) ||
                other.hitterName == hitterName) &&
            const DeepCollectionEquality().equals(other._yearList, _yearList) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList) &&
            const DeepCollectionEquality()
                .equals(other._statsMapList, _statsMapList) &&
            (identical(other.unveilCount, unveilCount) ||
                other.unveilCount == unveilCount) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount) &&
            (identical(other.seasonType, seasonType) ||
                other.seasonType == seasonType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      hitterId,
      hitterName,
      const DeepCollectionEquality().hash(_yearList),
      const DeepCollectionEquality().hash(_selectedStatsList),
      const DeepCollectionEquality().hash(_statsMapList),
      unveilCount,
      incorrectCount,
      seasonType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HitterQuizImplCopyWith<_$HitterQuizImpl> get copyWith =>
      __$$HitterQuizImplCopyWithImpl<_$HitterQuizImpl>(this, _$identity);
}

abstract class _HitterQuiz extends HitterQuiz {
  const factory _HitterQuiz(
      {required final String hitterId,
      required final String hitterName,
      required final List<String> yearList,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required final int unveilCount,
      required final int incorrectCount,
      required final SeasonType seasonType}) = _$HitterQuizImpl;
  const _HitterQuiz._() : super._();

  @override

  /// 回答となる [Hitter] の id.
  String get hitterId;
  @override

  /// 回答となる [Hitter] の名前。
  String get hitterName;
  @override

  /// クイズの対象となる年度のリスト。
  List<String> get yearList;
  @override

  /// クイズの対象となる成績の種類リスト。
  ///
  /// 例: ['打率', '本塁打', '打点', '盗塁']
  List<String> get selectedStatsList;
  @override

  /// クイズの対象となる成績の値のリスト。
  List<Map<String, StatsValue>> get statsMapList;
  @override

  /// 公開された成績の数。
  int get unveilCount;
  @override

  /// 不正解した回数。
  int get incorrectCount;
  @override

  /// 対象となるシーズンの種類。
  SeasonType get seasonType;
  @override
  @JsonKey(ignore: true)
  _$$HitterQuizImplCopyWith<_$HitterQuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
