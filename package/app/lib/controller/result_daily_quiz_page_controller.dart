import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/util/extension/global_key_extension.dart';

part 'result_daily_quiz_page_controller.g.dart';

@riverpod
ResultDailyQuizPageController resultDailyQuizPageController(
  ResultDailyQuizPageControllerRef ref,
) =>
    ResultDailyQuizPageController(ref);

class ResultDailyQuizPageController {
  ResultDailyQuizPageController(this._ref);

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
}
