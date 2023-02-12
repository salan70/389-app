import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supabase_hitter.freezed.dart';
part 'supabase_hitter.g.dart';

@freezed
class SupabaseHitter with _$SupabaseHitter {
  const factory SupabaseHitter({
    required String id,
    required String name,
    required String team,
    required bool hasData,
  }) = _SupabaseHitter;

  factory SupabaseHitter.fromJson(Map<String, dynamic> json) =>
      _$SupabaseHitterFromJson(json);
}
