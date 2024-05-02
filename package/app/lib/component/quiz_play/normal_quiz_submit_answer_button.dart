import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';

class NormalQuizSubmitAnswerButton extends ConsumerWidget {
  const NormalQuizSubmitAnswerButton({
    super.key,
    required this.buttonType,
    required this.enteredHitter,
    required this.onSubmitAnswer,
  });

  final ButtonType buttonType;
  final Hitter? enteredHitter;
  final VoidCallback onSubmitAnswer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'submit_answer_button',
      buttonType: buttonType,
      onPressed: enteredHitter == null ? null : onSubmitAnswer,
      child: const Text('回答する'),
    );
  }
}
