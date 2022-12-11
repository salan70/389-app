// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter_map.freezed.dart';
part 'hitter_map.g.dart';

@freezed
class HitterMap with _$HitterMap {
  const factory HitterMap({
    @JsonKey(name: 'name') required String label,
    required String id,
  }) = _HitterMap;

  factory HitterMap.fromJson(Map<String, dynamic> json) =>
      _$HitterMapFromJson(json);
}
