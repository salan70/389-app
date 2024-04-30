import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widget/button/my_button.dart';
import '../../router/app_router.dart';

class ToQuizSettingButton extends StatelessWidget {
  const ToQuizSettingButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_quiz_setting_button',
      buttonType: buttonType,
      child: FittedBox(
        child: Text(
          'クイズの条件を設定',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
      onPressed: () => context.pushRoute(QuizSettingRoute()),
    );
  }
}
