import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/my_button.dart';
import '../../../util/constant/strings_constant.dart';
import '../application/browser_service.dart';

class ToTermButton extends ConsumerWidget {
  const ToTermButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_term_button',
      buttonType: ButtonType.sub,
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(termsUrl);
      },
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.description_rounded),
          ),
          Center(child: Text('利用規約')),
        ],
      ),
    );
  }
}
