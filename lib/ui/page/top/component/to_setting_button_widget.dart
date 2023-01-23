import 'package:flutter/material.dart';

class ToSettingButtonWidget extends StatelessWidget {
  const ToSettingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.topRight,
      onPressed: () {
        // TODO(me): 設定画面へ遷移させる
      },
      icon: const Icon(Icons.settings_rounded),
    );
  }
}
