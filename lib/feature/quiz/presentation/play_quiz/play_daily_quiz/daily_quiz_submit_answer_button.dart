import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/confirm_dialog.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../admob/application/interstitial_ad_service.dart';
import '../../../../quiz_result/application/quiz_result_service.dart';
import '../../../application/answer_state.dart';
import '../../../application/hitter_quiz_service.dart';
import '../../quiz_result/daily_quiz_result/daily_quiz_result_page.dart';
import '../component/incorrect_dialog.dart';

class DailyQuizSubmitAnswerButton extends ConsumerWidget {
  const DailyQuizSubmitAnswerButton({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxCanIncorrectCount = 2;

    final submittedHitter = ref.watch(submittedHitterProvider);
    final hitterQuizService = ref.watch(hitterQuizServiceProvider);

    /// クイズ終了（最終回答）時の処理
    /// dailyQuizResultを更新し、結果ページに遷移する
    Future<void> finishQuiz() async {
      // submittedHitterProviderを明示的にdisposeする
      ref.invalidate(submittedHitterProvider);
      await ref.read(quizResultServiceProvider).updateDailyQuizResult();

      if (context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (_) => const DailyQuizResultPage(),
          ),
        );
      }
    }

    Future<void> submitAnswer({required bool isFinalAnswer}) async {
      // interstitial広告を作成
      final interstitialAdService = ref.read(interstitialAdServiceProvider);
      await interstitialAdService.createAd();
      await interstitialAdService.waitResult();

      final isCorrect = hitterQuizService.isCorrectHitterQuiz();

      // 正解の場合
      if (isCorrect) {
        hitterQuizService.markCorrect();
        await finishQuiz();
        return;
      }
      // 不正解の場合
      hitterQuizService.addIncorrectCount();

      // interstitial広告を確率で表示
      await interstitialAdService.randomShowAd();

      // 最後の回答の場合
      if (isFinalAnswer) {
        await finishQuiz();
        return;
      }

      if (context.mounted) {
        // 最後の回答でない場合
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return const IncorrectDialog();
          },
        );
      }
    }

    return MyButton(
      isMain: isMain,
      onPressed: submittedHitter == null
          ? null
          : () async {
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
      child: const Text('回答する'),
    );
  }
}
