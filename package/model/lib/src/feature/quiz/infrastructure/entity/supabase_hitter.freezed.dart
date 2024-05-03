// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supabase_hitter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupabaseHitter _$SupabaseHitterFromJson(Map<String, dynamic> json) {
  return _SupabaseHitter.fromJson(json);
}

/// @nodoc
mixin _$SupabaseHitter {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get team => throw _privateConstructorUsedError;
  bool get hasData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupabaseHitterCopyWith<SupabaseHitter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupabaseHitterCopyWith<$Res> {
  factory $SupabaseHitterCopyWith(
          SupabaseHitter value, $Res Function(SupabaseHitter) then) =
      _$SupabaseHitterCopyWithImpl<$Res, SupabaseHitter>;
  @useResult
  $Res call({String id, String name, String team, bool hasData});
}

/// @nodoc
class _$SupabaseHitterCopyWithImpl<$Res, $Val extends SupabaseHitter>
    implements $SupabaseHitterCopyWith<$Res> {
  _$SupabaseHitterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? team = null,
    Object? hasData = null,
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
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String,
      hasData: null == hasData
          ? _value.hasData
          : hasData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupabaseHitterImplCopyWith<$Res>
    implements $SupabaseHitterCopyWith<$Res> {
  factory _$$SupabaseHitterImplCopyWith(_$SupabaseHitterImpl value,
          $Res Function(_$SupabaseHitterImpl) then) =
      __$$SupabaseHitterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String team, bool hasData});
}

/// @nodoc
class __$$SupabaseHitterImplCopyWithImpl<$Res>
    extends _$SupabaseHitterCopyWithImpl<$Res, _$SupabaseHitterImpl>
    implements _$$SupabaseHitterImplCopyWith<$Res> {
  __$$SupabaseHitterImplCopyWithImpl(
      _$SupabaseHitterImpl _value, $Res Function(_$SupabaseHitterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? team = null,
    Object? hasData = null,
  }) {
    return _then(_$SupabaseHitterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String,
      hasData: null == hasData
          ? _value.hasData
          : hasData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupabaseHitterImpl
    with DiagnosticableTreeMixin
    implements _SupabaseHitter {
  const _$SupabaseHitterImpl(
      {required this.id,
      required this.name,
      required this.team,
      required this.hasData});

  factory _$SupabaseHitterImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupabaseHitterImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String team;
  @override
  final bool hasData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupabaseHitter(id: $id, name: $name, team: $team, hasData: $hasData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupabaseHitter'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('team', team))
      ..add(DiagnosticsProperty('hasData', hasData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupabaseHitterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.hasData, hasData) || other.hasData == hasData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, team, hasData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupabaseHitterImplCopyWith<_$SupabaseHitterImpl> get copyWith =>
      __$$SupabaseHitterImplCopyWithImpl<_$SupabaseHitterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupabaseHitterImplToJson(
      this,
    );
  }
}

abstract class _SupabaseHitter implements SupabaseHitter {
  const factory _SupabaseHitter(
      {required final String id,
      required final String name,
      required final String team,
      required final bool hasData}) = _$SupabaseHitterImpl;

  factory _SupabaseHitter.fromJson(Map<String, dynamic> json) =
      _$SupabaseHitterImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get team;
  @override
  bool get hasData;
  @override
  @JsonKey(ignore: true)
  _$$SupabaseHitterImplCopyWith<_$SupabaseHitterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
