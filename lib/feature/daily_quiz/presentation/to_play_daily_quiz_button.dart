import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/confirm_dialog.dart';
import '../../../common_widget/error_dialog.dart';
import '../../../common_widget/my_button.dart';
import '../../../util/constant/hitting_stats_constant.dart';
import '../../../util/logger.dart';
import '../../../util/mixin/presentation_mixin.dart';
import '../../loading/application/loading_notifier.dart';
import '../../push_notification/application/local_push_notification_service.dart';
import '../../quiz/application/hitter_quiz_notifier.dart';
import '../../quiz/presentation/play_quiz/play_daily_quiz/play_daily_quiz_page.dart';
import '../../quiz_result/application/quiz_result_service.dart';
import '../application/daily_quiz_state.dart';
import '../util/daily_quiz_constant.dart';

class ToPlayDailyQuizButton extends ConsumerWidget with PresentationMixin {
  const ToPlayDailyQuizButton({super.key, required this.buttonType});

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'to_play_daily_quiz_button',
      buttonType: buttonType,
      onPressed: () async {
        // TODO(me): ローディング, エラーに関する処理もう少しきれいに書きたい。
        final loadingNotifier = ref.read(loadingNotifierProvider.notifier)
          ..show();
        try {
          final isPlayedDailyQuiz =
              await ref.read(isPlayedDailyQuizProvider.future);

          // * プレイ済みの場合
          if (isPlayedDailyQuiz) {
            loadingNotifier.hide();
            if (context.mounted) {
              await showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return const _AlertAlreadyPlayedDailyQuizDialog();
                },
              );
            }
            return;
          }
          // * 未プレイの場合
          // 念のため、 invalidate する。
          ref.invalidate(dailyQuizProvider);
          final dailyQuiz = await ref.read(dailyQuizProvider.future);

          // * 今日の1問が null （未登録などで取得できなかった）の場合。
          if (dailyQuiz == null) {
            logger.e('今日の1問が null でした。登録漏れの可能性があります。');
            loadingNotifier.hide();
            if (context.mounted) {
              await showDialog<void>(
                context: context,
                builder: (context) => const _AlertNotFoundDailyQuizDialog(),
              );
            }
            return;
          }

          // * 今日の1問がプレイできる場合。
          loadingNotifier.hide();
          if (context.mounted) {
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return const _ConfirmPlayDailyQuizDialog();
              },
            );
          }
        }
        // * エラーが発生した場合。
        on Exception catch (e, s) {
          logger.e(
            '[to_play_daily_quiz_button]タップ時にエラーが発生しました。',
            e,
            s,
          );
          loadingNotifier.hide();
          if (context.mounted) {
            await showDialog<void>(
              context: context,
              builder: (context) => const ErrorDialog(),
            );
          }
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

/// 本日分のクイズがプレイ済みの旨を表示するダイアログ。
class _AlertAlreadyPlayedDailyQuizDialog extends StatelessWidget {
  const _AlertAlreadyPlayedDailyQuizDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'エラー',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content:
          const Text('本日分はプレイ済みです。\n\n※毎日$borderHourForTodayInApp時に更新されます。'),
      actions: [
        MyButton(
          buttonName: 'ok_button_in_already_played_daily_quiz_dialog',
          buttonType: ButtonType.main,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

/// 今日の1問が null （未登録などで取得できなかった）の旨を表示するダイアログ。
class _AlertNotFoundDailyQuizDialog extends StatelessWidget {
  const _AlertNotFoundDailyQuizDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'エラー',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: const Text('申し訳ありません。\n今日の1問はお休みです。'),
      actions: [
        MyButton(
          buttonName: 'ok_button_in_'
              'not_found_daily_quiz_dialog',
          buttonType: ButtonType.main,
          onPressed: Navigator.of(context).pop,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

/// 今日の1問がプレイできる場合、プレイするか確認するダイアログ。
class _ConfirmPlayDailyQuizDialog extends ConsumerWidget
    with PresentationMixin {
  const _ConfirmPlayDailyQuizDialog();

  static const _playDailyQuizConfirmText = '「今日の1問」を開始しますか？'
      '\n\n※1日1度しかプレイできません。'
      '\n※毎日$borderHourForTodayInApp時更新。'
      '\n\n※プレイ中にアプリが終了された場合、不正解となります。';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConfirmDialog(
      confirmText: _playDailyQuizConfirmText,
      onPressedYes: () async {
        await executeWithOverlayLoading(
          ref,
          action: () async {
            // クイズを作成する。
            await ref.read(hitterQuizNotifierProvider(QuizType.daily).future);

            // users > dailyQuizResultを保存（新規作成）
            await ref.read(quizResultServiceProvider).createDailyQuizResult();

            // ローカルプッシュ通知のスケジュールを更新し、
            // プレイ済みなのにリマインドが通知されるのを防ぐ。
            await ref
                .read(localPushNotificationServiceProvider)
                .scheduleRemindDailyQuizNotification();
          },
          onLoadingComplete: () {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => PlayDailyQuizPage(),
                settings: const RouteSettings(
                  name: '/play_daily_quiz_page',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
