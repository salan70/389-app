import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

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

  //TODO fromJson実装
  factory Hitter.fromJson(Map<String, dynamic> json) => _$HitterFromJson(json);
}
