import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/hitter.dart';
import '../../domain/hitting_stats.dart';
import '../../domain/ui/hitter_quiz_ui.dart';
import '../../domain/ui/stats_value.dart';
import '../../util/constant/hitting_stats/probability_stats.dart';

class SupabaseHitterConverter {
  /// Hitter型, HittingStats型（List）からHitterQuizUi型へ変換する
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

  /// 1年ごとの成績を変換する
  @visibleForTesting
  Map<String, StatsValue> toStatsMap(
    Map<String, dynamic> rawStats,
    List<String> selectedStatsList,
  ) {
    final statsForUi = <String, StatsValue>{};

    rawStats.forEach((key, value) {
      // selectedLabelListに含まれる成績のみMap型として追加する
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
