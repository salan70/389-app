import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_quiz_ui_state.dart';

class QuizEventButtonsWidget extends ConsumerWidget {
  const QuizEventButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterQuizUiService = ref.watch(hitterQuizUiServiceProvider);

    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (hitterQuizUiService.canOpen()) {
              hitterQuizUiService.openRandom();
            } else {
              // TODO(me): Buttonを非活性にする（UIの見た目完成次第実装）
            }
          },
          child: const Text('次の成績を表示'),
        ),
        TextButton(
          onPressed: () {
            // TODO(me): 本当に良いか確認するダイアログ表示させる（UIの見た目完成次第実装）
            if (hitterQuizUiService.canOpen()) {
              hitterQuizUiService.openAll();
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
