import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../play_quiz_view_model.dart';

class QuizEventButtons extends ConsumerWidget {
  const QuizEventButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(playQuizViewModelProvider);
    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (viewModel.canAddId()) {
              viewModel.addId();
            } else {
              // TODO Buttonを非活性にする（UIの見た目完成次第実装）
            }
          },
          child: const Text('次の成績を表示'),
        ),
        TextButton(
          onPressed: () {
            // TODO 本当に良いか確認するダイアログ表示させる（UIの見た目完成次第実装）
            if (viewModel.canAddId()) {
              viewModel.addAllId();
            } else {
              // TODO Buttonを非活性にする（UIの見た目完成次第実装）
            }
          },
          child: const Text('全ての成績を表示'),
        ),
      ],
    );
  }
}
