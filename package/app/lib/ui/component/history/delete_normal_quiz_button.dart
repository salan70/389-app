import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/button/my_button.dart';
import '../common/dialog/confirm_dialog.dart';

class DeleteNormalQuizResultButton extends ConsumerWidget {
  const DeleteNormalQuizResultButton({
    super.key,
    required this.onTap,
  });

  /// 削除するか確認後、削除を確定させた際に行われる処理。
  ///
  /// 削除するか確認するダイアログを閉じる処理の後に実行される。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'delete_normal_quiz_result_button',
      buttonType: ButtonType.alert,
      onPressed: onTap,
      child: const Text('この履歴を消す'),
    );
  }
}

class ConfirmDeleteHistoryDialog extends StatelessWidget {
  const ConfirmDeleteHistoryDialog({
    super.key,
    required this.onAcceptDelete,
  });

  final VoidCallback onAcceptDelete;

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      confirmText: '本当にこの履歴を消しますか？\n一度消した履歴は元に戻せません。',
      onPressedYes: onAcceptDelete,
    );
  }
}
