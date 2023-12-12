import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/async_value_handler.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../../quiz/domain/hitter_quiz.dart';

class ShowAnswerButton extends ConsumerWidget {
  const ShowAnswerButton.normal({super.key, required this.buttonType})
      : quizType = QuizType.normal;

  const ShowAnswerButton.daily({super.key, required this.buttonType})
      : quizType = QuizType.daily;

  final ButtonType buttonType;
  final QuizType quizType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(hitterQuizNotifierProvider(quizType)),
      builder: (HitterQuiz hitterQuiz) {
        return MyButton(
          buttonName: 'show_answer_button',
          buttonType: buttonType,
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  title: const Text('正解は...'),
                  content: Text('${hitterQuiz.name}選手でした！'),
                  actions: [
                    MyButton(
                      buttonName: 'OK',
                      buttonType: ButtonType.main,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('正解を確認'),
        );
      },
    );
  }
}
