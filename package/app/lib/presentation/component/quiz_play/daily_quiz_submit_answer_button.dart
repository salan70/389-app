import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../page/daily_quiz_result_page.dart';
import '../common/button/my_button.dart';
import '../common/dialog/confirm_dialog.dart';
import 'incorrect_dialog.dart';

class DailyQuizSubmitAnswerButton extends ConsumerWidget {
  const DailyQuizSubmitAnswerButton({
    super.key,
    required this.buttonType,
    required this.hitterQuiz,
    required this.questionedAt,
  });

  final ButtonType buttonType;
  final HitterQuiz hitterQuiz;
  final DateTime questionedAt;

  static const _maxCanIncorrectCount = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(
      hitterQuizNotifierProvider(
        QuizType.daily,
        questionedAt: questionedAt,
      ).notifier,
    );

    /// クイズ終了（最終回答）時の処理。
    ///
    /// dailyQuizResult を更新し、結果ページに遷移する。
    Future<void> finishQuiz() async {
      await ref
          .read(quizResultServiceProvider)
          .updateDailyQuizResult(questionedAt);

      if (context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (_) => DailyQuizResultPage(
              questionedAt: questionedAt,
            ),
            settings: const RouteSettings(
              name: '/daily_quiz__resultpage',
            ),
          ),
        );
      }
    }

    Future<void> submitAnswer({
      required bool isFinalAnswer,
      required String hitterName,
    }) async {
      // interstitial広告を作成
      final interstitialAdService = ref.read(interstitialAdServiceProvider);
      await interstitialAdService.createAd();
      await interstitialAdService.waitResult();

      final isCorrect = notifier.isCorrectHitterQuiz();

      // 正解の場合
      if (isCorrect) {
        notifier.markCorrect();
        await finishQuiz();
        return;
      }
      // 不正解の場合
      notifier.addIncorrectCount();

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
            return IncorrectDialog.daily(
              hitterName: hitterName,
              questionedAt: questionedAt,
            );
          },
        );
      }
    }

    return MyButton(
      buttonName: 'submit_answer_button',
      buttonType: buttonType,
      onPressed: hitterQuiz.enteredHitter == null
          ? null
          : () async {
              // 間違えれる回数が上限に達している（最後の回答を送信している）場合、
              // 確認ダイアログを表示する
              final isFinalAnswer =
                  notifier.isFinalAnswer(_maxCanIncorrectCount);

              if (isFinalAnswer) {
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return ConfirmDialog(
                      confirmText: 'これが最後のチャンスです。\n本当にその回答でよろしいですか？',
                      onPressedYes: () async {
                        await submitAnswer(
                          isFinalAnswer: true,
                          hitterName: hitterQuiz.enteredHitter!.label,
                        );
                      },
                    );
                  },
                );
                return;
              }

              await submitAnswer(
                isFinalAnswer: false,
                hitterName: hitterQuiz.enteredHitter!.label,
              );
            },
      child: const Text('回答する'),
    );
  }
}
