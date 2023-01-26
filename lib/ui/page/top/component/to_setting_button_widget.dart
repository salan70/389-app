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
        // TODO(me): 設定画面へ遷移させる
        showDialog<void>(
          context: context,
          builder: (context) => const SettingDialog(),
        );
      },
      icon: const Icon(
        Icons.info_outline_rounded,
      ),
      label: const Text('その他'),
    );
  }
}
