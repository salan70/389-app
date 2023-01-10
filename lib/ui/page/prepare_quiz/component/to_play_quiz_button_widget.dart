import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/hitter_search_condition_repository.dart';
import '../../../../state/hitter_search_condition_state.dart';
import '../../play_quiz/play_quiz_page.dart';

class ToPlayQuizButtonWidget extends ConsumerWidget {
  const ToPlayQuizButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hitterSearchCondition = ref.watch(hitterSearchConditionProvider);
    final hitterSearchConditionRepository =
        ref.watch(hitterSearchConditionRepositoryProvider);

    return TextButton(
      onPressed: () {
        // hitterSearchConditionをローカルDBへ保存
        hitterSearchConditionRepository
            .saveHitterSearchCondition(hitterSearchCondition);

        // 画面遷移
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => const PlayQuizPage(),
          ),
        );
      },
      child: const Text('クイズへ'),
    );
  }
}
