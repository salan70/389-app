import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/hitter_quiz_ui_state.dart';
import '../../play_quiz/play_quiz_page.dart';
import '../../prepare_quiz/prepare_quiz_page.dart';
import '../../top/top_page.dart';

class NavigationButtonsWidget extends ConsumerWidget {
  const NavigationButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const TopPage(),
              ),
            );
          },
          child: const Text('TOPへ戻る'),
        ),
        TextButton(
          onPressed: () async {
            // 「Do not use BuildContexts across async gaps.」
            // というLintの警告を回避するためにnavigatorを切り出し
            // 上記警告は、contextに対してawaitすると発生すると思われる
            final navigator = Navigator.of(context);

            // 出題する選手を取得
            // TODO(me): QuizWidgetが更新されないようにしたい
            // 現状だとエラーダイアログを閉じるとバグる
            // notifier.refresh()時に、widgetの再描画がされないようにすれば
            // バグらなくて済みそう
            final hitterQuizUiService = ref.read(hitterQuizUiServiceProvider);
            await hitterQuizUiService.fetchHitterQuizUi();

            await navigator.push(
              MaterialPageRoute<Widget>(
                builder: (_) => const PlayQuizPage(),
              ),
            );
          },
          child: const Text('同じ条件でもう一度プレイ'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const PrepareQuizPage(),
              ),
            );
          },
          child: const Text('条件を再設定'),
        ),
      ],
    );
  }
}
