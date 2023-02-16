import 'package:flutter/material.dart';

import '../../page/quiz_result/quiz_result_page.dart';

class RetireConfirmDialog extends StatelessWidget {
  const RetireConfirmDialog({super.key, required this.confirmText});

  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('確認'),
      content: Text(confirmText),
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
          child: Text(
            'はい',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const QuizResultPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
