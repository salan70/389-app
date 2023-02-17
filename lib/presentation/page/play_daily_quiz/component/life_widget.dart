import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';

class LifeWidget extends ConsumerWidget {
  const LifeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullscreenWidth = MediaQuery.of(context).size.width;
    final hitterQuiz = ref.watch(hitterQuizStateProvider);

    return Align(
      child: SizedBox(
        width: fullscreenWidth / 2,
        child: hitterQuiz.maybeWhen(
          orElse: Container.new,
          data: (data) {
            Icon favoriteIcon(int borderCount) {
              if (data!.incorrectCount < borderCount) {
                return const Icon(Icons.favorite_rounded);
              }
              return const Icon(Icons.favorite_border_rounded);
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                favoriteIcon(1),
                favoriteIcon(2),
                favoriteIcon(3),
              ],
            );
          },
        ),
      ),
    );
  }
}
