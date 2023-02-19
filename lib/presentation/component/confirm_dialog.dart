import 'package:flutter/material.dart';

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
      content: Text(confirmText, textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'いいえ',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onPressedYes,
          child: Text(
            'はい',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}
