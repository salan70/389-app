import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_quiz_ui_state.dart';
import '../../../../usecase/quiz_usecase.dart';

class ResultTextWidget extends ConsumerWidget {
  const ResultTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCorrect = ref.watch(quizUsecaseProvider).isCorrectHitterQuiz();

    return SizedBox(
      height: 64,
      child: isCorrect ? const CorrectText() : const InCorrectText(),
    );
  }
}

class CorrectText extends StatelessWidget {
  const CorrectText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('正解！');
  }
}

class InCorrectText extends ConsumerWidget {
  const InCorrectText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answer = ref.watch(hitterQuizUiStateProvider).value!.name;

    return Text('残念...\n正解は、$answer選手でした。');
  }
}
