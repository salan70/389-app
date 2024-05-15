import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/router/app_router.dart';
import '../../../core/util/colors_constant.dart';
import '../../../core/util/extension/result_rank_extension.dart';
import '../common/async_value_handler.dart';

class NormalQuizGalleryList extends ConsumerWidget {
  const NormalQuizGalleryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(normalQuizResultListProvider),
      builder: (List<HitterQuizResult> quizResultList) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              quizResultList.isEmpty
                  ? const Center(
                      child: Text(
                        'まだ履歴がありません。\n'
                        'プレイしたクイズの履歴が表示されます。',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: quizResultList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        final quizResult = quizResultList[index];
                        return InkWell(
                          onTap: () => context.pushRoute(
                            QuizHistoryNormalRoute(quizResult: quizResult),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                quizResult.resultRank.smallLabelWidget,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quizResult.updatedAt.toFormattedString(),
                                    ),
                                    FittedBox(
                                      child: Text(
                                          '${quizResult.unveilPercentage}%表示'
                                          '（${quizResult.hitterQuiz.unveilCount}/${quizResult.totalStatsCount})'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 120),
            ],
          ),
        );
      },
    );
  }
}
