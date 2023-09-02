import 'package:flutter/material.dart';

import '../util/constant/button_type_constant.dart';
import 'my_button.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonType: buttonType,
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Text('TOPへ戻る'),
    );
  }
}
