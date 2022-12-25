import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../hitter_repository.dart';
import '../../Infrastructure/supabase/supabase_providers.dart';
import '../../constant/hitting_stats/probability_stats.dart';
import '../../constant/hitting_stats/stats_type.dart';
import '../../mock/hitter_search_condition_mock.dart';
import '../../model/hitter.dart';
import '../../model/hitter_search_condition.dart';
import '../../model/hitting_stats.dart';
import '../../model/ui/hitter_id_by_name.dart';
import '../../model/ui/hitter_quiz_ui.dart';
import '../../model/ui/stats_value.dart';
import '../../state/hitter_search_condition_state.dart';

// hitterQuizUiStateProvider内でしか呼ばないこと
final hitterQuizUiFutureProvider = FutureProvider<HitterQuizUi?>((ref) {
  final searchCondition = ref.watch(hitterSearchConditionProvider);
  return ref.watch(hitterRepositoryProvider).createHitterQuizUi(
        searchCondition,
      );
});

final hitterQuizUiStateProvider =
    StateProvider<AsyncValue<HitterQuizUi?>>((ref) {
  return ref.watch(hitterQuizUiFutureProvider);
});

// 全野手のIDと名前のリストを返すプロバイダー
final allHitterListProvider = riverpod.Provider<Future<List<HitterIdByName>>>(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);

// TODO(me): エラーハンドリング要検討
class SupabaseHitterRepository implements HitterRepository {
  SupabaseHitterRepository(
    this.supabase,
  );

  final Supabase supabase;
  final List<String> _closedStatsIdList = [];

  @override
  Future<HitterQuizUi?> createHitterQuizUi(
    HitterSearchCondition searchCondition,
  ) async {
    // 検索条件に合う選手を1人取得
    final hitter = await _searchHitter(searchCondition);

    // 検索条件に合う選手がいない場合、nullを返す
    if (hitter == null) {
      return null;
    }

    // 取得した選手の成績を取得
    final statsList = await _fetchHittingStats(hitter.id);

    // HitterQuizUi型に変換
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
    final statsListForUi = <Map<String, StatsValue>>[];

    for (final rowStats in rowStatsList) {
      final statsMap = _toStatsMap(rowStats.stats, searchCondition);
      statsListForUi.add(statsMap);
    }

    final hitterQuizUi = HitterQuizUi(
      id: hitter.id,
      name: hitter.name,
      selectedStatsTypeList: searchCondition.selectedStatsList,
      statsMapList: statsListForUi,
      closedStatsIdList: _closedStatsIdList,
    );

    return hitterQuizUi;
  }

  // 条件に合う選手を1人検索する
  Future<Hitter?> _searchHitter(HitterSearchCondition searchCondition) async {
    final responses = await supabase.client
        .from('hitter_table')
        .select('id, name, team, hasData, hitting_stats_table!inner(*)')
        .eq('hasData', true)
        .filter('team', 'in', searchCondition.teamList)
        .gte('hitting_stats_table.試合', searchCondition.minGames)
        .gte('hitting_stats_table.安打', searchCondition.minHits)
        .gte('hitting_stats_table.打席', searchCondition.minPa);

    // NOTE: 空の際の処理、あんまり納得してない
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
    final statsList = <HittingStats>[];

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

  // 解答を入力するテキストフィールドの検索用
  @override
  Future<List<HitterIdByName>> fetchAllHitter() async {
    final responses = await supabase.client.from('hitter_table').select('*');

    final allHitterList = <HitterIdByName>[];

    for (final response in responses) {
      final hitterMap = HitterIdByName.fromJson(response);
      allHitterList.add(hitterMap);
    }

    return allHitterList;
  }

  Map<String, StatsValue> _toStatsMap(
    Map<String, dynamic> rowStats,
    HitterSearchCondition searchCondition,
  ) {
    final statsForUi = <String, StatsValue>{};

    final selectedStatsList = searchCondition.selectedStatsList;

    // selectedLabelListを作成
    final selectedLabelList = <String>[];
    for (final selectedStats in selectedStatsList) {
      selectedLabelList.add(selectedStats.label);
    }

    rowStats.forEach((key, value) {
      // selectedLabelListに含まれる成績のみMap型として追加
      if (selectedLabelList.contains(key)) {
        final strVal = value.toString();
        statsForUi[key] = _formatStatsValue(key, strVal);
      }
    });

    return statsForUi;
  }

  StatsValue _formatStatsValue(String key, String value) {
    final id = const Uuid().v4();

    // 年度のidは最初から開けておくため、closedStatsIdListには含めない
    if (key != '年度') {
      _closedStatsIdList.add(id);
    }

    if (probabilityStats.contains(key)) {
      final data = _formatStatsData(value);
      return StatsValue(id: id, data: data);
    }

    final data = value;
    return StatsValue(id: id, data: data);
  }

  // String型の値を「.346」といった率を表示する形式に変換
  String _formatStatsData(String str) {
    // double型に変換できない場合（「.---」など）、nullが入る
    final doubleVal = double.tryParse(str);

    if (doubleVal == null) {
      return str;
    }

    // 小数点以下3桁を表示
    final fixedVal = doubleVal.toStringAsFixed(3);

    // 0.XXXの場合、先頭の0を除いて返す（例：0.300 -> .300を返す）
    if (fixedVal.startsWith('0')) {
      return fixedVal.substring(1);
    }

    return fixedVal;
  }
}
