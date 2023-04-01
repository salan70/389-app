import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../browser/presentation/to_privacy_policy_button.dart';
import '../../../browser/presentation/to_term_button.dart';
import '../../../inquiry/presentation/inquiry_button.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const lergeButtonWidth = 240.0;
    const smallButtonWidth = 120.0;

    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 320,
          child: Column(
            children: const [
              SizedBox(height: 16),
              Text('その他'),
              SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: lergeButtonWidth,
                  child: InquiryButton(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: lergeButtonWidth,
                  child: ToTermButton(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: lergeButtonWidth,
                  child: ToPrivacyPolicyButton(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: smallButtonWidth,
                  child: CloseButton(),
                ),
              ),
            ],
          ),
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
      isMain: true,
      onPressed: () async {
        Navigator.pop(context);
      },
      child: const Center(child: Text('閉じる')),
    );
  }
}
