import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../../core/common_widget/button/my_button.dart';

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
