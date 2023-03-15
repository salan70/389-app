import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitting_stats.freezed.dart';

@freezed
class HittingStats with _$HittingStats {
  const factory HittingStats({
    required Map<String, dynamic> stats,
  }) = _HittingStats;

  factory HittingStats.fromJson(Map<String, dynamic> json) {
    final stats = Map<String, dynamic>.from(json);
    return HittingStats(stats: stats);
  }
}
