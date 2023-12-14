import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../../util/mixin/presentation_mixin.dart';
import '../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../quiz/presentation/play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ToPlayNormalQuizFromTopButton extends ConsumerWidget
    with PresentationMixin {
  const ToPlayNormalQuizFromTopButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_play_normal_quiz_from_top_button',
      buttonType: buttonType,
      onPressed: () async {
        await executeWithOverlayLoading(
          ref,
          action: () async {
            ref.invalidate(
              hitterQuizNotifierProvider(
                QuizType.normal,
                questionedAt: null,
              ),
            );
            // ラグを回避するため、作成が完了するまで待つ。
            await ref.read(
              hitterQuizNotifierProvider(QuizType.normal, questionedAt: null)
                  .future,
            );
          },
          onLoadingComplete: () {
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (_) => PlayNormalQuizPage(),
                  settings: const RouteSettings(
                    name: '/play_normal_quiz_page',
                  ),
                ),
              );
            }
          },
        );
      },
      child: FittedBox(
        child: Text(
          'クイズをプレイ！',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
    );
  }
}
