import 'package:flutter/material.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/button_type_constant.dart';
import '../../../search_condition/presentation/prepare_quiz_page.dart';

class ToPrepareQuizButton extends StatelessWidget {
  const ToPrepareQuizButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
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
