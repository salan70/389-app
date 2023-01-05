import '../constant/hitting_stats/stats_type.dart';
import '../model/typeadapter/hitter_search_condition.dart';

class HitterSearchConditionMock {
  final data1 = HitterSearchCondition(
    teamList: [
      '千葉ロッテマリーンズ',
      '阪神タイガース',
      '読売ジャイアンツ',
    ],
    minGames: 0,
    minHits: 0,
    minHr: 0,
    selectedStatsList: [
      StatsType.year.label,
      StatsType.team.label,
      StatsType.avg.label,
      StatsType.hr.label,
      StatsType.ops.label,
    ],
  );

  final data2 = HitterSearchCondition(
    teamList: [
      '千葉ロッテマリーンズ',
      '阪神タイガース',
      '読売ジャイアンツ',
    ],
    minGames: 0,
    minHits: 0,
    minHr: 0,
    selectedStatsList: [
      StatsType.year.label,
      StatsType.team.label,
    ],
  );
}
