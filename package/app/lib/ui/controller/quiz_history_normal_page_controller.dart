import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/extension/global_key_extension.dart';

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

  /// クイズ履歴を削除し、前の画面に戻る。
  Future<void> deleteQuizHistory(HitterQuizResult quizResult) async {
    await _ref
        .read(quizResultServiceProvider)
        .deleteNormalQuizResult(quizResult.docId);
    await _ref.read(appRouterProvider).pop();
  }
}
