import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../analytics/application/analytics_service.dart';
import '../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../quiz/presentation/play_quiz/play_normal_quiz/play_normal_quiz_page.dart';
import '../../application/search_condition_notifier.dart';
import '../../domain/search_condition_repository.dart';

class ToPlayNormalQuizFromPrepareButton extends ConsumerWidget {
  const ToPlayNormalQuizFromPrepareButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_play_normal_quiz_from_prepare_button',
      buttonType: buttonType,
      onPressed: () async {
        // searchConditionをローカルDBへ保存
        final searchCondition = ref.read(searchConditionNotifierProvider);

        // todo: application層に移動する。
        ref
            .read(searchConditionRepositoryProvider)
            .saveSearchCondition(searchCondition);

        // 出題する選手を取得
        await ref
            .read(hitterQuizNotifierProvider(QuizType.normal).future);

        // Analytics に search_condition を送信する。
        await ref.read(analyticsServiceProvider).logSearchCondition(
              searchCondition,
            );

        // 画面遷移
        if (context.mounted) {
          await Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => const PlayNormalQuizPage(),
              settings: const RouteSettings(
                name: '/play_normal_quiz_page',
              ),
            ),
          );
        }
      },
      child: const Text('クイズをプレイ！'),
    );
  }
}
