// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hitter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Hitter _$HitterFromJson(Map<String, dynamic> json) {
  return _Hitter.fromJson(json);
}

/// @nodoc
mixin _$Hitter {
  @JsonKey(name: 'name')
  String get label => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HitterCopyWith<Hitter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitterCopyWith<$Res> {
  factory $HitterCopyWith(Hitter value, $Res Function(Hitter) then) =
      _$HitterCopyWithImpl<$Res, Hitter>;
  @useResult
  $Res call({@JsonKey(name: 'name') String label, String id});
}

/// @nodoc
class _$HitterCopyWithImpl<$Res, $Val extends Hitter>
    implements $HitterCopyWith<$Res> {
  _$HitterCopyWithImpl(this._value, this._then);

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
abstract class _$$HitterImplCopyWith<$Res> implements $HitterCopyWith<$Res> {
  factory _$$HitterImplCopyWith(
          _$HitterImpl value, $Res Function(_$HitterImpl) then) =
      __$$HitterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'name') String label, String id});
}

/// @nodoc
class __$$HitterImplCopyWithImpl<$Res>
    extends _$HitterCopyWithImpl<$Res, _$HitterImpl>
    implements _$$HitterImplCopyWith<$Res> {
  __$$HitterImplCopyWithImpl(
      _$HitterImpl _value, $Res Function(_$HitterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? id = null,
  }) {
    return _then(_$HitterImpl(
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
class _$HitterImpl implements _Hitter {
  const _$HitterImpl(
      {@JsonKey(name: 'name') required this.label, required this.id});

  factory _$HitterImpl.fromJson(Map<String, dynamic> json) =>
      _$$HitterImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String label;
  @override
  final String id;

  @override
  String toString() {
    return 'Hitter(label: $label, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HitterImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HitterImplCopyWith<_$HitterImpl> get copyWith =>
      __$$HitterImplCopyWithImpl<_$HitterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HitterImplToJson(
      this,
    );
  }
}

abstract class _Hitter implements Hitter {
  const factory _Hitter(
      {@JsonKey(name: 'name') required final String label,
      required final String id}) = _$HitterImpl;

  factory _Hitter.fromJson(Map<String, dynamic> json) = _$HitterImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String get label;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$HitterImplCopyWith<_$HitterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
