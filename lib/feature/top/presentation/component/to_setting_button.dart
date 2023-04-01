import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';

import 'setting_dialog.dart';

class ToSettingButton extends StatelessWidget {
  const ToSettingButton({
    super.key,
    required this.isMain,
  });

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      isMain: isMain,
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
