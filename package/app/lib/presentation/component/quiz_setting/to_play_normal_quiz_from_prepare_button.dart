import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../page/play_normal_quiz_page.dart';
import '../../util/presentation_mixin.dart';
import '../common/button/my_button.dart';

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
            await ref.read(
              hitterQuizNotifierProvider(QuizType.normal, questionedAt: null)
                  .future,
            );

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
