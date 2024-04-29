import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature/browser/application/browser_service.dart';
import '../../../../util/constant/strings_constant.dart';
import '../common/my_button.dart';

class ToPrivacyPolicyButton extends ConsumerWidget {
  const ToPrivacyPolicyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_privacy_policy_button',
      buttonType: ButtonType.sub,
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(privacyPolicyUrl);
      },
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.person_rounded),
          ),
          Center(child: Text('プライバシーポリシー')),
        ],
      ),
    );
  }
}
