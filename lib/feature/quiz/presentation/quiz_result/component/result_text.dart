import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';

class ResultText extends ConsumerWidget {
  const ResultText.normal({super.key}) : quizType = QuizType.normal;

  const ResultText.daily({super.key}) : quizType = QuizType.daily;

  final QuizType quizType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo: .value つかうの多分良くない
    final hitterQuiz = ref.watch(hitterQuizNotifierProvider(quizType)).value!;

    return Center(
      child: SizedBox(
        height: 64,
        child: hitterQuiz.isCorrect
            ? const Text('正解！')
            : Column(
                children: [
                  const Text('残念...'),
                  Text('正解は、${hitterQuiz.name}選手でした。'),
                ],
              ),
      ),
    );
  }
}
