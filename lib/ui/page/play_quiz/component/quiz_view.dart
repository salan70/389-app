import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../repository/supabase/hitter_repository.dart';
import 'quiz_event_buttons_view_model.dart';

class QuizView extends ConsumerWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizUi = ref.watch(hitterQuizUiProvider);
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);

    return hitterQuizUi.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Text('Error: $err'),
      data: (data) {
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
                final idList = id2DList[cIdx];

                return Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          stats['年度']!,
                        ),
                      ),
                    ),
                    for (int rIdx = 0; rIdx < selectedStatsList.length; rIdx++)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (openedIdList.contains(idList[rIdx]))
                              ? Text(
                                  stats[
                                      data.selectedStatsTypeList[rIdx].label]!,
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
          ],
        );
      },
    );
  }
}
