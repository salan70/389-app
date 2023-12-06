import 'package:flutter/material.dart';

import 'my_button.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'back_button',
      buttonType: buttonType,
      onPressed: Navigator.of(context).pop,
      child: const Text('戻る'),
    );
  }
}
