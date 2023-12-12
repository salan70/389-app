import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../admob/application/interstitial_ad_service.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../../../quiz_result/application/quiz_result_state.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';
import '../component/incorrect_dialog.dart';

class NormalQuizSubmitAnswerButton extends ConsumerWidget {
  const NormalQuizSubmitAnswerButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHitterQuiz = ref.watch(
      hitterQuizNotifierProvider(QuizType.normal),
    );

    return asyncHitterQuiz.maybeWhen(
      orElse: Container.new,
      data: (hitterQuiz) {
        return MyButton(
          buttonName: 'submit_answer_button',
          buttonType: buttonType,
          onPressed: hitterQuiz.enteredHitter == null
              ? null
              : () async {
                  final navigator = Navigator.of(context);

                  // interstitial 広告を作成する。
                  final interstitialAdService =
                      ref.read(interstitialAdServiceProvider);
                  await interstitialAdService.createAd();
                  await interstitialAdService.waitResult();

                  final hitterQuizNotifier = ref.read(
                    hitterQuizNotifierProvider(QuizType.normal).notifier,
                  );
                  final isCorrect = hitterQuizNotifier.isCorrectHitterQuiz();

                  // 正解の場合。
                  if (isCorrect) {
                    hitterQuizNotifier.markCorrect();
                    await ref
                        .read(quizResultServiceProvider)
                        .createNormalQuizResult();

                    // `createNormalQuizResult()` でエラーが発生しなかった場合のみ、
                    // 画面遷移する。
                    final functionState =
                        ref.read(quizResultFunctionStateProvider);
                    if (!functionState.hasError) {
                      await navigator.push(
                        MaterialPageRoute<Widget>(
                          builder: (_) => const NormalQuizResultPage(),
                          settings: const RouteSettings(
                            name: '/play_normal_quiz_page',
                          ),
                        ),
                      );
                    }
                    return;
                  }
                  // 不正解の場合。
                  hitterQuizNotifier.addIncorrectCount();

                  // 広告を確率で表示する。
                  await interstitialAdService.randomShowAd();

                  if (context.mounted) {
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return IncorrectDialog.normal(
                          hitterName: hitterQuiz.enteredHitter!.label,
                        );
                      },
                    );
                  }
                },
          child: const Text('回答する'),
        );
      },
    );
  }
}
