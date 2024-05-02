import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/common_widget/dialog/confirm_dialog.dart';

class RetireButton extends ConsumerWidget {
  const RetireButton.normal({
    super.key,
    required this.buttonType,
    required this.onRetire,
  }) : quizType = QuizType.normal;

  const RetireButton.daily({
    super.key,
    required this.buttonType,
    required this.onRetire,
  }) : quizType = QuizType.daily;

  final ButtonType buttonType;
  final QuizType quizType;

  final VoidCallback onRetire;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'retire_button',
      buttonType: buttonType,
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => ConfirmDialog(
            confirmText: quizType.retireConfirmText,
            onPressedYes: onRetire,
          ),
        );
      },
      child: const Text('諦める'),
    );
  }
}
