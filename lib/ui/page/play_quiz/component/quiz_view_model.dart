import 'package:baseball_quiz_app/constant/hitting_stats/stats_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_quiz_ui.dart';
import '../../../../repository/supabase/hitter_repository.dart';
import 'quiz_event_buttons_view_model.dart';

final quizViewModelProvider = Provider(QuizViewModel.new);

final selectedHitterIdProvider = StateProvider((_) => '');

class QuizViewModel {
  QuizViewModel(
    this.ref,
  );

  final Ref ref;

  void addAllStatsId(HitterQuizUi hitterQuiz) {
    final searchCondition = ref.watch(searchConditionProvider);
    final selectedStatsTypeList = searchCondition.selectedStatsList;

    final statsList = hitterQuiz.statsList;

    final closedStatsIdList = ref.watch(closedStatsIdListProvider);
    final closedStatsIdListNotifier =
        ref.watch(closedStatsIdListProvider.notifier);

    for (final selectedStatsType in selectedStatsTypeList) {
      for (final stats in statsList) {
        final id = stats[selectedStatsType.label]!.id;
        closedStatsIdList.add(id);
        closedStatsIdListNotifier.state = [...closedStatsIdList];
      }
    }
  }
}
