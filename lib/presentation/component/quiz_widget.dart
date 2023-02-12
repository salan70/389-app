import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/quiz/hitter_quiz/hitter_quiz_state.dart';

/// Quizの画面を表示するWidget
/// willUpdateがtrueの場合、このhitterQuizStateProviderをwatch（監視）される
/// falseの場合、hitterQuizStateProviderをreadする
/// （プロバイダーが更新されても再描画されない）。
class QuizWidget extends ConsumerWidget {
  const QuizWidget({super.key, required this.willUpdate});

  final bool willUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuiz = willUpdate
        ? ref.watch(hitterQuizStateProvider)
        : ref.read(hitterQuizStateProvider);

    return hitterQuiz.maybeWhen(
      // TODO(me): 空のWidgetを共通componentとして定義したい
      orElse: Container.new,
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
              padding: EdgeInsets.zero,
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
                              : FittedBox(
                                  child: Text(
                                    statsMap[selectedStats]!.data,
                                  ),
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
