import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/supabase/hitter_repository.dart';

final quizEventButtonsViewModelProvider =
    Provider(QuizEventButtonsViewModel.new);

class QuizEventButtonsViewModel {
  QuizEventButtonsViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO: この関数がうまく動かない
  void removeRandom() {
    print('in removeRandom');
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);
    final notifier = ref.watch(hitterQuizUiStateProvider.notifier);

    hitterQuizUi.whenData((value) {
      final closedStatsIdList = value!.closedStatsIdList;
      final random = Random();
      final removeIdx = random.nextInt(closedStatsIdList.length);
      print('remove before: ${closedStatsIdList.length}');

      print(closedStatsIdList.removeAt(removeIdx));
      // closedStatsIdList.removeAt(removeIdx);
      print('remove after: ${closedStatsIdList.length}');
      notifier.state = AsyncData(
        value.copyWith(
          closedStatsIdList: [...closedStatsIdList],
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
