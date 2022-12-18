import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final closedStatsIdListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final quizEventButtonsViewModelProvider =
    Provider(QuizEventButtonsViewModel.new);

class QuizEventButtonsViewModel {
  QuizEventButtonsViewModel(
    this.ref,
  );

  final Ref ref;

  void removeRandom() {
    final closedIdList = ref.watch(closedStatsIdListProvider);
    final notifier = ref.watch(closedStatsIdListProvider.notifier);

    final random = Random();
    final removeIdx = random.nextInt(closedIdList.length);

    closedIdList.removeAt(removeIdx);
    notifier.state = [...closedIdList];
  }

  void removeAll() {
    final closedIdListNotifier = ref.watch(closedStatsIdListProvider.notifier);
    closedIdListNotifier.state = [];
  }

  bool canRemove() {
    final closedIdList = ref.watch(closedStatsIdListProvider);

    if (closedIdList.isEmpty) {
      return false;
    }

    return true;
  }
}
