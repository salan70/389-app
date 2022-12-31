import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../state/hitter_search_condition_state.dart';

final choseStatsTypeViewModelProvider =
    Provider.autoDispose<ChoseStatsTypeViewModel>(ChoseStatsTypeViewModel.new);

final errorTextForSelectedStatsListProvider =
    StateProvider.autoDispose<String>((ref) {
  return ref
      .watch(choseStatsTypeViewModelProvider)
      .outputErrorTextForSelectedStatsListValidation();
});

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

    const maxCapacity = 5;
    if (selectedStatsList.length < maxCapacity) {
      _addStats(tappedStats);
    }
  }

  void saveStatsList() {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);
    final statsList = searchCondition.selectedStatsList;

    notifier.state = searchCondition.copyWith(selectedStatsList: statsList);
  }

  // TODO(me): 関数名長すぎるから修正する
  String outputErrorTextForSelectedStatsListValidation() {
    final isValid = _isValidSelectedStatsList();
    // 5をconstとして定義する（MAX_CAN_SELECT_STATS_TYPE的な）
    const errorText = '成績を5つ選んでください';
    return isValid ? '' : errorText;
  }

  bool _isValidSelectedStatsList() {
    final selectedStatsList =
        ref.watch(hitterSearchConditionProvider).selectedStatsList;
    return selectedStatsList.length == 5;
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
