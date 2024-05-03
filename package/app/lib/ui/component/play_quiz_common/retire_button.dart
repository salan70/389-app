import 'package:flutter/material.dart';

import '../common/button/my_button.dart';

class RetireButton extends StatelessWidget {
  const RetireButton({
    super.key,
    required this.buttonType,
    required this.onTapRetire,
  });

  final ButtonType buttonType;

  final VoidCallback onTapRetire;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'retire_button',
      buttonType: buttonType,
      onPressed: onTapRetire,
      child: const Text('諦める'),
    );
  }
}
