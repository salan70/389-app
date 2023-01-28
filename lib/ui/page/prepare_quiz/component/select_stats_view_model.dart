import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitter_search_condition_constant.dart';
import '../../../../state/hitter_search_condition_state.dart';

final selectStatsViewModelProvider =
    Provider.autoDispose<SelectStatsViewModel>(SelectStatsViewModel.new);

class SelectStatsViewModel {
  SelectStatsViewModel(
    this.ref,
  );

  final Ref ref;

  void saveStatsList(List<String> selectedList) {
    final searchCondition = ref.read(hitterSearchConditionProvider.notifier);

    searchCondition.state =
        searchCondition.state.copyWith(selectedStatsList: selectedList);
  }

  /// 成績をタップ時に状態（選択/未選択）を変更できるか判別
  bool canChangeState({
    required int selectedLength,
    required bool isSelected,
  }) {
    if (selectedLength == mustSelectStatsNum && isSelected) {
      return true;
    }

    if (selectedLength < mustSelectStatsNum) {
      return true;
    }

    return false;
  }

  bool isValidSelectedStatsList(int listLength) {
    return listLength == mustSelectStatsNum;
  }
}
