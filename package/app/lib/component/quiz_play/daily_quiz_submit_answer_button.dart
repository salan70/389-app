import 'package:flutter/material.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';

class DailyQuizSubmitAnswerButton extends StatelessWidget {
  const DailyQuizSubmitAnswerButton({
    super.key,
    required this.buttonType,
    required this.hitter,
    required this.onTapSubmitAnswer,
  });

  final ButtonType buttonType;

  /// 回答として入力された [Hitter].
  final Hitter? hitter;

  /// 回答を送信するボタンが押された際の処理。
  final VoidCallback onTapSubmitAnswer;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'submit_answer_button',
      buttonType: buttonType,
      onPressed: hitter == null ? null : () async => onTapSubmitAnswer,
      child: const Text('回答する'),
    );
  }
}
