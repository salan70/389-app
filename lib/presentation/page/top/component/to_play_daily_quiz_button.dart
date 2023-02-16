import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../play_daily_quiz/play_daily_quiz_page.dart';

class ToPlayDailyQuizFromTopButton extends ConsumerWidget {
  const ToPlayDailyQuizFromTopButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: FittedBox(
        child: Text(
          '今日の1問',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      onPressed: () async {
        // 「Do not use BuildContexts across async gaps.」
        // というLintの警告を回避するためにnavigatorを切り出し
        // 上記警告は、contextに対してawaitすると発生すると思われる
        final navigator = Navigator.of(context);

        // 出題する選手を取得
        await ref.read(hitterQuizServiceProvider).fetchHitterQuizById();

        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => const PlayDailyQuizPage(),
          ),
        );
      },
    );
  }
}
