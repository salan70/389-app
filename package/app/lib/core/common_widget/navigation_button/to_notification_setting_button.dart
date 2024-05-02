import 'package:flutter/material.dart';

import '../../../../core/common_widget/button/my_button.dart';

class ToNotificationSettingButton extends StatelessWidget {
  const ToNotificationSettingButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_notification_setting_button',
      buttonType: ButtonType.sub,
      onPressed: onTap,
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.notifications),
          ),
          Center(child: Text('プッシュ通知')),
        ],
      ),
    );
  }
}
