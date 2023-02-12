import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/hitter_quiz/hitter_quiz_service.dart';
import '../../../../application/hitter_search_condition/hitter_search_condition_state.dart';
import '../../../../domain/repository/hitter_search_condition_repository.dart';
import '../../play_quiz/play_quiz_page.dart';

class ToPlayQuizFromPrepareButton extends ConsumerWidget {
  const ToPlayQuizFromPrepareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 120,
        child: TextButton(
          onPressed: () async {
            // hitterSearchConditionをローカルDBへ保存
            final hitterSearchCondition = ref.read(
              hitterSearchConditionProvider,
            );
            ref
                .read(hitterSearchConditionRepositoryProvider)
                .saveHitterSearchCondition(hitterSearchCondition);

            // 「Do not use BuildContexts across async gaps.」
            // というLintの警告を回避するためにnavigatorを切り出し
            // 上記警告は、contextに対してawaitすると発生すると思われる
            final navigator = Navigator.of(context);

            // 出題する選手を取得
            await ref.read(hitterQuizServiceProvider).fetchHitterQuiz();

            // 画面遷移
            await navigator.push(
              MaterialPageRoute<Widget>(
                builder: (_) => const PlayQuizPage(),
              ),
            );
          },
          child: const Text('クイズへ'),
        ),
      ),
    );
  }
}
