import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/button/my_button.dart';

class StartNormalQuizFromTopButton extends ConsumerWidget {
  const StartNormalQuizFromTopButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
  });

  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'start_normal_quiz_from_top_button',
      buttonType: buttonType,
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          'クイズをプレイ！',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
    );
  }
}
