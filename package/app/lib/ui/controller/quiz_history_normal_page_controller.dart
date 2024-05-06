import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/extension/global_key_extension.dart';
import '../component/history/delete_normal_quiz_button.dart';
import '../component/history/show_answer_button.dart';
import 'common/navigator_key_controller.dart';

part 'quiz_history_normal_page_controller.g.dart';

@riverpod
QuizHistoryNormalPageController quizHistoryNormalPageController(
  QuizHistoryNormalPageControllerRef ref,
) =>
    QuizHistoryNormalPageController(ref);

class QuizHistoryNormalPageController {
  QuizHistoryNormalPageController(this._ref);

  final Ref _ref;

  /// クイズ結果をシェアする。
  Future<void> shareQuiz(GlobalKey globalKey, String shareText) async {
    // シェアする Widget を画像化し、 ByteData に変換したもの。
    final bytes = await globalKey.exportToImage();
    await _ref.read(shareQuizResultServiceProvider).shareImageAndText(
          'result_quiz_widget',
          bytes,
          shareText,
        );
  }

  Future<void> onTapDeleteHistory(HitterQuizResult quizResult) async {
    _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: ConfirmDeleteHistoryDialog(
            onAcceptDelete: () => _deleteQuizHistory(quizResult),
          ),
        );
  }

  /// クイズ履歴を削除し、前の画面に戻る。
  Future<void> _deleteQuizHistory(HitterQuizResult quizResult) async {
    await _ref
        .read(quizResultServiceProvider)
        .deleteNormalQuizResult(quizResult.docId);
    await _ref.read(appRouterProvider).maybePop();
  }

  /// 正解を表示する。
  void onTapShowAnswer(String hitterName) {
    _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          barrierDismissible: false,
          child: AlertAnswerDialog(hitterName: hitterName),
        );
  }
}
