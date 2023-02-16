import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/share_quiz_result/share_quiz_result_service.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareQuizResultService = ref.watch(shareQuizResultServiceProvider);

    return Center(
      child: TextButton(
        onPressed: () {
          shareQuizResultService.shareImageAndText(
            'result_quiz_widget',
            globalKey,
          );
        },
        child: const Text('クイズをシェア！'),
      ),
    );
  }
}
