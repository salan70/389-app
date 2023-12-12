import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../application/hitter_quiz_notifier.dart';

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons.normal({super.key}) : quizType = QuizType.normal;

  const QuizEventButtons.daily({super.key}) : quizType = QuizType.daily;

  final QuizType quizType;

  static const _buttonWidth = 160.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(hitterQuizNotifierProvider(quizType).notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: _buttonWidth,
          child: MyButton(
            buttonName: 'show_all_stat_button',
            buttonType: ButtonType.sub,
            onPressed: () {
              // 回答入力用のTextFieldのフォーカスを外す
              FocusManager.instance.primaryFocus?.unfocus();

              if (notifier.canOpen()) {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return ConfirmDialog(
                      confirmText: '本当に全ての成績を表示しますか？',
                      onPressedYes: () {
                        notifier.openAll();
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }
            },
            child: const Text('全ての成績を表示'),
          ),
        ),
        SizedBox(
          width: _buttonWidth,
          child: MyButton(
            buttonName: 'show_next_stat_button',
            buttonType: ButtonType.sub,
            onPressed: () {
              // 回答入力用のTextFieldのフォーカスを外す
              FocusManager.instance.primaryFocus?.unfocus();

              if (notifier.canOpen()) {
                notifier.openRandom();
              }
            },
            child: const Text('次の成績を表示'),
          ),
        ),
      ],
    );
  }
}
