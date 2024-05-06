// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_condition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchCondition _$SearchConditionFromJson(Map<String, dynamic> json) {
  return _SearchCondition.fromJson(json);
}

/// @nodoc
mixin _$SearchCondition {
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchConditionCopyWith<SearchCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchConditionCopyWith<$Res> {
  factory $SearchConditionCopyWith(
          SearchCondition value, $Res Function(SearchCondition) then) =
      _$SearchConditionCopyWithImpl<$Res, SearchCondition>;
  @useResult
  $Res call(
      {@HiveField(0) List<String> teamList,
      @HiveField(1) int minGames,
      @HiveField(3) int minHits,
      @HiveField(4) int minHr,
      @HiveField(5) List<String> selectedStatsList});
}

/// @nodoc
class _$SearchConditionCopyWithImpl<$Res, $Val extends SearchCondition>
    implements $SearchConditionCopyWith<$Res> {
  _$SearchConditionCopyWithImpl(this._value, this._then);

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
abstract class _$$SearchConditionImplCopyWith<$Res>
    implements $SearchConditionCopyWith<$Res> {
  factory _$$SearchConditionImplCopyWith(_$SearchConditionImpl value,
          $Res Function(_$SearchConditionImpl) then) =
      __$$SearchConditionImplCopyWithImpl<$Res>;
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
class __$$SearchConditionImplCopyWithImpl<$Res>
    extends _$SearchConditionCopyWithImpl<$Res, _$SearchConditionImpl>
    implements _$$SearchConditionImplCopyWith<$Res> {
  __$$SearchConditionImplCopyWithImpl(
      _$SearchConditionImpl _value, $Res Function(_$SearchConditionImpl) _then)
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
    return _then(_$SearchConditionImpl(
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
@JsonSerializable()
class _$SearchConditionImpl extends _SearchCondition {
  const _$SearchConditionImpl(
      {@HiveField(0) required final List<String> teamList,
      @HiveField(1) required this.minGames,
      @HiveField(3) required this.minHits,
      @HiveField(4) required this.minHr,
      @HiveField(5) required final List<String> selectedStatsList})
      : _teamList = teamList,
        _selectedStatsList = selectedStatsList,
        super._();

  factory _$SearchConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchConditionImplFromJson(json);

  final List<String> _teamList;
  @override
  @HiveField(0)
  List<String> get teamList {
    if (_teamList is EqualUnmodifiableListView) return _teamList;
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
    if (_selectedStatsList is EqualUnmodifiableListView)
      return _selectedStatsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatsList);
  }

  @override
  String toString() {
    return 'SearchCondition(teamList: $teamList, minGames: $minGames, minHits: $minHits, minHr: $minHr, selectedStatsList: $selectedStatsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchConditionImpl &&
            const DeepCollectionEquality().equals(other._teamList, _teamList) &&
            (identical(other.minGames, minGames) ||
                other.minGames == minGames) &&
            (identical(other.minHits, minHits) || other.minHits == minHits) &&
            (identical(other.minHr, minHr) || other.minHr == minHr) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList));
  }

  @JsonKey(ignore: true)
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
  _$$SearchConditionImplCopyWith<_$SearchConditionImpl> get copyWith =>
      __$$SearchConditionImplCopyWithImpl<_$SearchConditionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchConditionImplToJson(
      this,
    );
  }
}

abstract class _SearchCondition extends SearchCondition {
  const factory _SearchCondition(
          {@HiveField(0) required final List<String> teamList,
          @HiveField(1) required final int minGames,
          @HiveField(3) required final int minHits,
          @HiveField(4) required final int minHr,
          @HiveField(5) required final List<String> selectedStatsList}) =
      _$SearchConditionImpl;
  const _SearchCondition._() : super._();

  factory _SearchCondition.fromJson(Map<String, dynamic> json) =
      _$SearchConditionImpl.fromJson;

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
  _$$SearchConditionImplCopyWith<_$SearchConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
