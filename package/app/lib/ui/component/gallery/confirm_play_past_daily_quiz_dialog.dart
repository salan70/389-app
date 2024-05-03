import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/util/extension/context_extension.dart';
import '../common/button/my_button.dart';

class ConfirmPlayPastDailyQuizDialog extends ConsumerStatefulWidget {
  const ConfirmPlayPastDailyQuizDialog({
    super.key,
    required this.date,
    required this.onPressed,
  });

  final DateTime date;
  final VoidCallback onPressed;

  @override
  ConsumerState<ConfirmPlayPastDailyQuizDialog> createState() =>
      _ConfirmPlayPastDailyQuizDialog();
}

class _ConfirmPlayPastDailyQuizDialog
    extends ConsumerState<ConfirmPlayPastDailyQuizDialog> {
  static const double _buttonHeight = 24;
  static const double _buttonWidth = 64;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(rewardedAdNotifierProvider.notifier).loadAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rewardedAdState = ref.watch(rewardedAdNotifierProvider);
    final formattedDate = widget.date.toFormattedString();

    return AlertDialog(
      title: const Text('確認'),
      content: Text('動画広告を見て、$formattedDateの「今日の1問」をプレイしますか？\n'
          'はいをタップすると、動画広告が再生されます。\n\n'
          '※1度プレイした日付の「今日の1問」は、2度とプレイできません。\n\n'
          '※プレイ中にアプリが終了された場合、不正解となります。'),
      actionsPadding: const EdgeInsets.only(right: 24, bottom: 16),
      actions: <Widget>[
        MyButton(
          buttonName: 'confirm_no_button',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const SizedBox(
            height: _buttonHeight,
            width: _buttonWidth,
            child: Center(child: Text('いいえ')),
          ),
        ),
        const SizedBox(width: 4),
        MyButton(
          buttonName: 'confirm_yes_button',
          buttonType: ButtonType.alert,
          onPressed: widget.onPressed,
          child: SizedBox(
            height: _buttonHeight,
            width: _buttonWidth,
            child: Center(
              child: rewardedAdState.isLoaded
                  ? const Text('はい')
                  : const SizedBox(
                      // 正方形で表示させるため、 _buttonHeight を width に設定。
                      width: _buttonHeight,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
