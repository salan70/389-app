import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../util/constant/button_type_constant.dart';
import '../../../application/hitter_quiz_service.dart';

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);
    const buttonWidth = 160.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: buttonWidth,
          child: MyButton(
            buttonType: ButtonType.sub,
            onPressed: () {
              // 回答入力用のTextFieldのフォーカスを外す
              FocusManager.instance.primaryFocus?.unfocus();

              if (hitterQuizService.canOpen()) {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return ConfirmDialog(
                      confirmText: '本当に全ての成績を表示しますか？',
                      onPressedYes: () {
                        hitterQuizService.openAll();
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
          width: buttonWidth,
          child: MyButton(
            buttonType: ButtonType.sub,
            onPressed: () {
              // 回答入力用のTextFieldのフォーカスを外す
              FocusManager.instance.primaryFocus?.unfocus();

              if (hitterQuizService.canOpen()) {
                hitterQuizService.openRandom();
              }
            },
            child: const Text('次の成績を表示'),
          ),
        ),
      ],
    );
  }
}
