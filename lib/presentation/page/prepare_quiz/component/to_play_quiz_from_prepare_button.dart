import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../application/quiz/search_condition/search_condition_state.dart';
import '../../../../domain/repository/search_condition_repository.dart';
import '../../play_normal_quiz/play_normal_quiz_page.dart';

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
            // searchConditionをローカルDBへ保存
            final searchCondition = ref.read(
              searchConditionProvider,
            );
            ref
                .read(searchConditionRepositoryProvider)
                .saveSearchCondition(searchCondition);

            // 「Do not use BuildContexts across async gaps.」
            // というLintの警告を回避するためにnavigatorを切り出し
            // 上記警告は、contextに対してawaitすると発生すると思われる
            final navigator = Navigator.of(context);

            // 出題する選手を取得
            await ref
                .read(hitterQuizServiceProvider)
                .fetchHitterQuizBySearchCondition();

            // 画面遷移
            await navigator.push(
              MaterialPageRoute<Widget>(
                builder: (_) => const PlayNormalQuizPage(),
              ),
            );
          },
          child: const Text('クイズへ'),
        ),
      ),
    );
  }
}
