import 'package:flutter/material.dart';

import '../../quiz_result/quiz_result_page.dart';

class RetireConfirmDialog extends StatelessWidget {
  const RetireConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('確認'),
      content: const Text('本当に諦めますか？'),
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
