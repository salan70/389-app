import 'package:flutter/material.dart';

import '../../../core/common_widget/button/my_button.dart';
import 'setting_dialog.dart';

class OpenSettingButton extends StatelessWidget {
  const OpenSettingButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'open_setting_button',
      buttonType: buttonType,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => const SettingDialog(),
        );
      },
      child: Text(
        'その他',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        ),
      ),
    );
  }
}
