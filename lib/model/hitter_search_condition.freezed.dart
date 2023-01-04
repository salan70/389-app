// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_search_condition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HitterSearchCondition {
  List<String> get teamList => throw _privateConstructorUsedError;
  int get minGames => throw _privateConstructorUsedError;
  int get minHits => throw _privateConstructorUsedError;
  int get minHr => throw _privateConstructorUsedError; // pa: 打席数
  List<StatsType> get selectedStatsList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterSearchConditionCopyWith<HitterSearchCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterSearchConditionCopyWith<$Res> {
  factory $HitterSearchConditionCopyWith(HitterSearchCondition value,
          $Res Function(HitterSearchCondition) then) =
      _$HitterSearchConditionCopyWithImpl<$Res, HitterSearchCondition>;
  @useResult
  $Res call(
      {List<String> teamList,
      int minGames,
      int minHits,
      int minHr,
      List<StatsType> selectedStatsList});
}

/// @nodoc
class _$HitterSearchConditionCopyWithImpl<$Res,
        $Val extends HitterSearchCondition>
    implements $HitterSearchConditionCopyWith<$Res> {
  _$HitterSearchConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamList = null,
    Object? minGames = null,
    Object? minHits = null,
    Object? minHr = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_value.copyWith(
      teamList: null == teamList
          ? _value.teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minGames: null == minGames
          ? _value.minGames
          : minGames // ignore: cast_nullable_to_non_nullable
              as int,
      minHits: null == minHits
          ? _value.minHits
          : minHits // ignore: cast_nullable_to_non_nullable
              as int,
      minHr: null == minHr
          ? _value.minHr
          : minHr // ignore: cast_nullable_to_non_nullable
              as int,
      selectedStatsList: null == selectedStatsList
          ? _value.selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<StatsType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HitterSearchConditionCopyWith<$Res>
    implements $HitterSearchConditionCopyWith<$Res> {
  factory _$$_HitterSearchConditionCopyWith(_$_HitterSearchCondition value,
          $Res Function(_$_HitterSearchCondition) then) =
      __$$_HitterSearchConditionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> teamList,
      int minGames,
      int minHits,
      int minHr,
      List<StatsType> selectedStatsList});
}

/// @nodoc
class __$$_HitterSearchConditionCopyWithImpl<$Res>
    extends _$HitterSearchConditionCopyWithImpl<$Res, _$_HitterSearchCondition>
    implements _$$_HitterSearchConditionCopyWith<$Res> {
  __$$_HitterSearchConditionCopyWithImpl(_$_HitterSearchCondition _value,
      $Res Function(_$_HitterSearchCondition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamList = null,
    Object? minGames = null,
    Object? minHits = null,
    Object? minHr = null,
    Object? selectedStatsList = null,
  }) {
    return _then(_$_HitterSearchCondition(
      teamList: null == teamList
          ? _value._teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minGames: null == minGames
          ? _value.minGames
          : minGames // ignore: cast_nullable_to_non_nullable
              as int,
      minHits: null == minHits
          ? _value.minHits
          : minHits // ignore: cast_nullable_to_non_nullable
              as int,
      minHr: null == minHr
          ? _value.minHr
          : minHr // ignore: cast_nullable_to_non_nullable
              as int,
      selectedStatsList: null == selectedStatsList
          ? _value._selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<StatsType>,
    ));
  }
}

/// @nodoc

class _$_HitterSearchCondition implements _HitterSearchCondition {
  const _$_HitterSearchCondition(
      {required final List<String> teamList,
      required this.minGames,
      required this.minHits,
      required this.minHr,
      required final List<StatsType> selectedStatsList})
      : _teamList = teamList,
        _selectedStatsList = selectedStatsList;

  final List<String> _teamList;
  @override
  List<String> get teamList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamList);
  }

  @override
  final int minGames;
  @override
  final int minHits;
  @override
  final int minHr;
// pa: 打席数
  final List<StatsType> _selectedStatsList;
// pa: 打席数
  @override
  List<StatsType> get selectedStatsList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  @override
  String toString() {
    return 'HitterSearchCondition(teamList: $teamList, minGames: $minGames, minHits: $minHits, minHr: $minHr, selectedStatsList: $selectedStatsList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterSearchCondition &&
            const DeepCollectionEquality().equals(other._teamList, _teamList) &&
            (identical(other.minGames, minGames) ||
                other.minGames == minGames) &&
            (identical(other.minHits, minHits) || other.minHits == minHits) &&
            (identical(other.minHr, minHr) || other.minHr == minHr) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_teamList),
      minGames,
      minHits,
      minHr,
      const DeepCollectionEquality().hash(_selectedStatsList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterSearchConditionCopyWith<_$_HitterSearchCondition> get copyWith =>
      __$$_HitterSearchConditionCopyWithImpl<_$_HitterSearchCondition>(
          this, _$identity);
}

abstract class _HitterSearchCondition implements HitterSearchCondition {
  const factory _HitterSearchCondition(
          {required final List<String> teamList,
          required final int minGames,
          required final int minHits,
          required final int minHr,
          required final List<StatsType> selectedStatsList}) =
      _$_HitterSearchCondition;

  @override
  List<String> get teamList;
  @override
  int get minGames;
  @override
  int get minHits;
  @override
  int get minHr;
  @override // pa: 打席数
  List<StatsType> get selectedStatsList;
  @override
  @JsonKey(ignore: true)
  _$$_HitterSearchConditionCopyWith<_$_HitterSearchCondition> get copyWith =>
      throw _privateConstructorUsedError;
}
