import '../constant/hitting_stats/stats_type.dart';
import '../model/typeadapter/hitter_search_condition.dart';

class HitterSearchConditionMock {
  final data1 = const HitterSearchCondition(
    teamList: [
      '千葉ロッテマリーンズ',
      '阪神タイガース',
      '読売ジャイアンツ',
    ],
    minGames: 0,
    minHits: 0,
    minHr: 0,
    selectedStatsList: [
      StatsType.year,
      StatsType.team,
      StatsType.avg,
      StatsType.hr,
      StatsType.ops,
    ],
  );

  final data2 = const HitterSearchCondition(
    teamList: [
      '千葉ロッテマリーンズ',
      '阪神タイガース',
      '読売ジャイアンツ',
    ],
    minGames: 0,
    minHits: 0,
    minHr: 0,
    selectedStatsList: [
      StatsType.year,
      StatsType.team,
    ],
  );
}
