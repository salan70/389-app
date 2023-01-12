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

  void openRandom() {
    final hitterQuizUi = state.value;
    final hiddenStatsIdList = hitterQuizUi!.hiddenStatsIdList;

    final hiddenIndex = Random().nextInt(hiddenStatsIdList.length);

    // hiddenStatsIdList.removeAt(removeIdx)と同様の結果になる処理
    // hiddenStatsIdListがimmutable上記関数を使用できないため、下記のように書いている
    final removedHiddenList = <String>[];
    for (var i = 0; i < hiddenStatsIdList.length; i++) {
      if (i != hiddenIndex) {
        removedHiddenList.add(hiddenStatsIdList[i]);
      }
    }

    state = AsyncData(
      hitterQuizUi.copyWith(
        hiddenStatsIdList: [...removedHiddenList],
      ),
    );
  }

  void openAll() {
    final hitterQuizUi = state.value;
    state = AsyncData(
      hitterQuizUi!.copyWith(
        hiddenStatsIdList: [],
      ),
    );
  }

  bool canOpen() {
    final hitterQuizUi = state.value;
    return hitterQuizUi!.hiddenStatsIdList.isNotEmpty;
  }
}
