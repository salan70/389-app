import 'package:freezed_annotation/freezed_annotation.dart';

import '../constant/hitting_stats/stats_type.dart';

part 'hitter_search_condition.freezed.dart';

@freezed
class HitterSearchCondition with _$HitterSearchCondition {
  const factory HitterSearchCondition({
    required List<String> teamList,
    required int minGames,
    required int minHits,
    required int minPa, // pa: 打席数
    required List<StatsType> selectedStatsList,
  }) = _HitterSearchCondition;
}
