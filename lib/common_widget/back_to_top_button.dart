import 'package:flutter/material.dart';

import 'my_button.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'back_to_top_button',
      buttonType: buttonType,
      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      child: const Text('TOPへ戻る'),
    );
  }
}
