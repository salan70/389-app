import 'package:flutter/material.dart';

import '../../../../common_widget/my_button.dart';
import '../../../search_condition/presentation/prepare_quiz_page.dart';

class ToPrepareQuizButton extends StatelessWidget {
  const ToPrepareQuizButton({
    super.key,
    required this.isMain,
  });

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      isMain: isMain,
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
          ),
        );
      },
    );
  }
}
