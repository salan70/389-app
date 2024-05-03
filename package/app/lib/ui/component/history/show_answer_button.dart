import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/util/extension/context_extension.dart';
import '../../controller/common/navigator_key_controller.dart';
import '../common/button/my_button.dart';

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
        // TODO(me): controller で書く。
        ref.read(navigatorKeyControllerProvider).showDialogWithChild(
              barrierDismissible: false,
              child: AlertDialog(
                title: const Text('正解は...'),
                content: Text('${quizResult.name}選手でした！'),
                actions: [
                  MyButton(
                    buttonName: 'OK',
                    buttonType: ButtonType.main,
                    onPressed: context.pop,
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
      },
      child: const Text('正解を確認'),
    );
  }
}
