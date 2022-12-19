import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constant/hitting_stats/stats_type.dart';
import '../../../../repository/supabase/supabase_hitter_repository.dart';

class QuizView extends ConsumerWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);

    return hitterQuizUi.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Text('Error: $err'),
      data: (data) {
        // viewModel.addAllStatsId(data!);
        final selectedStatsTypeList = data!.selectedStatsTypeList;
        return Column(
          children: [
            Row(
              children: [
                for (final selectedStatsType in selectedStatsTypeList)
                  Expanded(
                    child: Center(
                      child: Text(selectedStatsType.label),
                    ),
                  ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.statsMapList.length,
              itemBuilder: (_, cIdx) {
                final statsMap = data.statsMapList[cIdx];
                final closedStatsIdList = data.closedStatsIdList;

                return Row(
                  children: [
                    for (final selectedStatsType in selectedStatsTypeList)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (closedStatsIdList.contains(
                            statsMap[selectedStatsType.label]!.id,
                          ))
                              ? Container(
                                  color: Colors.grey,
                                  width: double.infinity,
                                  child: const Text(''),
                                )
                              : Text(
                                  statsMap[selectedStatsType.label]!.data,
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
