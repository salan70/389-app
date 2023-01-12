import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ui/hitter_quiz_ui.dart';
import '../repository/hitter_repository.dart';
import 'hitter_search_condition_state.dart';

final hitterQuizUiNotifierProvider =
    AsyncNotifierProvider<HitterQuizUiNotifier, HitterQuizUi?>(() {
  return HitterQuizUiNotifier();
});

class HitterQuizUiNotifier extends AsyncNotifier<HitterQuizUi?> {
  @override
  Future<HitterQuizUi?> build() {
    final searchCondition = ref.watch(hitterSearchConditionProvider);
    return ref
        .watch(hitterRepositoryProvider)
        .createHitterQuizUi(searchCondition);
  }

  void removeRandom() {
    final hitterQuizUi = state.value;

    final closedStatsIdList = hitterQuizUi!.closedStatsIdList;
    final random = Random();
    final removeIdx = random.nextInt(closedStatsIdList.length);

    // removeIdx以外のindexのIdをremovedListに追加していく
    final removedList = <String>[];
    for (var i = 0; i < closedStatsIdList.length; i++) {
      if (i != removeIdx) {
        removedList.add(closedStatsIdList[i]);
      }
    }

    state = AsyncData(
      hitterQuizUi.copyWith(
        closedStatsIdList: [...removedList],
      ),
    );
  }

  void removeAll() {
    final hitterQuizUi = state.value;

    state = AsyncData(
      hitterQuizUi!.copyWith(
        closedStatsIdList: [],
      ),
    );
  }

  bool canRemove() {
    final hitterQuizUi = state.value;
    var canRemove = false;

    if (hitterQuizUi!.closedStatsIdList.isNotEmpty) {
      canRemove = true;
    }

    return canRemove;
  }
}
