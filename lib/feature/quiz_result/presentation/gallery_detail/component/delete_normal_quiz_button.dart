import 'package:baseball_quiz_app/feature/quiz_result/application/quiz_result_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';
import '../../../../../util/logger.dart';
import '../../../application/quiz_result_state.dart';

class DeleteNormalQuizResultButton extends ConsumerWidget {
  const DeleteNormalQuizResultButton({
    super.key,
    required this.onDeleteComplete,
  });

  /// 削除が完了した時に呼ばれる処理。
  ///
  /// 画面の pop を想定している。
  final VoidCallback onDeleteComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizResult = ref.watch(quizResultStateProvider);
    return quizResult == null
        ? const SizedBox.shrink()
        : MyButton(
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

                          final async =
                              ref.read(quizResultFunctionStateProvider);
                          if (async.hasError) {
                            logger.e('ノーマルクイズの履歴削除時にでエラーが発生しました。');
                            return;
                          }
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
