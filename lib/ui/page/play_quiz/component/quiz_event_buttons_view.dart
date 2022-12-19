import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'quiz_event_buttons_view_model.dart';

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(quizEventButtonsViewModelProvider);

    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (viewModel.canRemove()) {
              viewModel.removeRandom();
            } else {
              // TODO(me): Buttonを非活性にする（UIの見た目完成次第実装）
            }
          },
          child: const Text('次の成績を表示'),
        ),
        TextButton(
          onPressed: () {
            // TODO(me): 本当に良いか確認するダイアログ表示させる（UIの見た目完成次第実装）
            if (viewModel.canRemove()) {
              viewModel.removeAll();
            } else {
              // TODO(me): Buttonを非活性にする（UIの見た目完成次第実装）
            }
          },
          child: const Text('全ての成績を表示'),
        ),
      ],
    );
  }
}
