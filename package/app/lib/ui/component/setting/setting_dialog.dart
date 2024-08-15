import 'package:flutter/material.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';
import '../common/navigation_button/to_notification_setting_button.dart';
import '../common/navigation_button/to_privacy_policy_button.dart';
import '../common/navigation_button/to_term_button.dart';
import 'inquiry_button.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({
    super.key,
    required this.onTapNotificationSetting,
  });

  final VoidCallback onTapNotificationSetting;

  @override
  Widget build(BuildContext context) {
    const largeButtonWidth = 240.0;
    const smallButtonWidth = 120.0;

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text('その他'),
            const SizedBox(height: 24),
            const Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: InquiryButton(),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToTermButton(),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToPrivacyPolicyButton(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: largeButtonWidth,
                child: ToNotificationSettingButton(
                  onTap: onTapNotificationSetting,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: SizedBox(
                width: smallButtonWidth,
                child: _CloseButton(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'close_button',
      buttonType: ButtonType.main,
      onPressed: context.pop,
      child: const Center(child: Text('閉じる')),
    );
  }
}
