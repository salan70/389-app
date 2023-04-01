import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_handler.dart';
import '../../../../util/constant/colors_constant.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/extension/date_time_extension.dart';
import '../../application/quiz_result_service.dart';
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
          child: GridView.builder(
            itemCount: quizResultList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final quizResult = quizResultList[index];
              return InkWell(
                onTap: () {
                  final quizResultService = ref.read(quizResultServiceProvider);

                  quizResultService.updateQuizStateFromResult(
                    quizResult,
                    QuizType.normal,
                  );
                  quizResultService.updateQuizResultStateFromIndex(index);

                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => const NormalQuizGalleryDetailPage(),
                    ),
                  );
                },
                child: Card(
                  color: backgroundColor,
                  child: Column(
                    children: [
                      Text(quizResult.resultRank.label),
                      Text('${quizResult.updatedAt.toFormattedString()}にプレイ'),
                      Text('${quizResult.unveilPercentage}%表示'),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
