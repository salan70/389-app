import 'package:flutter/material.dart';

import 'setting_dialog_widget.dart';

class ToSettingButtonWidget extends StatelessWidget {
  const ToSettingButtonWidget({
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
