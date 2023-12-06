import 'package:flutter/material.dart';

import '../util/error_message.dart';
import 'my_button.dart';

/// エラーを知らせるダイアログ
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'エラー',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: Text(error.errorMessage),
      actions: [
        MyButton(
          buttonName: 'error_dialog_ok_button',
          buttonType: ButtonType.main,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
