import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../button/my_button.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'back_button',
      buttonType: buttonType,
      onPressed: context.maybePop,
      child: const Text('戻る'),
    );
  }
}
