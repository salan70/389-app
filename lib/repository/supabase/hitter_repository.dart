//TODO providerの実装
import 'dart:math';

import 'package:baseball_quiz_app/model/hitter.dart';
import 'package:baseball_quiz_app/model/hitter_search_filter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HitterRepository {
  HitterRepository({
    required this.supabase,
  });

  final Supabase supabase;

  //TODO エラーハンドリング
  /*TODO
  HitterSearchFilterを引数、HitterQuizUiを返り値とする関数を作成する
  - 一旦、teamだけを絞り込み条件として実装する

  - HitterSearchFilterを引数、Hitter, HittingStatsを返り値とする関数を作成する
    - hitter_tableのレコードをHitterにする
      - ランダムに1選手分
        - ランダムは取得後にやるほうが楽かも
      - hitter_tableのidから、hitter_statsのデータを取得する
        - hitter_statsのレコードをHittingStatsにする
  - HitterQuizUiに変換する関数を作成する

   */

  Future<Hitter> fetchHitter(HitterSearchFilter searchFilter) async {
    // NOTE responseという変数名が気に食わない
    final responses = await supabase.client
        .from('hitter_table')
        .select('id, name, team, has_data, hitting_stats_table!inner(*)')
        .eq('has_data', true)
        .filter('team', 'in', searchFilter.teamList)
        .gte('hitting_stats_table.試合', searchFilter.minGames)
        .gte('hitting_stats_table.安打', searchFilter.minHits)
        .gte('hitting_stats_table.打席', searchFilter.minPa);

    // TODO 空の際の処理検討

    // ランダムで1件抽出
    final random = Random();
    final randomResponse = responses[random.nextInt(responses.length)];

    final hitter = Hitter.fromJson(randomResponse);

    return hitter;
  }
}
