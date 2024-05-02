import 'package:flutter/material.dart';

import '../../../core/common_widget/button/my_button.dart';

class ReplayButton extends StatelessWidget {
  const ReplayButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
  });

  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'replay_button',
      buttonType: buttonType,
      onPressed: onPressed,
      child: const Text('同じ条件でもう一度！'),
    );
  }
}
