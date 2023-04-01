import 'package:baseball_quiz_app/common_widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/share_quiz_result_service.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.isMain,
    required this.globalKey,
    required this.shareText,
  });

  final bool isMain;
  final GlobalKey globalKey;
  final String shareText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      isMain: isMain,
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
