import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/stats_type.dart';
import '../../../../model/hitter.dart';
import '../../../../model/hitter_search_filter.dart';
import '../../../../model/hitting_stats.dart';
import '../../../../model/ui/hitter_quiz_ui.dart';
import '../../../../repository/supabase/hitter_repository.dart';

final hitterQuizUiProvider = FutureProvider((ref) {
  const searchFilter = HitterSearchFilter(
      teamList: ['千葉ロッテマリーンズ', '阪神タイガース', '読売ジャイアンツ'],
      minGames: 0,
      minHits: 0,
      minPa: 0);
  return ref.watch(quizViewModelProvider).implSearchHitter(searchFilter);
});

final selectedStatsListProvider = Provider((ref) {
  List<StatsType> selectedStats = [
    StatsType.team,
    StatsType.avg,
    StatsType.hr,
    StatsType.ops,
  ];
  return selectedStats;
});

final quizViewModelProvider = Provider(QuizViewModel.new);

class QuizViewModel {
  QuizViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO searchFilter、引数ではなくproviderで受け取ったほうが良さそう
  Future<HitterQuizUi?> implSearchHitter(
      HitterSearchFilter searchFilter) async {
    final hitterRepository = ref.watch(hitterRepositoryProvider);
    final hitter = await hitterRepository.searchHitter(searchFilter);

    // 検索条件に合致する選手がいない場合、nullを返す
    if (hitter == null) {
      return null;
    }

    final statsList = await hitterRepository.fetchHittingStats(hitter.id);
    final quizUi = _toHitterQuizUi(hitter, statsList);

    return quizUi;
  }

  // Hitter型, HittingStats型（List）からHitterQuizUi型へ変換
  HitterQuizUi _toHitterQuizUi(Hitter hitter, List<HittingStats> rowStatsList) {
    final selectedStatsList = ref.watch(selectedStatsListProvider);

    final List<Map<String, String>> statsListForUi = [];

    for (final rowStats in rowStatsList) {
      final statsForUi = _toStatsForUi(rowStats.stats);
      statsListForUi.add(statsForUi);
    }

    final hitterQuizUi = HitterQuizUi(
        id: hitter.id,
        name: hitter.name,
        selectedStatsList: selectedStatsList,
        statsList: statsListForUi);

    return hitterQuizUi;
  }

  // NOTE 関数名や、関数内の変数名納得いってない
  Map<String, String> _toStatsForUi(Map<String, dynamic> rowStats) {
    final List<String> statsOnProbability = [
      StatsType.avg.label,
      StatsType.obp.label,
      StatsType.slg.label,
      StatsType.ops.label,
    ];
    final Map<String, String> statsForUi = {};

    rowStats.forEach((key, value) {
      final strVal = value.toString();

      if (statsOnProbability.contains(key)) {
        statsForUi[key] = _formatStatsValue(strVal);
      } else {
        statsForUi[key] = strVal;
      }
    });

    return statsForUi;
  }

  // NOTE 関数名や、関数内の変数名納得いってない
  String _formatStatsValue(String str) {
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
