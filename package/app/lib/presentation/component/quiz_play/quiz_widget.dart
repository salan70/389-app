import 'package:flutter/material.dart';
import 'package:model/model.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key, required this.hitterQuiz});

  final HitterQuiz hitterQuiz;

  @override
  Widget build(BuildContext context) {
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
                                color: Theme.of(context).colorScheme.primary,
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
  }
}
