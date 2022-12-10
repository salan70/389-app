import 'dart:math';

import 'package:baseball_quiz_app/constant/stats_type.dart';
import 'package:baseball_quiz_app/util/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../model/hitter.dart';
import '../../../model/hitter_search_filter.dart';
import '../../../model/hitting_stats.dart';
import '../../../model/ui/hitter_quiz_ui.dart';
import '../../../repository/supabase/supabase_repository_providers.dart';

final hitterQuizUiProvider = FutureProvider((ref) {
  const searchFilter = HitterSearchFilter(
      teamList: ['千葉ロッテマリーンズ', '阪神タイガース', '読売ジャイアンツ'],
      minGames: 0,
      minHits: 0,
      minPa: 0);
  return PlayQuizViewModel(ref).implSearchHitter(searchFilter);
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

final openedIdListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final id2DListProvider = Provider<List<List<String>>>((ref) {
  return PlayQuizViewModel(ref).createId2DList();
});

final playQuizViewModelProvider = StateProvider.autoDispose((ref) {
  return PlayQuizViewModel(ref);
});

class PlayQuizViewModel {
  PlayQuizViewModel(
    this.ref,
  );

  final Ref ref;

  Future<HitterQuizUi?> implSearchHitter(
      HitterSearchFilter searchFilter) async {
    final hitterRepository = ref.watch(hitterRepositoryProvider);
    final hitter = await hitterRepository.fetchHitter(searchFilter);

    // 検索条件に合致する選手がいない場合、nullを返す
    if (hitter == null) {
      return null;
    }

    final statsList = await hitterRepository.fetchHittingStats(hitter.id);
    final quizUi = _toHitterQuizUi(hitter, statsList);

    return quizUi;
  }

  List<List<String>> createId2DList() {
    final List<List<String>> idList = [];

    final hitterQuizUi = ref.watch(hitterQuizUiProvider);
    const uuid = Uuid();

    hitterQuizUi.when(
        data: (data) {
          for (int cIdx = 0; cIdx < data!.statsList.length; cIdx++) {
            idList.add([]);
            for (int rIdx = 0; rIdx < data.selectedStatsList.length; rIdx++) {
              idList[cIdx].add(uuid.v4());
            }
          }
        },
        error: (_, error) {
          logger.e('$error');
        },
        loading: () {});

    return idList;
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

  void addId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);
    final openedIdListNotifier = ref.watch(openedIdListProvider.notifier);

    final random = Random();

    while (true) {
      final cIx = random.nextInt(id2DList.length);
      final rIx = random.nextInt(id2DList[cIx].length);

      if (!openedIdList.contains(id2DList[cIx][rIx])) {
        openedIdList.add(id2DList[cIx][rIx]);
        // openedIdListを再生成し、代入する
        openedIdListNotifier.state = [...openedIdList];
        return;
      }
    }
  }

  void addAllId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);
    final openedIdListNotifier = ref.watch(openedIdListProvider.notifier);

    // 1つ1つ処理していく
    for (var idList in id2DList) {
      for (var id in idList) {
        if (!openedIdList.contains(id)) {
          openedIdList.add(id);
          // openedIdListを再生成し、代入する
          openedIdListNotifier.state = [...openedIdList];
        }
      }
    }
  }

  bool canAddId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);

    // id2DList[0]について、id2DListの各Listの長さは全て同じとなる。
    // 確実に値が入っている[0]を指定
    if (id2DList.isEmpty || id2DList[0].isEmpty) {
      return false;
    }

    final openedIdListIsFill =
        openedIdList.length == (id2DList.length * id2DList[0].length);
    if (openedIdListIsFill) {
      return false;
    }

    return true;
  }
}
