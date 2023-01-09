import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/supabase/supabase_hitter_repository.dart';

class QuizWidget extends ConsumerWidget {
  const QuizWidget({super.key});

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
        final selectedStatsList = data!.selectedStatsList;
        return Column(
          children: [
            Row(
              children: [
                for (final selectedStats in selectedStatsList)
                  Expanded(
                    child: Center(
                      child: Text(selectedStats),
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
                    for (final selectedStats in selectedStatsList)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (closedStatsIdList.contains(
                            statsMap[selectedStats]!.id,
                          ))
                              ? Container(
                                  color: Colors.grey,
                                  width: double.infinity,
                                  child: const Text(''),
                                )
                              : Text(
                                  statsMap[selectedStats]!.data,
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
