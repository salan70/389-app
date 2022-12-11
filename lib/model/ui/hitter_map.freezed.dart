// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HitterMap _$HitterMapFromJson(Map<String, dynamic> json) {
  return _HitterMap.fromJson(json);
}

/// @nodoc
mixin _$HitterMap {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HitterMapCopyWith<HitterMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterMapCopyWith<$Res> {
  factory $HitterMapCopyWith(HitterMap value, $Res Function(HitterMap) then) =
      _$HitterMapCopyWithImpl<$Res, HitterMap>;
  @useResult
  $Res call({String name, String id});
}

/// @nodoc
class _$HitterMapCopyWithImpl<$Res, $Val extends HitterMap>
    implements $HitterMapCopyWith<$Res> {
  _$HitterMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HitterMapCopyWith<$Res> implements $HitterMapCopyWith<$Res> {
  factory _$$_HitterMapCopyWith(
          _$_HitterMap value, $Res Function(_$_HitterMap) then) =
      __$$_HitterMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String id});
}

/// @nodoc
class __$$_HitterMapCopyWithImpl<$Res>
    extends _$HitterMapCopyWithImpl<$Res, _$_HitterMap>
    implements _$$_HitterMapCopyWith<$Res> {
  __$$_HitterMapCopyWithImpl(
      _$_HitterMap _value, $Res Function(_$_HitterMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
  }) {
    return _then(_$_HitterMap(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HitterMap implements _HitterMap {
  const _$_HitterMap({required this.name, required this.id});

  factory _$_HitterMap.fromJson(Map<String, dynamic> json) =>
      _$$_HitterMapFromJson(json);

  @override
  final String name;
  @override
  final String id;

  @override
  String toString() {
    return 'HitterMap(name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterMap &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterMapCopyWith<_$_HitterMap> get copyWith =>
      __$$_HitterMapCopyWithImpl<_$_HitterMap>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HitterMapToJson(
      this,
    );
  }
}

abstract class _HitterMap implements HitterMap {
  const factory _HitterMap(
      {required final String name, required final String id}) = _$_HitterMap;

  factory _HitterMap.fromJson(Map<String, dynamic> json) =
      _$_HitterMap.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_HitterMapCopyWith<_$_HitterMap> get copyWith =>
      throw _privateConstructorUsedError;
}
