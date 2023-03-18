import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../quiz/application/hitter_quiz_service.dart';
import '../../../quiz/presentation/play_quiz/play_normal_quiz/play_normal_quiz_page.dart';
import '../../application/search_condition_state.dart';
import '../../domain/search_condition_repository.dart';

class ToPlayNormalQuizFromPrepareButton extends ConsumerWidget {
  const ToPlayNormalQuizFromPrepareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton(
        onPressed: () async {
          // searchConditionをローカルDBへ保存
          final searchCondition = ref.read(searchConditionProvider);
          ref
              .read(searchConditionRepositoryProvider)
              .saveSearchCondition(searchCondition);

          // 出題する選手を取得
          await ref
              .read(hitterQuizServiceProvider)
              .fetchHitterQuizBySearchCondition();

          // 画面遷移
          if (context.mounted) {
            await Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => const PlayNormalQuizPage(),
              ),
            );
          }
        },
        child: const Text('クイズへ'),
      ),
    );
  }
}
