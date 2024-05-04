// ignore_for_file: invalid_annotation_target
// 参考: https://github.com/rrousselGit/freezed/issues/488

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter.freezed.dart';
part 'hitter.g.dart';

@freezed
class Hitter with _$Hitter {
  const factory Hitter({
    @JsonKey(name: 'name') required String label,
    required String id,
  }) = _Hitter;

  factory Hitter.fromJson(Map<String, dynamic> json) => _$HitterFromJson(json);
}
