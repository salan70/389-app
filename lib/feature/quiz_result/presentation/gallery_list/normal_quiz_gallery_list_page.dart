import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../../../util/constant/colors_constant.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/extension/date_time_extension.dart';
import '../../application/quiz_result_state.dart';
import '../../domain/hitter_quiz_result.dart';
import '../gallery_detail/normal_quiz_gallery_detail_page.dart';

class NormalQuizGalleryListPage extends ConsumerWidget {
  const NormalQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(normalQuizResultListProvider),
      builder: (List<HitterQuizResult> quizResultList) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizResultList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final quizResult = quizResultList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (_) => NormalQuizGalleryDetailPage(
                            quizResult: quizResult,
                          ),
                          settings: const RouteSettings(
                            name: '/normal_quiz_gallery_detail_page',
                          ),
                        ),
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(color: primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          quizResult.resultRank.smallLabellWidget,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(quizResult.updatedAt.toFormattedString()),
                              FittedBox(
                                child: Text('${quizResult.unveilPercentage}%表示'
                                    '（${quizResult.unveilCount}/${quizResult.totalStatsCount})'),
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
