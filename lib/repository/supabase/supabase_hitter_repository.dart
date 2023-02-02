import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../constant/hitting_stats/probability_stats.dart';
import '../../model/hitter.dart';
import '../../model/hitting_stats.dart';
import '../../model/typeadapter/hitter_search_condition.dart';
import '../../model/ui/hitter_id_by_name.dart';
import '../../model/ui/hitter_quiz_ui.dart';
import '../../model/ui/stats_value.dart';
import '../../util/exception/supabase_exception.dart';
import '../../util/logger.dart';
import '../hitter_repository.dart';

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

  @override
  Future<HitterQuizUi> createHitterQuizUi(
    HitterSearchCondition searchCondition,
  ) async {
    // 検索条件に合う選手を1人取得
    final hitter = await searchHitter(searchCondition);

    // 取得した選手の成績を取得
    final statsList = await fetchHittingStats(hitter.id);

    // HitterQuizUi型に変換
    final quizUi = toHitterQuizUi(
      hitter,
      statsList,
      searchCondition.selectedStatsList,
    );

    return quizUi;
  }

  /// Hitter型, HittingStats型（List）からHitterQuizUi型へ変換
  @visibleForTesting
  HitterQuizUi toHitterQuizUi(
    Hitter hitter,
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final statsListForUi = <Map<String, StatsValue>>[];
    final hiddenStatsIdList = <String>[];

    for (final rawStats in rowStatsList) {
      final statsMap = toStatsMap(rawStats.stats, selectedStatsList);
      statsListForUi.add(statsMap);

      // TODO(me): 関数として抽出
      for (final selectedStats in selectedStatsList) {
        if (selectedStats != '年度') {
          final id = statsMap[selectedStats]!.id;
          hiddenStatsIdList.add(id);
        }
      }
    }

    final hitterQuizUi = HitterQuizUi(
      id: hitter.id,
      name: hitter.name,
      selectedStatsList: selectedStatsList,
      statsMapList: statsListForUi,
      hiddenStatsIdList: hiddenStatsIdList,
    );

    return hitterQuizUi;
  }

  /// 条件に合う選手を1人検索する
  Future<Hitter> searchHitter(HitterSearchCondition searchCondition) async {
    try {
      final responses = await supabase.client
              .from('hitter_table')
              .select<dynamic>(
                'id, name, team, hasData, hitting_stats_table!inner(*)',
              )
              .eq('hasData', true)
              .filter('team', 'in', searchCondition.teamList)
              .gte('hitting_stats_table.試合', searchCondition.minGames)
              .gte('hitting_stats_table.安打', searchCondition.minHits)
              .gte('hitting_stats_table.本塁打', searchCondition.minHr)
          as List<dynamic>;

      // 検索条件に合致する選手がいない場合、例外を返す
      if (responses.isEmpty) {
        throw SupabaseException.notFound();
      }

      // ランダムで1人選出
      final chosenResponse =
          responses[Random().nextInt(responses.length)] as Map<String, dynamic>;
      final hitter = Hitter.fromJson(chosenResponse);

      return hitter;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// playerIdから打撃成績のListを取得する
  Future<List<HittingStats>> fetchHittingStats(String playerId) async {
    final statsList = <HittingStats>[];
    try {
      final responses = await supabase.client
          .from('hitting_stats_table')
          .select<dynamic>()
          .eq('playerId', playerId) as List<dynamic>;

      for (final response in responses) {
        final stats = HittingStats.fromJson(response as Map<String, dynamic>);
        statsList.add(stats);
      }

      return statsList;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// 解答を入力するテキストフィールドの検索用
  @override
  Future<List<HitterIdByName>> fetchAllHitter() async {
    try {
      final responses = await supabase.client
          .from('hitter_table')
          .select<dynamic>() as List<dynamic>;

      final allHitterList = <HitterIdByName>[];
      for (final response in responses) {
        final hitterMap = HitterIdByName.fromJson(
          response as Map<String, dynamic>,
        );
        allHitterList.add(hitterMap);
      }
      return allHitterList;
    } on Exception catch (e) {
      logger.e(e);
      throw SupabaseException.unknown();
    }
  }

  /// 1年ごとの成績を変換する
  @visibleForTesting
  Map<String, StatsValue> toStatsMap(
    Map<String, dynamic> rawStats,
    List<String> selectedStatsList,
  ) {
    final statsForUi = <String, StatsValue>{};

    rawStats.forEach((key, value) {
      // selectedLabelListに含まれる成績のみMap型として追加
      if (selectedStatsList.contains(key)) {
        final strVal = value.toString();
        statsForUi[key] = formatStatsValue(key, strVal);
      }
    });

    return statsForUi;
  }

  @visibleForTesting
  StatsValue formatStatsValue(String key, String value) {
    late String data;
    if (probabilityStats.contains(key)) {
      data = formatStatsData(value);
    } else {
      data = value;
    }

    return StatsValue(id: const Uuid().v4(), data: data);
  }

  /// String型の値を「.346」といった率を表示する形式に変換
  @visibleForTesting
  String formatStatsData(String str) {
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
