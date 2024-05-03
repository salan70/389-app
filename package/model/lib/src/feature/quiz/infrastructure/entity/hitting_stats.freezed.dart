// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hitting_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HittingStats {
  Map<String, dynamic> get stats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HittingStatsCopyWith<HittingStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HittingStatsCopyWith<$Res> {
  factory $HittingStatsCopyWith(
          HittingStats value, $Res Function(HittingStats) then) =
      _$HittingStatsCopyWithImpl<$Res, HittingStats>;
  @useResult
  $Res call({Map<String, dynamic> stats});
}

/// @nodoc
class _$HittingStatsCopyWithImpl<$Res, $Val extends HittingStats>
    implements $HittingStatsCopyWith<$Res> {
  _$HittingStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
  }) {
    return _then(_value.copyWith(
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HittingStatsImplCopyWith<$Res>
    implements $HittingStatsCopyWith<$Res> {
  factory _$$HittingStatsImplCopyWith(
          _$HittingStatsImpl value, $Res Function(_$HittingStatsImpl) then) =
      __$$HittingStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> stats});
}

/// @nodoc
class __$$HittingStatsImplCopyWithImpl<$Res>
    extends _$HittingStatsCopyWithImpl<$Res, _$HittingStatsImpl>
    implements _$$HittingStatsImplCopyWith<$Res> {
  __$$HittingStatsImplCopyWithImpl(
      _$HittingStatsImpl _value, $Res Function(_$HittingStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
  }) {
    return _then(_$HittingStatsImpl(
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$HittingStatsImpl implements _HittingStats {
  const _$HittingStatsImpl({required final Map<String, dynamic> stats})
      : _stats = stats;

  final Map<String, dynamic> _stats;
  @override
  Map<String, dynamic> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @override
  String toString() {
    return 'HittingStats(stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HittingStatsImpl &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HittingStatsImplCopyWith<_$HittingStatsImpl> get copyWith =>
      __$$HittingStatsImplCopyWithImpl<_$HittingStatsImpl>(this, _$identity);
}

abstract class _HittingStats implements HittingStats {
  const factory _HittingStats({required final Map<String, dynamic> stats}) =
      _$HittingStatsImpl;

  @override
  Map<String, dynamic> get stats;
  @override
  @JsonKey(ignore: true)
  _$$HittingStatsImplCopyWith<_$HittingStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
