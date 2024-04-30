import 'package:flutter/material.dart';

import '../button/my_button.dart';

/// エラーを知らせるダイアログ
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'エラー',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: const Text('エラーが発生しました。\n'
          '時間をおいて再度お試しください。'),
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
