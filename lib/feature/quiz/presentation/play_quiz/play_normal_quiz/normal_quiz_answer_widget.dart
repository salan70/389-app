import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admob/application/interstitial_ad_service.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../../../quiz_result/application/quiz_result_state.dart';
import '../../../application/answer_state.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../quiz_result/normal_quiz_result/normal_quiz_result_page.dart';
import '../component/answer_widget.dart';
import '../component/incorrect_dialog.dart';

class NormalQuizAnswerWidget extends ConsumerWidget {
  const NormalQuizAnswerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnswerWidget(
      onSubmittedAnswer: () async {
        final navigator = Navigator.of(context);
        const normalQuizResultPage = NormalQuizResultPage();

        // interstitial広告を作成
        final interstitialAdService = ref.read(interstitialAdServiceProvider);
        await interstitialAdService.createAd();
        await interstitialAdService.waitResult();

        final hitterQuizService = ref.read(hitterQuizServiceProvider);
        final isCorrect = hitterQuizService.isCorrectHitterQuiz();

        // 正解の場合
        if (isCorrect) {
          // submittedHitterProviderを明示的にdisposeする
          ref.invalidate(submittedHitterProvider);

          hitterQuizService.markCorrect();
          await ref.read(quizResultServiceProvider).createNormalQuizResult();

          // createNormalQuizResult()でエラーが発生しなかった場合のみ、画面遷移する
          final functionState = ref.read(quizResultFunctionStateProvider);
          if (!functionState.hasError) {
            await navigator.push(
              MaterialPageRoute<Widget>(builder: (_) => normalQuizResultPage),
            );
          }
          return;
        }
        // 不正解の場合
        hitterQuizService.addIncorrectCount();

        // interstitial広告を確率で表示
        await interstitialAdService.randomShowAd();

        if (context.mounted) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return const IncorrectDialog();
            },
          );
        }
      },
    );
  }
}
