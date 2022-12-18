import 'dart:math';

import 'package:baseball_quiz_app/constant/hitting_stats/stats_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/supabase/hitter_repository.dart';

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
    final openedIdListNotifier = ref.watch(closedStatsIdListProvider.notifier);

    openedIdListNotifier.state = [];
  }

  bool canRemove() {
    final openedIdList = ref.watch(closedStatsIdListProvider);

    if (openedIdList == []) {
      return false;
    }
    return true;
  }
}
