import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../repository/supabase/hitter_repository.dart';
import 'quiz_event_buttons_view_model.dart';
import 'quiz_view_model.dart';

class QuizView extends ConsumerWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizUi = ref.watch(hitterQuizUiProvider);
    final closedIdList = ref.watch(closedStatsIdListProvider);
    final viewModel = ref.watch(quizViewModelProvider);

    return hitterQuizUi.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Text('Error: $err'),
      data: (data) {
        // viewModel.addAllStatsId(data!);
        final selectedStatsList = data!.selectedStatsTypeList;
        return Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text('年度'),
                  ),
                ),
                for (final selectedStats in selectedStatsList)
                  Expanded(
                    child: Center(
                      child: Text(selectedStats.label),
                    ),
                  ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.statsList.length,
              itemBuilder: (_, cIdx) {
                final stats = data.statsList[cIdx];

                return Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          stats['年度']!.data,
                        ),
                      ),
                    ),
                    for (int rIdx = 0; rIdx < selectedStatsList.length; rIdx++)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (!closedIdList.contains(
                            stats[data.selectedStatsTypeList[rIdx].label]!.id,
                          ))
                              ? Text(
                                  stats[data.selectedStatsTypeList[rIdx].label]!
                                      .data,
                                )
                              : Container(
                                  color: Colors.grey,
                                  width: double.infinity,
                                  child: const Text(''),
                                ),
                        ),
                      ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: () {
                viewModel.addAllStatsId(hitterQuizUi.value!);
              },
              child: const Text('隠す'),
            )
          ],
        );
      },
    );
  }
}
