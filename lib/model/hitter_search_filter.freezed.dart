// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_search_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HitterSearchFilter {
  List<String> get teamList => throw _privateConstructorUsedError;
  int get minGames => throw _privateConstructorUsedError;
  int get minHits => throw _privateConstructorUsedError;
  int get minPa => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HitterSearchFilterCopyWith<HitterSearchFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterSearchFilterCopyWith<$Res> {
  factory $HitterSearchFilterCopyWith(
          HitterSearchFilter value, $Res Function(HitterSearchFilter) then) =
      _$HitterSearchFilterCopyWithImpl<$Res, HitterSearchFilter>;
  @useResult
  $Res call({List<String> teamList, int minGames, int minHits, int minPa});
}

/// @nodoc
class _$HitterSearchFilterCopyWithImpl<$Res, $Val extends HitterSearchFilter>
    implements $HitterSearchFilterCopyWith<$Res> {
  _$HitterSearchFilterCopyWithImpl(this._value, this._then);

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
    Object? minPa = null,
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
      minPa: null == minPa
          ? _value.minPa
          : minPa // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HitterSearchFilterCopyWith<$Res>
    implements $HitterSearchFilterCopyWith<$Res> {
  factory _$$_HitterSearchFilterCopyWith(_$_HitterSearchFilter value,
          $Res Function(_$_HitterSearchFilter) then) =
      __$$_HitterSearchFilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> teamList, int minGames, int minHits, int minPa});
}

/// @nodoc
class __$$_HitterSearchFilterCopyWithImpl<$Res>
    extends _$HitterSearchFilterCopyWithImpl<$Res, _$_HitterSearchFilter>
    implements _$$_HitterSearchFilterCopyWith<$Res> {
  __$$_HitterSearchFilterCopyWithImpl(
      _$_HitterSearchFilter _value, $Res Function(_$_HitterSearchFilter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamList = null,
    Object? minGames = null,
    Object? minHits = null,
    Object? minPa = null,
  }) {
    return _then(_$_HitterSearchFilter(
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
      minPa: null == minPa
          ? _value.minPa
          : minPa // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HitterSearchFilter implements _HitterSearchFilter {
  const _$_HitterSearchFilter(
      {required final List<String> teamList,
      required this.minGames,
      required this.minHits,
      required this.minPa})
      : _teamList = teamList;

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
  final int minPa;

  @override
  String toString() {
    return 'HitterSearchFilter(teamList: $teamList, minGames: $minGames, minHits: $minHits, minPa: $minPa)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterSearchFilter &&
            const DeepCollectionEquality().equals(other._teamList, _teamList) &&
            (identical(other.minGames, minGames) ||
                other.minGames == minGames) &&
            (identical(other.minHits, minHits) || other.minHits == minHits) &&
            (identical(other.minPa, minPa) || other.minPa == minPa));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_teamList), minGames, minHits, minPa);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterSearchFilterCopyWith<_$_HitterSearchFilter> get copyWith =>
      __$$_HitterSearchFilterCopyWithImpl<_$_HitterSearchFilter>(
          this, _$identity);
}

abstract class _HitterSearchFilter implements HitterSearchFilter {
  const factory _HitterSearchFilter(
      {required final List<String> teamList,
      required final int minGames,
      required final int minHits,
      required final int minPa}) = _$_HitterSearchFilter;

  @override
  List<String> get teamList;
  @override
  int get minGames;
  @override
  int get minHits;
  @override
  int get minPa;
  @override
  @JsonKey(ignore: true)
  _$$_HitterSearchFilterCopyWith<_$_HitterSearchFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
