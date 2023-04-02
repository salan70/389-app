import 'package:flutter/material.dart';

import '../../../common_widget/my_button.dart';
import '../../../util/constant/button_type_constant.dart';
import '../../../util/error_message.dart';

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
          buttonType: ButtonType.main,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
