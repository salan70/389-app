import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';

class LifeWidget extends ConsumerWidget {
  const LifeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    final asyncHitterQuiz =
        ref.watch(hitterQuizNotifierProvider(QuizType.daily));

    return Align(
      child: SizedBox(
        width: fullScreenWidth / 2,
        child: asyncHitterQuiz.maybeWhen(
          orElse: Container.new,
          data: (hitterQuiz) {
            Icon favoriteIcon(int borderCount) {
              if (hitterQuiz.incorrectCount < borderCount) {
                return const Icon(Icons.favorite_rounded);
              }
              return const Icon(Icons.favorite_border_rounded);
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                favoriteIcon(1),
                favoriteIcon(2),
                const Icon(Icons.favorite_rounded),
              ],
            );
          },
        ),
      ),
    );
  }
}
