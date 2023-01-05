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
  @HiveField(0)
  List<String> get teamList => throw _privateConstructorUsedError;
  @HiveField(1)
  int get minGames => throw _privateConstructorUsedError;
  @HiveField(3)
  int get minHits => throw _privateConstructorUsedError;
  @HiveField(4)
  int get minHr => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get selectedStatsList => throw _privateConstructorUsedError;

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
      {@HiveField(0) List<String> teamList,
      @HiveField(1) int minGames,
      @HiveField(3) int minHits,
      @HiveField(4) int minHr,
      @HiveField(5) List<String> selectedStatsList});
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
              as List<String>,
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
      {@HiveField(0) List<String> teamList,
      @HiveField(1) int minGames,
      @HiveField(3) int minHits,
      @HiveField(4) int minHr,
      @HiveField(5) List<String> selectedStatsList});
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
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_HitterSearchCondition implements _HitterSearchCondition {
  const _$_HitterSearchCondition(
      {@HiveField(0) required final List<String> teamList,
      @HiveField(1) required this.minGames,
      @HiveField(3) required this.minHits,
      @HiveField(4) required this.minHr,
      @HiveField(5) required final List<String> selectedStatsList})
      : _teamList = teamList,
        _selectedStatsList = selectedStatsList;

  final List<String> _teamList;
  @override
  @HiveField(0)
  List<String> get teamList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamList);
  }

  @override
  @HiveField(1)
  final int minGames;
  @override
  @HiveField(3)
  final int minHits;
  @override
  @HiveField(4)
  final int minHr;
  final List<String> _selectedStatsList;
  @override
  @HiveField(5)
  List<String> get selectedStatsList {
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
          {@HiveField(0) required final List<String> teamList,
          @HiveField(1) required final int minGames,
          @HiveField(3) required final int minHits,
          @HiveField(4) required final int minHr,
          @HiveField(5) required final List<String> selectedStatsList}) =
      _$_HitterSearchCondition;

  @override
  @HiveField(0)
  List<String> get teamList;
  @override
  @HiveField(1)
  int get minGames;
  @override
  @HiveField(3)
  int get minHits;
  @override
  @HiveField(4)
  int get minHr;
  @override
  @HiveField(5)
  List<String> get selectedStatsList;
  @override
  @JsonKey(ignore: true)
  _$$_HitterSearchConditionCopyWith<_$_HitterSearchCondition> get copyWith =>
      throw _privateConstructorUsedError;
}
