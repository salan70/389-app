import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../controller/common/navigator_key_controller.dart';
import '../../core/util/extension/context_extension.dart';

class DeleteNormalQuizResultButton extends ConsumerWidget {
  const DeleteNormalQuizResultButton({
    super.key,
    required this.onAcceptDelete,
  });

  /// 削除するか確認後、削除を確定させた際に行われる処理。
  ///
  /// 削除するか確認するダイアログを閉じる処理の後に実行される。
  final VoidCallback onAcceptDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'delete_normal_quiz_result_button',
      buttonType: ButtonType.alert,
      onPressed: () {
        // TODO(me): controller で書く。
        ref.read(navigatorKeyControllerProvider).showDialogWithChild(
              child: AlertDialog(
                title: const Text('確認'),
                content: const Text('本当にこの履歴を消しますか？\n一度消した履歴は元に戻せません。'),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  MyButton(
                    buttonName:
                        'cancel_button_in_delete_normal_quiz_result_dialog',
                    buttonType: ButtonType.sub,
                    onPressed: context.pop,
                    child: const Text('キャンセル'),
                  ),
                  MyButton(
                    buttonName:
                        'delete_button_in_delete_normal_quiz_result_dialog',
                    buttonType: ButtonType.alert,
                    onPressed: () async {
                      context.pop();
                      onAcceptDelete();
                    },
                    child: const Text('消す'),
                  ),
                ],
              ),
            );
      },
      child: const Text('この履歴を消す'),
    );
  }
}
