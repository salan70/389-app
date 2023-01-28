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
import '../../model/hitting_stats.dart';
import '../../model/typeadapter/hitter_search_condition.dart';
import '../../model/ui/hitter_id_by_name.dart';
import '../../model/ui/hitter_quiz_ui.dart';
import '../../model/ui/stats_value.dart';
import '../../state/hitter_search_condition_state.dart';
import '../../util/exception/supabase_exception.dart';
import '../../util/logger.dart';

/// 全野手のIDと名前のリストを返すプロバイダー
final allHitterListProvider = riverpod.Provider<Future<List<HitterIdByName>>>(
  (ref) => ref.watch(hitterRepositoryProvider).fetchAllHitter(),
);

// TODO(me): エラーハンドリング要検討
class SupabaseHitterRepository implements HitterRepository {
  SupabaseHitterRepository(
    this.supabase,
  );

  final Supabase supabase;
  final List<String> _hiddenStatsIdList = [];

  @override
  Future<HitterQuizUi> createHitterQuizUi(
    HitterSearchCondition searchCondition,
  ) async {
    // _hiddenStatsIdListを空にする
    // SupabaseHitterRepositoryのインスタンスが既に生成されている場合、
    // 既存の_hiddenStatsIdListに上書きされるため。
    // TODO(me): 本当はメンバ変数として保持したくない
    _hiddenStatsIdList.clear();

    // 検索条件に合う選手を1人取得
    final hitter = await _searchHitter(searchCondition);

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

  // TODO(me): UT作る
  // TODO(me): Util > Converterとかに移動させる
  /// Hitter型, HittingStats型（List）からHitterQuizUi型へ変換
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
      selectedStatsList: searchCondition.selectedStatsList,
      statsMapList: statsListForUi,
      hiddenStatsIdList: _hiddenStatsIdList,
    );

    return hitterQuizUi;
  }

  /// 条件に合う選手を1人検索する
  Future<Hitter> _searchHitter(HitterSearchCondition searchCondition) async {
    try {
      final List<dynamic> responses = await supabase.client
          .from('hitter_table')
          .select('id, name, team, hasData, hitting_stats_table!inner(*)')
          .eq('hasData', true)
          .filter('team', 'in', searchCondition.teamList)
          .gte('hitting_stats_table.試合', searchCondition.minGames)
          .gte('hitting_stats_table.安打', searchCondition.minHits)
          .gte('hitting_stats_table.本塁打', searchCondition.minHr);

      // 検索条件に合致する選手がいない場合、例外を返す
      if (responses.isEmpty) {
        throw SupabaseException.notFound();
      }

      // ランダムで1人選出
      final chosenResponse = responses[Random().nextInt(responses.length)];
      final hitter = Hitter.fromJson(chosenResponse);

      return hitter;
    } catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// playerIdから打撃成績のListを取得する
  Future<List<HittingStats>> _fetchHittingStats(String playerId) async {
    final statsList = <HittingStats>[];
    try {
      final responses = await supabase.client
          .from('hitting_stats_table')
          .select('*')
          .eq('playerId', playerId);

      for (final response in responses) {
        final stats = HittingStats.fromJson(response);
        statsList.add(stats);
      }

      return statsList;
    } catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// 解答を入力するテキストフィールドの検索用
  @override
  Future<List<HitterIdByName>> fetchAllHitter() async {
    try {
      final responses = await supabase.client.from('hitter_table').select('*');

      final allHitterList = <HitterIdByName>[];
      for (final response in responses) {
        final hitterMap = HitterIdByName.fromJson(response);
        allHitterList.add(hitterMap);
      }

      return allHitterList;
    } catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  // TODO(me): UT作る
  // TODO(me): Util > Converterとかに移動させる
  Map<String, StatsValue> _toStatsMap(
    Map<String, dynamic> rowStats,
    HitterSearchCondition searchCondition,
  ) {
    final statsForUi = <String, StatsValue>{};

    final selectedStatsList = searchCondition.selectedStatsList;

    rowStats.forEach((key, value) {
      // selectedLabelListに含まれる成績のみMap型として追加
      if (selectedStatsList.contains(key)) {
        final strVal = value.toString();
        statsForUi[key] = _formatStatsValue(key, strVal);
      }
    });

    return statsForUi;
  }

  // TODO(me): UT作る
  // TODO(me): Util > Converterとかに移動させる
  StatsValue _formatStatsValue(String key, String value) {
    final id = const Uuid().v4();

    // TODO(me): 年度はそもそもStatsValueとして保持しないようにする
    // そうすれば_hiddenStatsIdListをメンバ変数として保持しなくて良くなると思われる
    // 年度のidは最初から開けておくため、hiddenStatsIdListには含めない
    if (key != '年度') {
      _hiddenStatsIdList.add(id);
    }

    if (probabilityStats.contains(key)) {
      final data = _formatStatsData(value);
      return StatsValue(id: id, data: data);
    }

    final data = value;
    return StatsValue(id: id, data: data);
  }

  // TODO(me): UT作る
  // TODO(me): Util > Converterとかに移動させる
  /// String型の値を「.346」といった率を表示する形式に変換
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
