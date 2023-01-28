import 'package:flutter/material.dart';

import '../../prepare_quiz/prepare_quiz_page.dart';

class ToPrepareQuizButtonWidget extends StatelessWidget {
  const ToPrepareQuizButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: FittedBox(
        child: Text(
          'クイズの条件を設定',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
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
