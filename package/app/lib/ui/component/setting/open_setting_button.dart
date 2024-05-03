import 'package:flutter/material.dart';

import '../common/button/my_button.dart';

class OpenSettingButton extends StatelessWidget {
  const OpenSettingButton({
    super.key,
    required this.buttonType,
    required this.onTap,
  });

  final ButtonType buttonType;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'open_setting_button',
      buttonType: buttonType,
      onPressed: onTap,
      child: Text(
        'その他',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        ),
      ),
    );
  }
}
