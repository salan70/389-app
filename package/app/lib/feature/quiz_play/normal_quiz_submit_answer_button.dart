import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../core/router/app_router.dart';
import 'incorrect_dialog.dart';

class NormalQuizSubmitAnswerButton extends ConsumerWidget {
  const NormalQuizSubmitAnswerButton({
    super.key,
    required this.buttonType,
    required this.enteredHitter,
  });

  final ButtonType buttonType;
  final Hitter? enteredHitter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'submit_answer_button',
      buttonType: buttonType,
      onPressed: enteredHitter == null
          ? null
          : () async {
              // interstitial 広告を作成する。
              final interstitialAdService =
                  ref.read(interstitialAdServiceProvider);
              await interstitialAdService.createAd();
              await interstitialAdService.waitResult();

              final hitterQuizNotifier = ref.read(
                hitterQuizNotifierProvider(QuizType.normal, questionedAt: null)
                    .notifier,
              );
              final isCorrect = hitterQuizNotifier.isCorrectHitterQuiz();

              // * 正解の場合。
              if (isCorrect) {
                hitterQuizNotifier.markCorrect();
                await ref
                    .read(quizResultServiceProvider)
                    .createNormalQuizResult();

                // `createNormalQuizResult()` でエラーが発生しなかった場合のみ、
                // 画面遷移する。
                if (context.mounted) {
                  await context.pushRoute(NormalQuizResultRoute());
                }
                return;
              }

              // * 不正解の場合。
              hitterQuizNotifier.addIncorrectCount();

              // 広告を確率で表示する。
              await interstitialAdService.randomShowAd();

              if (context.mounted) {
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return IncorrectDialog.normal(
                      hitterName: enteredHitter!.label,
                    );
                  },
                );
              }
            },
      child: const Text('回答する'),
    );
  }
}
