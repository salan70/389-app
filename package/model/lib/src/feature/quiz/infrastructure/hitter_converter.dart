import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../util/enum/hitting_stats_type.dart';
import '../domain/hitter_quiz.dart';
import '../domain/hitter_quiz_state.dart';
import '../domain/stats_value.dart';
import 'entity/hitting_stats.dart';
import 'entity/supabase_hitter.dart';

class HitterConverter {
  /// [HitterQuizState] へ変換する。
  HitterQuizState toInputNormalQuizState(
    SupabaseHitter supabaseHitter,
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final hitterQuiz = _createHitterQuiz(
      supabaseHitter,
      rowStatsList,
      selectedStatsList,
    );

    return HitterQuizState.normal(
      hitterQuiz: hitterQuiz,
      enteredHitter: null,
    );
  }

  /// [HitterQuizState] へ変換する。
  HitterQuizState toInputDailyQuizState(
    SupabaseHitter supabaseHitter,
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final hitterQuiz = _createHitterQuiz(
      supabaseHitter,
      rowStatsList,
      selectedStatsList,
    );

    return HitterQuizState.daily(
      hitterQuiz: hitterQuiz,
      enteredHitter: null,
    );
  }

  List<Map<String, StatsValue>> _createStatsListForUi(
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final statsListForUi = <Map<String, StatsValue>>[];
    final statsCountList =
        _createStatsCountList(rowStatsList, selectedStatsList);

    for (final rawStats in rowStatsList) {
      final statsMap = toStatsMap(rawStats.stats, selectedStatsList);
      final statsForUi = <String, StatsValue>{};

      for (final selectedStats in selectedStatsList) {
        final removeIndex = Random().nextInt(statsCountList.length);
        final unveilOrder = statsCountList.removeAt(removeIndex);
        final statsValue = StatsValue(
          unveilOrder: unveilOrder,
          data: statsMap[selectedStats]!,
        );
        statsForUi[selectedStats] = statsValue;
      }
      statsListForUi.add(statsForUi);
    }

    return statsListForUi;
  }

  List<String> _extractYearList(List<HittingStats> rowStatsList) {
    return rowStatsList
        .map((rawStats) => rawStats.stats['年度'] as String)
        .toList();
  }

  HitterQuiz _createHitterQuiz(
    SupabaseHitter supabaseHitter,
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final statsListForUi =
        _createStatsListForUi(rowStatsList, selectedStatsList);
    final yearList = _extractYearList(rowStatsList);

    return HitterQuiz(
      hitterId: supabaseHitter.id,
      hitterName: supabaseHitter.name,
      yearList: yearList,
      selectedStatsList: selectedStatsList,
      statsMapList: statsListForUi,
      unveilCount: 0,
      incorrectCount: 0,
    );
  }

  /// 0~成績数のリストを作成する
  List<int> _createStatsCountList(
    List<HittingStats> rowStatsList,
    List<String> selectedStatsList,
  ) {
    final statsCountList = <int>[];

    final rowStatsCount = rowStatsList.length;
    final selectedStatsCount = selectedStatsList.length;
    final totalCount = rowStatsCount * selectedStatsCount;

    for (var i = 0; i < totalCount; i++) {
      statsCountList.add(i);
    }

    return statsCountList;
  }

  /// 1年ごとの成績を変換する
  @visibleForTesting
  Map<String, String> toStatsMap(
    Map<String, dynamic> rawStats,
    List<String> selectedStatsList,
  ) {
    // TODO(me): 変数名変える
    final statsMap = <String, String>{};

    rawStats.forEach((key, value) {
      // selectedLabelListに含まれる成績のみMap型として追加する
      if (selectedStatsList.contains(key)) {
        statsMap[key] = formatStatsValue(key, value.toString());
      }
    });

    return statsMap;
  }

  @visibleForTesting
  String formatStatsValue(String key, String value) {
    if (probabilityStats.contains(key)) {
      return formatStatsData(value);
    }
    return value;
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
