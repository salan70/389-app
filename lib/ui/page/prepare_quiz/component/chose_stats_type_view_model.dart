import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitter_search_condition_constant.dart';
import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../state/hitter_search_condition_state.dart';

final choseStatsTypeViewModelProvider =
    Provider.autoDispose<ChoseStatsTypeViewModel>(ChoseStatsTypeViewModel.new);

class ChoseStatsTypeViewModel {
  ChoseStatsTypeViewModel(
    this.ref,
  );

  final Ref ref;

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

  bool isValidSelectedStatsList(int listLength) {
    return listLength == mustSelectStatsTypeNum;
  }
}
