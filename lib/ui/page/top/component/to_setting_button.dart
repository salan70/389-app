import 'package:flutter/material.dart';

import 'setting_dialog.dart';

class ToSettingButton extends StatelessWidget {
  const ToSettingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => const SettingDialog(),
        );
      },
      icon: const Icon(
        Icons.info_outline_rounded,
      ),
      label: Text(
        'その他',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
