import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/quiz/application/share_quiz_result_service.dart';
import '../my_button.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.buttonType,
    required this.globalKey,
    required this.shareText,
  });

  final ButtonType buttonType;
  final GlobalKey globalKey;
  final String shareText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'share_button',
      buttonType: buttonType,
      onPressed: () {
        ref.read(shareQuizResultServiceProvider).shareImageAndText(
              'result_quiz_widget',
              globalKey,
              shareText,
            );
      },
      child: const Text('クイズをシェア！'),
    );
  }
}
