import 'package:baseball_quiz_app/util/constant/colors_constant.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/user/user_state.dart';
import '../../../../domain/entity/hitter_quiz_result.dart';
import '../../../component/async_value_handler.dart';

class NormalQuizGalleryPage extends ConsumerWidget {
  const NormalQuizGalleryPage({super.key});

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
              return Card(
                color: backgroundColor,
                child: Column(
                  children: [
                    Text(quizResult.resultRank.label),
                    Text(quizResult.updatedAt.toString()),
                    // Text(quizResult),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
