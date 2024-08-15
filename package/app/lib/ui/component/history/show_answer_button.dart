import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';

class ShowAnswerButton extends ConsumerWidget {
  const ShowAnswerButton({
    super.key,
    required this.buttonType,
    required this.onTap,
  });

  final ButtonType buttonType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'show_answer_button',
      buttonType: buttonType,
      onPressed: onTap,
      child: const Text('正解を確認'),
    );
  }
}

class AlertAnswerDialog extends StatelessWidget {
  const AlertAnswerDialog({super.key, required this.hitterName});

  /// 回答となる選手の名前。
  final String hitterName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('正解は...'),
      content: Text('$hitterName選手でした！'),
      actions: [
        MyButton(
          buttonName: 'OK',
          buttonType: ButtonType.main,
          onPressed: context.pop,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
