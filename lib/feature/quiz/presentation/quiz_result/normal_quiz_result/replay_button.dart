import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../../util/mixin/presentation_mixin.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../play_quiz/play_normal_quiz/play_normal_quiz_page.dart';

class ReplayButton extends ConsumerWidget with PresentationMixin {
  const ReplayButton({
    super.key,
    required this.buttonType,
  });

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'replay_button',
      buttonType: buttonType,
      onPressed: () async {
        await executeWithOverlayLoading(
          ref,
          action: () async {
            ref.invalidate(hitterQuizNotifierProvider(QuizType.normal));
            // ラグを回避するため、作成が完了するまで待つ。
            await ref.read(hitterQuizNotifierProvider(QuizType.normal).future);
          },
          onLoadingComplete: () {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => const PlayNormalQuizPage(),
                settings: const RouteSettings(
                  name: '/play_normal_quiz_page',
                ),
              ),
            );
          },
        );
      },
      child: const Text('同じ条件でもう一度！'),
    );
  }
}
