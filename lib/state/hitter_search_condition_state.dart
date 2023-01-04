import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/hitting_stats/stats_type.dart';
import '../model/hitter_search_condition.dart';

// TODO(me): 初期値をHiveで取得するようにする
final hitterSearchConditionProvider = StateProvider<HitterSearchCondition>(
  (_) => const HitterSearchCondition(
    teamList: ['千葉ロッテマリーンズ'],
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
  ),
);
