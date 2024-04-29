import 'package:flutter/material.dart';

import '../../page/prepare_quiz_page.dart';
import '../common/button/my_button.dart';

class ToPrepareQuizButton extends StatelessWidget {
  const ToPrepareQuizButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_prepare_quiz_button',
      buttonType: buttonType,
      child: FittedBox(
        child: Text(
          'クイズの条件を設定',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const PrepareQuizPage(),
            settings: const RouteSettings(
              name: '/prepare_quiz_page',
            ),
          ),
        );
      },
    );
  }
}
