import 'package:flutter/material.dart';

import '../../../core/common_widget/button/my_button.dart';

class ToPlayNormalQuizFromPrepareButton extends StatelessWidget {
  const ToPlayNormalQuizFromPrepareButton({
    super.key,
    required this.buttonType,
    required this.onTapPlayNormalQuiz,
  });

  final ButtonType buttonType;
  final VoidCallback onTapPlayNormalQuiz;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_play_normal_quiz_from_prepare_button',
      buttonType: buttonType,
      onPressed: onTapPlayNormalQuiz,
      child: const Text('クイズをプレイ！'),
    );
  }
}
