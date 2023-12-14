import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../domain/hitter_quiz.dart';

class ResultText extends ConsumerWidget {
  const ResultText.normal({super.key, required this.hitterQuiz})
      : quizType = QuizType.normal;

  const ResultText.daily({super.key, required this.hitterQuiz})
      : quizType = QuizType.daily;

  final QuizType quizType;
  final HitterQuiz hitterQuiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
