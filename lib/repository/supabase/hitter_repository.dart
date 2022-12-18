import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../Infrastructure/supabase/supabase_providers.dart';
import '../../constant/hitting_stats/probability_stats.dart';
import '../../mock_data/hitter_search_condition_mock.dart';
import '../../model/hitter.dart';
import '../../model/hitter_search_condition.dart';
import '../../model/hitting_stats.dart';
import '../../model/ui/hitter_id_by_name.dart';
import '../../model/ui/hitter_quiz_ui.dart';
import '../../model/ui/stats_value.dart';

// TODO: 別のところに移動する
final searchConditionProvider =
    StateProvider((_) => HitterSearchConditionMock().data1);

final hitterQuizUiProvider = FutureProvider((ref) {
  final searchCondition = ref.watch(searchConditionProvider);
  return ref.watch(hitterRepositoryProvider).implSearchHitter(
        searchCondition,
      );
});

// TODO repositoryのinterface実装して、そこに移動する
final hitterRepositoryProvider = riverpod.Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return HitterRepository(supabase);
});

final allHitterListProvider = riverpod.Provider(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);

// TODO エラーハンドリング要検討
class HitterRepository {
  HitterRepository(
    this.supabase,
  );

  final Supabase supabase;

  // TODO searchFilter、引数ではなくproviderで受け取ったほうが良さそう
  Future<HitterQuizUi?> implSearchHitter(
    HitterSearchCondition searchCondition,
  ) async {
    final hitter = await _searchHitter(searchCondition);

    // 検索条件に合致する選手がいない場合、nullを返す
    if (hitter == null) {
      return null;
    }

    final statsList = await _fetchHittingStats(hitter.id);
    final quizUi = _toHitterQuizUi(
      hitter,
      statsList,
      searchCondition,
    );

    return quizUi;
  }

  // Hitter型, HittingStats型（List）からHitterQuizUi型へ変換
  HitterQuizUi _toHitterQuizUi(
    Hitter hitter,
    List<HittingStats> rowStatsList,
    HitterSearchCondition searchCondition,
  ) {
    final List<Map<String, StatsValue>> statsListForUi = [];

    for (final rowStats in rowStatsList) {
      final statsForUi = _toStatsForUi(rowStats.stats);
      statsListForUi.add(statsForUi);
    }

    final hitterQuizUi = HitterQuizUi(
        id: hitter.id,
        name: hitter.name,
        selectedStatsTypeList: searchCondition.selectedStatsList,
        statsList: statsListForUi);

    return hitterQuizUi;
  }

  Future<Hitter?> _searchHitter(HitterSearchCondition searchCondition) async {
    final responses = await supabase.client
        .from('hitter_table')
        .select('id, name, team, hasData, hitting_stats_table!inner(*)')
        .eq('hasData', true)
        .filter('team', 'in', searchCondition.teamList)
        .gte('hitting_stats_table.試合', searchCondition.minGames)
        .gte('hitting_stats_table.安打', searchCondition.minHits)
        .gte('hitting_stats_table.打席', searchCondition.minPa);

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
  Future<List<HittingStats>> _fetchHittingStats(String playerId) async {
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

  Future<List<HitterIdByName>> fetchAllHitter() async {
    final responses = await supabase.client.from('hitter_table').select('*');

    final allHitterList = <HitterIdByName>[];

    for (var response in responses) {
      final hitterMap = HitterIdByName.fromJson(response);
      allHitterList.add(hitterMap);
    }

    return allHitterList;
  }

  // NOTE 関数名や、関数内の変数名納得いってない
  Map<String, StatsValue> _toStatsForUi(Map<String, dynamic> rowStats) {
    final Map<String, StatsValue> statsForUi = {};

    rowStats.forEach((key, value) {
      final strVal = value.toString();
      statsForUi[key] = _formatStatsValue(key, strVal);
    });

    return statsForUi;
  }

  StatsValue _formatStatsValue(String key, String value) {
    // TODO この関数でuuidはめる処理するのキモいからなんとかする
    final id = const Uuid().v4();

    if (probabilityStats.contains(key)) {
      final data = _formatStatsData(value);
      return StatsValue(id: id, data: data);
    }

    final data = value;
    return StatsValue(id: id, data: data);
  }

  String _formatStatsData(String str) {
    final doubleVal = double.tryParse(str);

    // 「.---」など、double型に変換できない場合
    if (doubleVal == null) {
      return str;
    }

    // 小数点以下3桁を表示
    final fixedVal = doubleVal.toStringAsFixed(3);

    if (doubleVal >= 1) {
      return fixedVal;
    }

    // 率が1未満の場合、「0.XXX」の「0」を取り除く
    return fixedVal.substring(1);
  }
}
