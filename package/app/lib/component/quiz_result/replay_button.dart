import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/util/presentation_mixin.dart';
import '../../core/router/app_router.dart';

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
          onLoadingComplete: () => context.pushRoute(PlayNormalQuizRoute()),
        );
      },
      child: const Text('同じ条件でもう一度！'),
    );
  }
}
