import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/quiz/daily_quiz/daily_quiz_service.dart';
import '../../../../application/quiz/daily_quiz/daily_quiz_state.dart';
import '../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../application/user/user_service.dart';
import '../../../../util/constant/text_in_app.dart';
import '../../../component/confirm_dialog.dart';
import '../../play_quiz/play_daily_quiz/play_daily_quiz_page.dart';

class ToPlayDailyQuizFromTopButton extends ConsumerWidget {
  const ToPlayDailyQuizFromTopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const playDailyQuizConfirmText = '「今日の1問」を開始しますか？'
        '\n\n※1日1度しかプレイできません。'
        '\n※毎日$borderHourForTodayInApp時更新。'
        '\n\n※プレイ中にアプリが終了された場合、不正解となります。';

    return TextButton(
      onPressed: () async {
        await ref.read(dailyQuizServiceProvider).fetchDailyQuiz();
        // 値を取得してからdailyQuizStateProviderをreadする
        final dailyQuiz = ref.read(dailyQuizStateProvider);
        final canPlay = await ref.read(userServiceProvider).canPlayDailyQuiz();

        if (canPlay) {
          // プレイできる場合
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return ConfirmDialog(
                confirmText: playDailyQuizConfirmText,
                onPressedYes: () async {
                  dailyQuiz.maybeWhen(
                    orElse: Container.new,
                    data: (data) async {
                      final navigator = Navigator.of(context);

                      // クイズを作成
                      await ref
                          .read(hitterQuizServiceProvider)
                          .fetchHitterQuizById(data!);

                      // users > dailyQuizResultを保存（新規作成）
                      await ref
                          .read(userServiceProvider)
                          .createDailyQuizResult(data.dailyQuizId);

                      await navigator.push(
                        MaterialPageRoute<Widget>(
                          builder: (_) => const PlayDailyQuizPage(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
          return;
        }

        // プレイできない場合
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'エラー',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              content: const Text('本日分はプレイ済みです。\n\n※毎日19時に更新されます。'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: FittedBox(
        child: Text('今日の1問', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
