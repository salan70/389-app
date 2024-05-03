import 'package:flutter/material.dart';

import '../../../../core/util/extension/context_extension.dart';
import '../button/my_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.confirmText,
    required this.onPressedYes,
  });

  final String confirmText;
  final VoidCallback onPressedYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('確認'),
      content: Text(confirmText),
      actions: <Widget>[
        MyButton(
          buttonName: 'confirm_no_button',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const Text('いいえ'),
        ),
        MyButton(
          buttonName: 'confirm_yes_button',
          buttonType: ButtonType.alert,
          onPressed: onPressedYes,
          child: const Text('はい'),
        ),
      ],
    );
  }
}
