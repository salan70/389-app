// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatsValue _$StatsValueFromJson(Map<String, dynamic> json) {
  return _StatsValue.fromJson(json);
}

/// @nodoc
mixin _$StatsValue {
  int get unveilOrder => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsValueCopyWith<StatsValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsValueCopyWith<$Res> {
  factory $StatsValueCopyWith(
          StatsValue value, $Res Function(StatsValue) then) =
      _$StatsValueCopyWithImpl<$Res, StatsValue>;
  @useResult
  $Res call({int unveilOrder, String data});
}

/// @nodoc
class _$StatsValueCopyWithImpl<$Res, $Val extends StatsValue>
    implements $StatsValueCopyWith<$Res> {
  _$StatsValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unveilOrder = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      unveilOrder: null == unveilOrder
          ? _value.unveilOrder
          : unveilOrder // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsValueImplCopyWith<$Res>
    implements $StatsValueCopyWith<$Res> {
  factory _$$StatsValueImplCopyWith(
          _$StatsValueImpl value, $Res Function(_$StatsValueImpl) then) =
      __$$StatsValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int unveilOrder, String data});
}

/// @nodoc
class __$$StatsValueImplCopyWithImpl<$Res>
    extends _$StatsValueCopyWithImpl<$Res, _$StatsValueImpl>
    implements _$$StatsValueImplCopyWith<$Res> {
  __$$StatsValueImplCopyWithImpl(
      _$StatsValueImpl _value, $Res Function(_$StatsValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unveilOrder = null,
    Object? data = null,
  }) {
    return _then(_$StatsValueImpl(
      unveilOrder: null == unveilOrder
          ? _value.unveilOrder
          : unveilOrder // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsValueImpl implements _StatsValue {
  const _$StatsValueImpl({required this.unveilOrder, required this.data});

  factory _$StatsValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsValueImplFromJson(json);

  @override
  final int unveilOrder;
  @override
  final String data;

  @override
  String toString() {
    return 'StatsValue(unveilOrder: $unveilOrder, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsValueImpl &&
            (identical(other.unveilOrder, unveilOrder) ||
                other.unveilOrder == unveilOrder) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, unveilOrder, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsValueImplCopyWith<_$StatsValueImpl> get copyWith =>
      __$$StatsValueImplCopyWithImpl<_$StatsValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsValueImplToJson(
      this,
    );
  }
}

abstract class _StatsValue implements StatsValue {
  const factory _StatsValue(
      {required final int unveilOrder,
      required final String data}) = _$StatsValueImpl;

  factory _StatsValue.fromJson(Map<String, dynamic> json) =
      _$StatsValueImpl.fromJson;

  @override
  int get unveilOrder;
  @override
  String get data;
  @override
  @JsonKey(ignore: true)
  _$$StatsValueImplCopyWith<_$StatsValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
