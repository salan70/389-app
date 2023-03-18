import 'package:flutter/material.dart';

import '../../../search_condition/presentation/prepare_quiz_page.dart';

class ToPrepareQuizButton extends StatelessWidget {
  const ToPrepareQuizButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: FittedBox(
        child: Text(
          'クイズの条件を設定',
          style: Theme.of(context).textTheme.headlineSmall,
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
