import 'package:flutter/material.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/button_type_constant.dart';
import 'setting_dialog.dart';

class ToSettingButton extends StatelessWidget {
  const ToSettingButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return MyButton(
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
