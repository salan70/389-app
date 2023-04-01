import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/async_value_handler.dart';
import '../../../../quiz/application/hitter_quiz_state.dart';
import '../../../../quiz/domain/hitter_quiz.dart';

class ShowAnswerButton extends ConsumerWidget {
  const ShowAnswerButton({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler(
      value: ref.watch(hitterQuizStateProvider),
      builder: (HitterQuiz hitterQuiz) {
        return MyButton(
          isMain: isMain,
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return AlertDialog(
                  title: const Text('正解は...'),
                  content: Text('${hitterQuiz.name}選手でした！'),
                  actions: [
                    TextButton(
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
