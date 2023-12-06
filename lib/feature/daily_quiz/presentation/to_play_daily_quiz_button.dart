import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/confirm_dialog.dart';
import '../../../common_widget/my_button.dart';
import '../../push_notification_local/application/local_push_notification_service.dart';
import '../../quiz/application/hitter_quiz_service.dart';
import '../../quiz/presentation/play_quiz/play_daily_quiz/play_daily_quiz_page.dart';
import '../../quiz_result/application/quiz_result_service.dart';
import '../application/daily_quiz_service.dart';
import '../application/daily_quiz_state.dart';
import '../util/daily_quiz_constant.dart';

class ToPlayDailyQuizButton extends ConsumerWidget {
  const ToPlayDailyQuizButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const playDailyQuizConfirmText = '「今日の1問」を開始しますか？'
        '\n\n※1日1度しかプレイできません。'
        '\n※毎日$borderHourForTodayInApp時更新。'
        '\n\n※プレイ中にアプリが終了された場合、不正解となります。';

    return MyButton(
      buttonName: 'to_play_daily_quiz_button',
      buttonType: buttonType,
      onPressed: () async {
        final dailyQuizService = ref.read(dailyQuizServiceProvider);
        await dailyQuizService.fetchDailyQuiz();
        // 値を取得してからdailyQuizStateProviderをreadする
        final dailyQuiz = ref.read(dailyQuizStateProvider);
        final canPlay = await dailyQuizService.canPlayDailyQuiz();

        if (canPlay) {
          // プレイできる場合
          if (context.mounted) {
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
                            .read(quizResultServiceProvider)
                            .createDailyQuizResult();

                        // ローカルプッシュ通知のスケジュールを更新し、
                        // プレイ済みなのにリマインドが通知されるのを防ぐ。
                        await ref
                            .read(localPushNotificationServiceProvider)
                            .scheduleRemindDailyQuizNotification(
                              isDoneTodaysDailyQuiz: true,
                            );

                        await navigator.push(
                          MaterialPageRoute<Widget>(
                            builder: (_) => const PlayDailyQuizPage(),
                            settings: const RouteSettings(
                              name: '/play_daily_quiz_page',
                            ),
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
        }

        // プレイできない場合
        if (context.mounted) {
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
                  MyButton(
                    buttonName: 'ok_button_in_already_played_daily_quiz_dialog',
                    buttonType: ButtonType.main,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: FittedBox(
        child: Text(
          '今日の1問',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
          ),
        ),
      ),
    );
  }
}
