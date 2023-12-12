import 'package:baseball_quiz_app/feature/quiz_result/domain/hitter_quiz_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';

class ShowAnswerButton extends ConsumerWidget {
  const ShowAnswerButton({
    super.key,
    required this.buttonType,
    required this.quizResult,
  });

  final ButtonType buttonType;
  final HitterQuizResult quizResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              content: Text('${quizResult.name}選手でした！'),
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
  }
}
