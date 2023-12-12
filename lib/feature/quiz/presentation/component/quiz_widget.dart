import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../util/constant/hitting_stats_constant.dart';
import '../../application/hitter_quiz_notifier.dart';

/// Quizの画面を表示するWidget
/// willUpdateがtrueの場合、このhitterQuizStateProviderをwatch（監視）される
/// falseの場合、hitterQuizStateProviderをreadする
/// （プロバイダーが更新されても再描画されない）。
class QuizWidget extends ConsumerWidget {
  const QuizWidget({super.key, required this.willRebuild});

  final bool willRebuild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 結果画面にて再度クイズをプレイすると、hitterQuizStateProviderが更新されるため、
    /// willUpdateでreadとwatchを分けている
    final asyncHitterQuiz = willRebuild
        ? ref.watch(hitterQuizNotifierProvider(QuizType.normal))
        : ref.read(hitterQuizNotifierProvider(QuizType.normal));

    return asyncHitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (hitterQuiz) {
        final selectedStatsList = hitterQuiz.selectedStatsList;
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
              itemCount: hitterQuiz.statsMapList.length,
              itemBuilder: (_, index) {
                final year = hitterQuiz.yearList[index];
                final statsMap = hitterQuiz.statsMapList[index];
                final unveilCount = hitterQuiz.unveilCount;

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
