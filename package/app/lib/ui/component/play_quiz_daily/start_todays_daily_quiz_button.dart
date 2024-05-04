import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';
import '../common/dialog/confirm_dialog.dart';

class StartTodaysDailyQuizButton extends ConsumerWidget {
  const StartTodaysDailyQuizButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
  });

  final ButtonType buttonType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'start_todays_daily_quiz_button',
      buttonType: buttonType,
      onPressed: onPressed,
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
class AlertAlreadyPlayedDailyQuizDialog extends StatelessWidget {
  const AlertAlreadyPlayedDailyQuizDialog({super.key});

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
          onPressed: context.pop,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

/// 今日の1問が null （未登録などで取得できなかった）の旨を表示するダイアログ。
class AlertNotFoundDailyQuizDialog extends StatelessWidget {
  const AlertNotFoundDailyQuizDialog({super.key});

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
          onPressed: context.pop,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

/// 今日の1問がプレイできる場合、プレイするか確認するダイアログ。
class ConfirmPlayDailyQuizDialog extends ConsumerWidget {
  const ConfirmPlayDailyQuizDialog({super.key, required this.onPressedYes});

  final VoidCallback onPressedYes;

  static const _playDailyQuizConfirmText = '「今日の1問」を開始しますか？'
      '\n\n※1日1度しかプレイできません。'
      '\n※毎日$borderHourForTodayInApp時更新。'
      '\n\n※プレイ中にアプリが終了された場合、不正解となります。';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConfirmDialog(
      confirmText: _playDailyQuizConfirmText,
      onAccept: onPressedYes,
    );
  }
}
