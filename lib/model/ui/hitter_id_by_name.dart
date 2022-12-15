// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter_id_by_name.freezed.dart';
part 'hitter_id_by_name.g.dart';

@freezed
class HitterIdByName with _$HitterIdByName {
  const factory HitterIdByName({
    @JsonKey(name: 'name') required String label,
    required String id,
  }) = _HitterIdByName;

  factory HitterIdByName.fromJson(Map<String, dynamic> json) =>
      _$HitterIdByNameFromJson(json);
}
