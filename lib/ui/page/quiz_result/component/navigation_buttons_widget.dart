import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../../state/hitter_quiz_ui_state.dart';
import '../../play_quiz/play_quiz_page.dart';
import '../../prepare_quiz/prepare_quiz_page.dart';

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
                builder: (_) => const MyApp(),
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

            // 出題する選手をリセット
            final notifier = ref.watch(hitterQuizUiNotifierProvider.notifier);
            await notifier.refresh();
            // TODO(me): Loading中の処理を書く

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
