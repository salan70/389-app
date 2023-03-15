import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/hitter_quiz_service.dart';
import '../../play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ReplayButton extends ConsumerWidget {
  const ReplayButton({
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

        await ref
            .read(hitterQuizServiceProvider)
            .fetchHitterQuizBySearchCondition();

        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => const PlayNormalQuizPage(),
          ),
        );
      },
      child: const Text('同じ条件でもう一度プレイ'),
    );
  }
}
