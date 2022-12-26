import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../state/hitter_search_condition_state.dart';

final choseStatsTypeViewModelProvider =
    Provider<ChoseStatsTypeViewModel>(ChoseStatsTypeViewModel.new);

class ChoseStatsTypeViewModel {
  ChoseStatsTypeViewModel(
    this.ref,
  );

  final Ref ref;

  // 選択した成績をリストに追加する
  void addStats(StatsType selectedStats) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    final selectedStatsList = <StatsType>[];

    // teamListに対してadd()が使えない（immutableだから？）ため、
    // 以下のようにselectedStatsを作成
    searchCondition.selectedStatsList.forEach(selectedStatsList.add);
    selectedStatsList.add(selectedStats);

    notifier.state =
        searchCondition.copyWith(selectedStatsList: selectedStatsList);
  }

  // 選択した球団を取り除く
  void removeTeam(int selectedIndex) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    final teamList = searchCondition.teamList;

    // teamListに対してremoveAt()が使えない（immutableだから？）ため、
    // 以下のようにremovedTeamListを作成
    final removedTeamList = <String>[];
    for (final team in teamList) {
      if (team != teamList[selectedIndex]) {
        removedTeamList.add(team);
      }
    }

    notifier.state = searchCondition.copyWith(teamList: removedTeamList);
  }
}
