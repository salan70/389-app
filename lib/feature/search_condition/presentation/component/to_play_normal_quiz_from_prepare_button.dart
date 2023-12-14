import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/mixin/presentation_mixin.dart';
import '../../../analytics/application/analytics_service.dart';
import '../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../quiz/presentation/play_quiz/play_normal_quiz/play_normal_quiz_page.dart';
import '../../application/search_condition_notifier.dart';

class ToPlayNormalQuizFromPrepareButton extends ConsumerWidget
    with PresentationMixin {
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
        await executeWithOverlayLoading(
          ref,
          action: () async {
            // searchCondition を repository へ保存する。
            ref.read(searchConditionNotifierProvider.notifier).save();

            // 出題する選手を取得する。
            await ref.read(hitterQuizNotifierProvider(QuizType.normal).future);

            // Analytics に search_condition を送信する。
            await ref.read(analyticsServiceProvider).logSearchCondition();
          },
          onLoadingComplete: () {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => PlayNormalQuizPage(),
                settings: const RouteSettings(
                  name: '/play_normal_quiz_page',
                ),
              ),
            );
          },
        );
      },
      child: const Text('クイズをプレイ！'),
    );
  }
}
