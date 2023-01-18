import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/navigator_key_providers.dart';
import 'share_button_view_model.dart';

class ShareButtonWidget extends ConsumerWidget {
  const ShareButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(shareButtonViewModelProvider);
    final shareKey = ref.watch(resultQuizWidgetKeyProvider);

    return Center(
      child: TextButton(
        onPressed: () {
          // TODO(me): シェア機能実装する
          viewModel.shareImageAndText('result_quiz_widget', shareKey);
        },
        child: const Text('クイズをシェア！'),
      ),
    );
  }
}
