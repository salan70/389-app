import 'dart:math';

import 'package:baseball_quiz_app/model/hitter.dart';
import 'package:baseball_quiz_app/model/hitter_search_filter.dart';
import 'package:baseball_quiz_app/model/hitting_stats.dart';
import 'package:baseball_quiz_app/model/ui/hitter_quiz_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//TODO providerの実装
class HitterRepository {
  HitterRepository(
    this.supabase,
  );

  final Supabase supabase;

  //TODO エラーハンドリング要検討

  Future<HitterQuizUi?> searchHitter(HitterSearchFilter searchFilter) async {
    final hitter = await fetchHitter(searchFilter);

    // 検索条件に合致する選手がいない場合、nullを返す
    if (hitter == null) {
      return null;
    }

    final statsList = await fetchHittingStats(hitter.id);
    final quizUi = toHitterQuizUi(hitter, statsList);

    return quizUi;
  }

  Future<Hitter?> fetchHitter(HitterSearchFilter searchFilter) async {
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

  // Hitter型, HittingStats型（List）からHitterQuizUi型へ変換
  HitterQuizUi toHitterQuizUi(Hitter hitter, List<HittingStats> statsList) {
    final hitterQuizUi = HitterQuizUi(
        id: hitter.id,
        name: hitter.name,
        team: hitter.team,
        hittingStatsList: statsList);

    return hitterQuizUi;
  }
}
