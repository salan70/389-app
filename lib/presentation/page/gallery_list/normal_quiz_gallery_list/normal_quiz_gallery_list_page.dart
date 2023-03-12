import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../application/user/user_state.dart';
import '../../../../domain/entity/hitter_quiz_result.dart';
import '../../../../util/constant/colors_constant.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../component/async_value_handler.dart';
import '../../gallery_detail/normal_quiz_gallery_detail_page.dart';

class NormalQuizGalleryListPage extends ConsumerWidget {
  const NormalQuizGalleryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(normalQuizResultListStateProvider),
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
                  ref.read(hitterQuizServiceProvider).fromHitterQuizResult(
                        quizResult,
                        QuizType.normal,
                      );
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
                      Text('${quizResult.formattedUpdatedAtText}にプレイ'),
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
