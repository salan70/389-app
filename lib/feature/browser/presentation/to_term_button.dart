import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/constant/button_type_constant.dart';
import '../../../util/constant/strings_constant.dart';
import '../application/browser_service.dart';

class ToTermButton extends ConsumerWidget {
  const ToTermButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonType: ButtonType.sub,
      onPressed: () {
        ref.read(browserServiceProvider).launchBrowser(termsUrl);
      },
      child: Stack(
        children: const [
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
