import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/quiz/hitter_quiz/hitter_quiz_state.dart';

/// Quizの画面を表示するWidget
/// willUpdateがtrueの場合、このhitterQuizStateProviderをwatch（監視）される
/// falseの場合、hitterQuizStateProviderをreadする
/// （プロバイダーが更新されても再描画されない）。
class QuizWidget extends ConsumerWidget {
  const QuizWidget({super.key, required this.willRebuild});

  final bool willRebuild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuiz = willRebuild
        ? ref.watch(hitterQuizStateProvider)
        : ref.read(hitterQuizStateProvider);

    return hitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (data) {
        final selectedStatsList = data!.selectedStatsList;
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
                final year = data.yearList[index];
                final statsMap = data.statsMapList[index];
                final unveilCount = data.unveilCount;

                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            year,
                          ),
                        ),
                      ),
                    ),
                    for (final selectedStats in selectedStatsList)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: (statsMap[selectedStats]!.unveilOrder <
                                  unveilCount)
                              ? FittedBox(
                                  child: Text(
                                    statsMap[selectedStats]!.data,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
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
