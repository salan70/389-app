import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/util/presentation_mixin.dart';
import '../../../page/play_normal_quiz_page.dart';

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