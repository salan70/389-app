import 'package:flutter/material.dart';

import '../../../../core/util/extension/context_extension.dart';
import '../button/my_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.confirmText,
    required this.onAccept,
    this.acceptWidget = const Text('はい'),
  });

  final String confirmText;
  final VoidCallback onAccept;
  final Widget acceptWidget;

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
          onPressed: () {
            onAccept();
            context.pop();
          },
          child: acceptWidget,
        ),
      ],
    );
  }
}
