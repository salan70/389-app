import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/my_button.dart';
import 'inquiry_button.dart';
import 'to_notification_setting_button.dart';
import 'to_privacy_policy_button.dart';
import 'to_term_button.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const largeButtonWidth = 240.0;
    const smallButtonWidth = 120.0;

    return const Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text('その他'),
            SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: InquiryButton(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToTermButton(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToPrivacyPolicyButton(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToNotificationSettingButton(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: smallButtonWidth,
                child: CloseButton(),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'close_button',
      buttonType: ButtonType.main,
      onPressed: () async {
        Navigator.pop(context);
      },
      child: const Center(child: Text('閉じる')),
    );
  }
}
