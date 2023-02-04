import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../quiz_result_view_model.dart';

class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(quizResultViewModelProvider);

    return Center(
      child: TextButton(
        onPressed: () {
          viewModel.shareImageAndText('result_quiz_widget', globalKey);
        },
        child: const Text('クイズをシェア！'),
      ),
    );
  }
}
