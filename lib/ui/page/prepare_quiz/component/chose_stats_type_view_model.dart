import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../constant/setting.dart';
import '../../../../state/hitter_search_condition_state.dart';

final choseStatsTypeViewModelProvider =
    Provider.autoDispose<ChoseStatsTypeViewModel>(ChoseStatsTypeViewModel.new);

class ChoseStatsTypeViewModel {
  ChoseStatsTypeViewModel(
    this.ref,
  );

  final Ref ref;

  void tapStats(StatsType tappedStats) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final selectedStatsList = searchCondition.selectedStatsList;

    if (selectedStatsList.contains(tappedStats)) {
      _removeStats(tappedStats);
      return;
    }

    if (selectedStatsList.length < mustSelectStatsTypeNum) {
      _addStats(tappedStats);
    }
  }

  void saveStatsList(List<StatsType> selectedList) {
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);
    final searchCondition = ref.watch(hitterSearchConditionProvider);

    notifier.state = searchCondition.copyWith(selectedStatsList: selectedList);
  }

  // 成績をタップ時に状態（選択/未選択）を変更できるか判別
  bool canChangeState({
    required int selectedLength,
    required bool isSelected,
  }) {
    if (selectedLength == mustSelectStatsTypeNum && isSelected) {
      return true;
    }

    if (selectedLength < mustSelectStatsTypeNum) {
      return true;
    }

    return false;
  }

  // 選択した成績をリストに追加する
  void _addStats(StatsType tappedStats) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    final selectedStatsList = <StatsType>[];

    // teamListに対してadd()が使えない（immutableだから？）ため、
    // 以下のようにselectedStatsを作成
    searchCondition.selectedStatsList.forEach(selectedStatsList.add);
    selectedStatsList.add(tappedStats);

    notifier.state =
        searchCondition.copyWith(selectedStatsList: selectedStatsList);
  }

  // 選択した球団を取り除く
  void _removeStats(StatsType tappedStats) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    final selectedStatsList = searchCondition.selectedStatsList;

    // teamListに対してremoveAt()が使えない（immutableだから？）ため、
    // 以下のようにremovedTeamListを作成
    final removedStatsList = <StatsType>[];
    for (final stats in selectedStatsList) {
      if (stats != tappedStats) {
        removedStatsList.add(stats);
      }
    }

    notifier.state =
        searchCondition.copyWith(selectedStatsList: removedStatsList);
  }
}
