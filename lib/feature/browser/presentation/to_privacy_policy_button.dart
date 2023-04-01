import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/my_button.dart';
import '../../../util/constant/strings_constant.dart';
import '../application/browser_service.dart';

class ToPrivacyPolicyButton extends ConsumerWidget {
  const ToPrivacyPolicyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      isMain: false,
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(privacyPolicyUrl);
      },
      child: Stack(
        children: const [
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
