// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hitter_id_by_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HitterIdByName _$HitterIdByNameFromJson(Map<String, dynamic> json) {
  return _HitterIdByName.fromJson(json);
}

/// @nodoc
mixin _$HitterIdByName {
  @JsonKey(name: 'name')
  String get label => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HitterIdByNameCopyWith<HitterIdByName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterIdByNameCopyWith<$Res> {
  factory $HitterIdByNameCopyWith(
          HitterIdByName value, $Res Function(HitterIdByName) then) =
      _$HitterIdByNameCopyWithImpl<$Res, HitterIdByName>;
  @useResult
  $Res call({@JsonKey(name: 'name') String label, String id});
}

/// @nodoc
class _$HitterIdByNameCopyWithImpl<$Res, $Val extends HitterIdByName>
    implements $HitterIdByNameCopyWith<$Res> {
  _$HitterIdByNameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HitterIdByNameCopyWith<$Res>
    implements $HitterIdByNameCopyWith<$Res> {
  factory _$$_HitterIdByNameCopyWith(
          _$_HitterIdByName value, $Res Function(_$_HitterIdByName) then) =
      __$$_HitterIdByNameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'name') String label, String id});
}

/// @nodoc
class __$$_HitterIdByNameCopyWithImpl<$Res>
    extends _$HitterIdByNameCopyWithImpl<$Res, _$_HitterIdByName>
    implements _$$_HitterIdByNameCopyWith<$Res> {
  __$$_HitterIdByNameCopyWithImpl(
      _$_HitterIdByName _value, $Res Function(_$_HitterIdByName) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? id = null,
  }) {
    return _then(_$_HitterIdByName(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
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
class _$_HitterIdByName implements _HitterIdByName {
  const _$_HitterIdByName(
      {@JsonKey(name: 'name') required this.label, required this.id});

  factory _$_HitterIdByName.fromJson(Map<String, dynamic> json) =>
      _$$_HitterIdByNameFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String label;
  @override
  final String id;

  @override
  String toString() {
    return 'HitterIdByName(label: $label, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HitterIdByName &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HitterIdByNameCopyWith<_$_HitterIdByName> get copyWith =>
      __$$_HitterIdByNameCopyWithImpl<_$_HitterIdByName>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HitterIdByNameToJson(
      this,
    );
  }
}

abstract class _HitterIdByName implements HitterIdByName {
  const factory _HitterIdByName(
      {@JsonKey(name: 'name') required final String label,
      required final String id}) = _$_HitterIdByName;

  factory _HitterIdByName.fromJson(Map<String, dynamic> json) =
      _$_HitterIdByName.fromJson;

  @override
  @JsonKey(name: 'name')
  String get label;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_HitterIdByNameCopyWith<_$_HitterIdByName> get copyWith =>
      throw _privateConstructorUsedError;
}
