import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter.freezed.dart';
part 'hitter.g.dart';

@freezed
class Hitter with _$Hitter {
  const factory Hitter({
    required String id,
    required String name,
    required String team,
    required bool hasData,
  }) = _Hitter;

  factory Hitter.fromJson(Map<String, dynamic> json) => _$HitterFromJson(json);
}
