import 'package:flutter/material.dart';

import '../common/button/my_button.dart';
import 'notification_setting_dialog.dart';


class ToNotificationSettingButton extends StatelessWidget {
  const ToNotificationSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'to_notification_setting_button',
      buttonType: ButtonType.sub,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => const NotificationSettingDialog(),
        );
      },
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
