import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/async_value_handler.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/button_type_constant.dart';
import '../../../../quiz/application/hitter_quiz_state.dart';
import '../../../../quiz/domain/hitter_quiz.dart';

class ShowAnswerButton extends ConsumerWidget {
  const ShowAnswerButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(hitterQuizStateProvider),
      builder: (HitterQuiz hitterQuiz) {
        return MyButton(
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
