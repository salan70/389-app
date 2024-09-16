import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../common/dialog/confirm_dialog.dart';
import '../common/sized_circular_indicator.dart';

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
  // TODO(me): この 24 という値は、目視でなんとなく決めたものであるため、適切な値を設定する。
  // あるいは、適切な設定方法を用いる。
  static const double _buttonHeight = 24;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // TODO(me): この処理、 controller に移動したい。
        // 一度試みたが、このダイアログ内で ref.watch  が思うように状態を監視してくれなかった。
        await ref.read(rewardedAdNotifierProvider.notifier).loadAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rewardedAdState = ref.watch(rewardedAdNotifierProvider);
    final formattedDate = widget.date.toFormattedString();

    return ConfirmDialog(
      confirmText: '動画広告を見て、$formattedDateの「今日の1問」をプレイしますか？\n'
          'はいをタップすると、動画広告が再生されます。\n\n'
          '※1度プレイした日付の「今日の1問」は、2度とプレイできません。\n\n'
          '※プレイ中にアプリが終了された場合、不正解となります。',
      onAccept: widget.onPressed,
      acceptWidget: rewardedAdState.stateType == RewardAdStateType.loaded
          ? const Text('はい')
          : const SizedCircularIndicator(size: _buttonHeight),
    );
  }
}
