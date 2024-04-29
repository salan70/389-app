import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../common/button/my_button.dart';

class DeleteNormalQuizResultButton extends ConsumerWidget {
  const DeleteNormalQuizResultButton({
    super.key,
    required this.quizResult,
    required this.onDeleteComplete,
  });

  final HitterQuizResult quizResult;

  /// 削除が完了した時に呼ばれる処理。
  ///
  /// 画面の pop を想定している。
  final VoidCallback onDeleteComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      buttonName: 'delete_normal_quiz_result_button',
      buttonType: ButtonType.alert,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('確認'),
              content: const Text('本当にこの履歴を消しますか？\n一度消した履歴は元に戻せません。'),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                MyButton(
                  buttonName:
                      'cancel_button_in_delete_normal_quiz_result_dialog',
                  buttonType: ButtonType.sub,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('キャンセル'),
                ),
                MyButton(
                  buttonName:
                      'delete_button_in_delete_normal_quiz_result_dialog',
                  buttonType: ButtonType.alert,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await ref
                        .read(quizResultServiceProvider)
                        .deleteNormalQuizResult(quizResult.docId);
                    onDeleteComplete();
                  },
                  child: const Text('消す'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('この履歴を消す'),
    );
  }
}
