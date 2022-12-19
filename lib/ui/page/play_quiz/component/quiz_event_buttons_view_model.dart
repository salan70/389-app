import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/supabase/supabase_hitter_repository.dart';

final quizEventButtonsViewModelProvider =
    Provider<QuizEventButtonsViewModel>(QuizEventButtonsViewModel.new);

class QuizEventButtonsViewModel {
  QuizEventButtonsViewModel(
    this.ref,
  );

  final Ref ref;

  void removeRandom() {
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);
    final notifier = ref.watch(hitterQuizUiStateProvider.notifier);

    hitterQuizUi.whenData((value) {
      final closedStatsIdList = value!.closedStatsIdList;
      final random = Random();
      final removeIdx = random.nextInt(closedStatsIdList.length);

      // removeIdx以外のindexのIdをremovedListに追加していく
      final removedList = <String>[];
      for (var i = 0; i < closedStatsIdList.length; i++) {
        if (i != removeIdx) {
          removedList.add(closedStatsIdList[i]);
        }
      }

      notifier.state = AsyncData(
        value.copyWith(
          // closedStatsIdList: [...closedStatsIdList],
          closedStatsIdList: [...removedList],
        ),
      );
    });
  }

  void removeAll() {
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);
    final notifier = ref.watch(hitterQuizUiStateProvider.notifier);

    hitterQuizUi.whenData((value) {
      notifier.state = AsyncData(
        value!.copyWith(
          closedStatsIdList: [],
        ),
      );
    });
  }

  bool canRemove() {
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);
    var canRemove = false;

    hitterQuizUi.whenData((value) {
      if (value!.closedStatsIdList.isNotEmpty) {
        canRemove = true;
      }
    });

    return canRemove;
  }
}
