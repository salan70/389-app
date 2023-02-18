import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ToPlayNormalQuizFromTopButton extends ConsumerWidget {
  const ToPlayNormalQuizFromTopButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        // 「Do not use BuildContexts across async gaps.」
        // というLintの警告を回避するためにnavigatorを切り出し
        // 上記警告は、contextに対してawaitすると発生すると思われる
        final navigator = Navigator.of(context);

        // 出題する選手を取得
        await ref
            .read(hitterQuizServiceProvider)
            .fetchHitterQuizBySearchCondition();

        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => const PlayNormalQuizPage(),
          ),
        );
      },
      child: FittedBox(
        child: Text(
          '保存されている条件でプレイ！',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
