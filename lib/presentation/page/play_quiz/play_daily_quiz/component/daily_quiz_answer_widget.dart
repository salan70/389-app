import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../application/admob/interstitial_ad_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../../../../application/user/user_service.dart';
import '../../../../../application/widget/widget_state.dart';
import '../../../../../util/constant/text_in_app.dart';
import '../../../../component/confirm_dialog.dart';
import '../../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../../component/answer_widget.dart';
import '../../component/incorrect_dialog.dart';

class DailyQuizAnswerWidget extends ConsumerWidget {
  const DailyQuizAnswerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxCanIncorrectCount = 2;

    final hitterQuizService = ref.watch(hitterQuizServiceProvider);
    final isCorrectNotifier = ref.watch(isCorrectQuizStateProvider.notifier);

    Future<void> submitAnswer({required bool isFinalAnswer}) async {
      final navigator = Navigator.of(context);
      const dailyQuizResultPage = DailyQuizResultPage();

      // interstitial広告を作成
      final interstitialAdService = ref.read(interstitialAdServiceProvider);
      await interstitialAdService.createAd();
      await interstitialAdService.waitResult();

      isCorrectNotifier.state = hitterQuizService.isCorrectHitterQuiz();

      final userService = ref.read(userServiceProvider);

      // 正解の場合
      if (isCorrectNotifier.state) {
        await userService.updateDailyQuizResult();
        await navigator.push(
          MaterialPageRoute<Widget>(builder: (_) => dailyQuizResultPage),
        );
        return;
      }
      // 不正解の場合
      hitterQuizService.addIncorrectCount();

      // interstitial広告を確率で表示
      await interstitialAdService.randomShowAd();

      // 最後の回答の場合
      if (isFinalAnswer) {
        await userService.updateDailyQuizResult();
        await navigator.push(
          MaterialPageRoute<Widget>(builder: (_) => dailyQuizResultPage),
        );
        return;
      }

      // 最後の回答でない場合
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return IncorrectDialog(
            selectedHitter: ref.read(answerTextFieldProvider).text,
            retireConfirmText: dailyQuizRetireConfirmText,
            resultPage: dailyQuizResultPage,
          );
        },
      );
    }

    return AnswerWidget(
      onSubmittedAnswer: () async {
        // 間違えれる回数が上限に達している（最後の回答を送信している）場合、
        // 確認ダイアログを表示する
        final isFinalAnswer =
            hitterQuizService.isFinalAnswer(maxCanIncorrectCount);

        if (isFinalAnswer) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return ConfirmDialog(
                confirmText: 'これが最後のチャンスです。\n本当にその回答でよろしいですか？',
                onPressedYes: () async {
                  await submitAnswer(isFinalAnswer: true);
                },
              );
            },
          );
          return;
        }

        await submitAnswer(isFinalAnswer: false);
      },
    );
  }
}
