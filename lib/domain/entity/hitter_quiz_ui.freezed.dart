// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_quiz_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HitterQuizUi {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get selectedStatsList => throw _privateConstructorUsedError;
  List<Map<String, StatsValue>> get statsMapList =>
      throw _privateConstructorUsedError;
  List<String> get hiddenStatsIdList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterQuizUiCopyWith<HitterQuizUi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterQuizUiCopyWith<$Res> {
  factory $HitterQuizUiCopyWith(
          HitterQuizUi value, $Res Function(HitterQuizUi) then) =
      _$HitterQuizUiCopyWithImpl<$Res, HitterQuizUi>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      List<String> hiddenStatsIdList});
}

/// @nodoc
class _$HitterQuizUiCopyWithImpl<$Res, $Val extends HitterQuizUi>
    implements $HitterQuizUiCopyWith<$Res> {
  _$HitterQuizUiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? hiddenStatsIdList = null,
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
      selectedStatsList: null == selectedStatsList
          ? _value.selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      statsMapList: null == statsMapList
          ? _value.statsMapList
          : statsMapList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, StatsValue>>,
      hiddenStatsIdList: null == hiddenStatsIdList
          ? _value.hiddenStatsIdList
          : hiddenStatsIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HitterQuizUiCopyWith<$Res>
    implements $HitterQuizUiCopyWith<$Res> {
  factory _$$_HitterQuizUiCopyWith(
          _$_HitterQuizUi value, $Res Function(_$_HitterQuizUi) then) =
      __$$_HitterQuizUiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> selectedStatsList,
      List<Map<String, StatsValue>> statsMapList,
      List<String> hiddenStatsIdList});
}

/// @nodoc
class __$$_HitterQuizUiCopyWithImpl<$Res>
    extends _$HitterQuizUiCopyWithImpl<$Res, _$_HitterQuizUi>
    implements _$$_HitterQuizUiCopyWith<$Res> {
  __$$_HitterQuizUiCopyWithImpl(
      _$_HitterQuizUi _value, $Res Function(_$_HitterQuizUi) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? selectedStatsList = null,
    Object? statsMapList = null,
    Object? hiddenStatsIdList = null,
  }) {
    return _then(_$_HitterQuizUi(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      selectedStatsList: null == selectedStatsList
          ? _value._selectedStatsList
          : selectedStatsList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      statsMapList: null == statsMapList
          ? _value._statsMapList
          : statsMapList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, StatsValue>>,
      hiddenStatsIdList: null == hiddenStatsIdList
          ? _value._hiddenStatsIdList
          : hiddenStatsIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_HitterQuizUi implements _HitterQuizUi {
  const _$_HitterQuizUi(
      {required this.id,
      required this.name,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required final List<String> hiddenStatsIdList})
      : _selectedStatsList = selectedStatsList,
        _statsMapList = statsMapList,
        _hiddenStatsIdList = hiddenStatsIdList;

  @override
  final String id;
  @override
  final String name;
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

  final List<String> _hiddenStatsIdList;
  @override
  List<String> get hiddenStatsIdList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hiddenStatsIdList);
  }

  @override
  String toString() {
    return 'HitterQuizUi(id: $id, name: $name, selectedStatsList: $selectedStatsList, statsMapList: $statsMapList, hiddenStatsIdList: $hiddenStatsIdList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterQuizUi &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatsList, _selectedStatsList) &&
            const DeepCollectionEquality()
                .equals(other._statsMapList, _statsMapList) &&
            const DeepCollectionEquality()
                .equals(other._hiddenStatsIdList, _hiddenStatsIdList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_selectedStatsList),
      const DeepCollectionEquality().hash(_statsMapList),
      const DeepCollectionEquality().hash(_hiddenStatsIdList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterQuizUiCopyWith<_$_HitterQuizUi> get copyWith =>
      __$$_HitterQuizUiCopyWithImpl<_$_HitterQuizUi>(this, _$identity);
}

abstract class _HitterQuizUi implements HitterQuizUi {
  const factory _HitterQuizUi(
      {required final String id,
      required final String name,
      required final List<String> selectedStatsList,
      required final List<Map<String, StatsValue>> statsMapList,
      required final List<String> hiddenStatsIdList}) = _$_HitterQuizUi;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get selectedStatsList;
  @override
  List<Map<String, StatsValue>> get statsMapList;
  @override
  List<String> get hiddenStatsIdList;
  @override
  @JsonKey(ignore: true)
  _$$_HitterQuizUiCopyWith<_$_HitterQuizUi> get copyWith =>
      throw _privateConstructorUsedError;
}
