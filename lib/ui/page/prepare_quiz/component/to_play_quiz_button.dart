import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/hitter_search_condition_repository.dart';
import '../../../../state/hitter_quiz_ui_service.dart';
import '../../../../state/hitter_search_condition_state.dart';
import '../../play_quiz/play_quiz_page.dart';

class ToPlayQuizButton extends ConsumerWidget {
  const ToPlayQuizButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterSearchCondition = ref.watch(hitterSearchConditionProvider);
    final hitterSearchConditionRepository =
        ref.watch(hitterSearchConditionRepositoryProvider);

    return Center(
      child: SizedBox(
        width: 120,
        child: TextButton(
          onPressed: () async {
            // hitterSearchConditionをローカルDBへ保存
            hitterSearchConditionRepository
                .saveHitterSearchCondition(hitterSearchCondition);

            // 「Do not use BuildContexts across async gaps.」
            // というLintの警告を回避するためにnavigatorを切り出し
            // 上記警告は、contextに対してawaitすると発生すると思われる
            final navigator = Navigator.of(context);

            // 出題する選手を取得
            await ref.read(hitterQuizUiServiceProvider).fetchHitterQuizUi();

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