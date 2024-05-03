import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../button/my_button.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'back_to_top_button',
      buttonType: buttonType,
      onPressed: context.router.popUntilRoot,
      child: const Text('TOPへ戻る'),
    );
  }
}
