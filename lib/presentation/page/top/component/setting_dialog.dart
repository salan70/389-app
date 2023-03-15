import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature/browser/presentation/to_privacy_policy_button.dart';
import '../../../../feature/browser/presentation/to_term_button.dart';
import '../../../../feature/inquiry/presentation/inquiry_button.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 320,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text('その他'),
              const SizedBox(
                height: 24,
              ),
              const InquiryButton(),
              const SizedBox(
                height: 16,
              ),
              const ToTermButton(),
              const SizedBox(
                height: 16,
              ),
              const ToPrivacyPolicyButton(),
              const SizedBox(
                height: 16,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text('閉じる'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
