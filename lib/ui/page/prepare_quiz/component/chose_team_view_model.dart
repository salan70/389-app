import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_search_condition_state.dart';

final choseTeamViewModelProvider =
    Provider<ChoseTeamViewModel>(ChoseTeamViewModel.new);

class ChoseTeamViewModel {
  ChoseTeamViewModel(
    this.ref,
  );

  final Ref ref;

  // 選択した球団のリストを保存する
  void saveTeamList(List<Object?> selectedList) {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    final notifier = ref.watch(hitterSearchConditionProvider.notifier);

    final teamList = selectedList.cast<String>();

    notifier.state = searchCondition.copyWith(teamList: teamList);
  }
}
