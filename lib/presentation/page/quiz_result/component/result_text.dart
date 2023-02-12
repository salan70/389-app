import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/hitter_quiz/hitter_quiz_state.dart';

class ResultText extends ConsumerWidget {
  const ResultText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCorrect = ref.watch(isCorrectQuizStateProvider);

    return Center(
      child: SizedBox(
        height: 64,
        child: isCorrect ? const CorrectText() : const InCorrectText(),
      ),
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

/// hitterQuizStateProviderをref.readしている
/// 上記プロバイダーを更新しても、このWidgetは再描画されないことに注意
class InCorrectText extends ConsumerWidget {
  const InCorrectText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answer = ref.read(hitterQuizStateProvider).value!.name;

    return Column(
      children: [
        const Text('残念...'),
        Text('正解は、$answer選手でした。'),
      ],
    );
  }
}
