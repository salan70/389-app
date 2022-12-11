import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Infrastructure/supabase/supabase_providers.dart';
import '../../model/hitter.dart';
import '../../model/hitter_search_filter.dart';
import '../../model/hitting_stats.dart';
import '../../model/ui/hitter_map.dart';

final hitterRepositoryProvider = riverpod.Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return HitterRepository(supabase);
});

final allHitterListProvider = riverpod.Provider(
    (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter());

//TODO エラーハンドリング要検討
class HitterRepository {
  HitterRepository(
    this.supabase,
  );

  final Supabase supabase;

  Future<Hitter?> searchHitter(HitterSearchFilter searchFilter) async {
    final responses = await supabase.client
        .from('hitter_table')
        .select('id, name, team, hasData, hitting_stats_table!inner(*)')
        .eq('hasData', true)
        .filter('team', 'in', searchFilter.teamList)
        .gte('hitting_stats_table.試合', searchFilter.minGames)
        .gte('hitting_stats_table.安打', searchFilter.minHits)
        .gte('hitting_stats_table.打席', searchFilter.minPa);

    // NOTE 以降の処理、諸々別の関数でやったほうが良いかも

    // NOTE 空の際の処理、あんまり納得行ってない
    // 検索条件に合致する選手がいない場合、nullを返す
    if (responses == []) {
      return null;
    }

    // ランダムで1件抽出
    final random = Random();
    final randomResponse = responses[random.nextInt(responses.length)];

    final hitter = Hitter.fromJson(randomResponse);

    return hitter;
  }

  // playerIdから打撃成績のListを取得する
  Future<List<HittingStats>> fetchHittingStats(String playerId) async {
    final List<HittingStats> statsList = [];

    final responses = await supabase.client
        .from('hitting_stats_table')
        .select('*')
        .eq('playerId', playerId);

    for (final response in responses) {
      final stats = HittingStats.fromJson(response);
      statsList.add(stats);
    }

    return statsList;
  }

  Future<List<HitterMap>> fetchAllHitter() async {
    final responses = await supabase.client.from('hitter_table').select('*');

    final allHitterList = <HitterMap>[];

    for (var response in responses) {
      final hitterMap = HitterMap.fromJson(response);
      allHitterList.add(hitterMap);
    }

    return allHitterList;
  }
}
