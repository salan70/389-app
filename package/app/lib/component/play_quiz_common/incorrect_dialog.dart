import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/common_widget/dialog/confirm_dialog.dart';

class IncorrectDialog extends StatelessWidget {
  const IncorrectDialog.normal({
    super.key,
    required this.hitterName,
    required this.onAcceptRetire,
  }) : quizType = QuizType.normal;

  const IncorrectDialog.daily({
    super.key,
    required this.hitterName,
    required this.onAcceptRetire,
  }) : quizType = QuizType.daily;

  final QuizType quizType;

  final String hitterName;

  /// 諦めることを承認した際の処理。
  final VoidCallback onAcceptRetire;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('残念...'),
      content: Text('$hitterName選手ではありません'),
      actions: <Widget>[
        MyButton(
          buttonName: 'retire_button',
          buttonType: ButtonType.alert,
          child: const Text('諦める'),
          onPressed: () async {
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) => ConfirmDialog(
                confirmText: quizType.retireConfirmText,
                onPressedYes: onAcceptRetire,
              ),
            );
          },
        ),
        MyButton(
          buttonName: 'try_again_button',
          buttonType: ButtonType.sub,
          onPressed: context.popRoute,
          child: const Text('もう一度回答する'),
        ),
      ],
    );
  }
}
