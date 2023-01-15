import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/hitter_quiz_ui_state.dart';

class QuizWidget extends ConsumerWidget {
  const QuizWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizUi = ref.watch(hitterQuizUiNotifierProvider);

    return hitterQuizUi.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, _) => Text('Error: $err'),
      data: (data) {
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
              itemBuilder: (_, index) {
                final statsMap = data.statsMapList[index];
                final hiddenStatsIdList = data.hiddenStatsIdList;

                return Row(
                  children: [
                    for (final selectedStats in selectedStatsList)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (hiddenStatsIdList.contains(
                            statsMap[selectedStats]!.id,
                          ))
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
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
