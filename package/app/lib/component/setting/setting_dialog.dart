import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../core/common_widget/navigation_button/to_notification_setting_button.dart';
import '../../core/common_widget/navigation_button/to_privacy_policy_button.dart';
import '../../core/common_widget/navigation_button/to_term_button.dart';
import '../../core/util/extension/context_extension.dart';
import 'inquiry_button.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({
    super.key,
    required this.onTapNotificationSetting,
  });

  final VoidCallback onTapNotificationSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: CloseButton(),
              ),
            ),
            const SizedBox(height: 16),
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
      onPressed: context.pop,
      child: const Center(child: Text('閉じる')),
    );
  }
}
