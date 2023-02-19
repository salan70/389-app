import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // 回答入力用のTextFieldのフォーカスを外す
            FocusManager.instance.primaryFocus?.unfocus();

            if (hitterQuizService.canOpen()) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return const ConfirmOpenAllDialog();
                },
              );
            }
          },
          child: const Text('全ての成績を表示'),
        ),
        TextButton(
          onPressed: () {
            // 回答入力用のTextFieldのフォーカスを外す
            FocusManager.instance.primaryFocus?.unfocus();

            if (hitterQuizService.canOpen()) {
              hitterQuizService.openRandom();
            }
          },
          child: const Text('次の成績を表示'),
        ),
      ],
    );
  }
}

class ConfirmOpenAllDialog extends ConsumerWidget {
  const ConfirmOpenAllDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);

    return AlertDialog(
      title: const Text('確認'),
      content: const Text('本当に全ての成績を表示しますか？'),
      actions: <Widget>[
        TextButton(
          child: const Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          onPressed: () {
            hitterQuizService.openAll();
            Navigator.pop(context);
          },
          child: Text(
            'はい',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      ],
    );
  }
}
