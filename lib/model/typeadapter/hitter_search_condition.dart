import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../constant/hitting_stats/stats_type.dart';

part 'hitter_search_condition.freezed.dart';
part 'hitter_search_condition.g.dart';

@HiveType(typeId: 1)
@freezed
class HitterSearchCondition with _$HitterSearchCondition {
  const factory HitterSearchCondition({
    @HiveField(0) required List<String> teamList,
    @HiveField(1) required int minGames,
    @HiveField(3) required int minHits,
    @HiveField(4) required int minHr,
    @HiveField(5) required List<StatsType> selectedStatsList,
  }) = _HitterSearchCondition;
}
