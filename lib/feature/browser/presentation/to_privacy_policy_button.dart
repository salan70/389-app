import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/constant/strings_constant.dart';
import '../application/browser_service.dart';

class ToPrivacyPolicyButton extends ConsumerWidget {
  const ToPrivacyPolicyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(privacyPolicyUrl);
      },
      icon: const Icon(Icons.person_rounded),
      label: const Text('プライバシーポリシー'),
    );
  }
}
