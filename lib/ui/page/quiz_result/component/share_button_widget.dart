import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'share_button_view_model.dart';

class ShareButtonWidget extends ConsumerWidget {
  const ShareButtonWidget({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(shareButtonViewModelProvider);

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
