import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/extension/global_key_extension.dart';
import '../component/history/show_answer_button.dart';
import 'common/navigator_key_controller.dart';

part 'quiz_history_daily_page_controller.g.dart';

@riverpod
QuizHistoryDailyPageController quizHistoryDailyPageController(
  QuizHistoryDailyPageControllerRef ref,
) =>
    QuizHistoryDailyPageController(ref);

class QuizHistoryDailyPageController {
  QuizHistoryDailyPageController(this._ref);

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

  /// 正解を表示する。
  void onTapShowAnswer(String hitterName) {
    _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          barrierDismissible: false,
          child: AlertAnswerDialog(hitterName: hitterName),
        );
  }
}
