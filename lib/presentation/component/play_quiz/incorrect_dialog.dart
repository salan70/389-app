import 'package:flutter/material.dart';

import '../../page/quiz_result/quiz_result_page.dart';
import '../confirm_dialog.dart';

class IncorrectDialog extends StatelessWidget {
  const IncorrectDialog({
    super.key,
    required this.selectedHitter,
    required this.retireConfirmText,
  });

  // Providerで保持するほうが良いかも？
  final String selectedHitter;
  final String retireConfirmText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('残念...'),
      content: Text('$selectedHitter選手ではありません'),
      actions: <Widget>[
        TextButton(
          child: Text(
            '諦める',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onPressed: () async {
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return ConfirmDialog(
                  confirmText: retireConfirmText,
                  nextWidget: const QuizResultPage(),
                );
              },
            );
          },
        ),
        TextButton(
          child: const Text('もう一度回答する'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
