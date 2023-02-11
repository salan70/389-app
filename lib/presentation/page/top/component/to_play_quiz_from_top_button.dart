import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/hitter_quiz/hitter_quiz_ui_service.dart';
import '../../play_quiz/play_quiz_page.dart';

class ToPlayQuizFromTopButton extends ConsumerWidget {
  const ToPlayQuizFromTopButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: FittedBox(
        child: Text(
          '保存されている条件でプレイ！',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      onPressed: () async {
        // 「Do not use BuildContexts across async gaps.」
        // というLintの警告を回避するためにnavigatorを切り出し
        // 上記警告は、contextに対してawaitすると発生すると思われる
        final navigator = Navigator.of(context);

        // 出題する選手を取得
        await ref.read(hitterQuizUiServiceProvider).fetchHitterQuizUi();

        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => const PlayQuizPage(),
          ),
        );
      },
    );
  }
}
