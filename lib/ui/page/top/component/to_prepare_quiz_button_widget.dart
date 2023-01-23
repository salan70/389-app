import 'package:flutter/material.dart';

import '../../prepare_quiz/prepare_quiz_page.dart';

class ToPrepareQuizButtonWidget extends StatelessWidget {
  const ToPrepareQuizButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('クイズの条件を設定'),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const PrepareQuizPage(),
          ),
        );
      },
    );
  }
}
