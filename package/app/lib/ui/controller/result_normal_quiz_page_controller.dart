import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/controller_mixin.dart';
import '../../core/util/extension/global_key_extension.dart';
import '../component/quiz_result_normal/request_review_dialog.dart';
import 'common/navigator_key_controller.dart';

part 'result_normal_quiz_page_controller.g.dart';

@riverpod
ResultNormalQuizPageController resultNormalQuizPageController(
  ResultNormalQuizPageControllerRef ref,
) =>
    ResultNormalQuizPageController(ref);

class ResultNormalQuizPageController with ControllerMixin {
  ResultNormalQuizPageController(this._ref);

  final Ref _ref;

  Future<void> onOpenPage(AsyncData<HitterQuiz> nextHitterQuiz) async {
    // 直近のクイズが不正解だった場合、何もしない。
    if (nextHitterQuiz.value.isCorrect == false) {
      return;
    }

    // レビューを要求する条件を満たしているか確認する。
    final shouldRequestAppReview =
        await _ref.read(shouldRequestReviewProvider.future);

    // レビューを要求する条件を満たしていない場合、何もしない。
    if (shouldRequestAppReview == false) {
      return;
    }

    // レビューダイアログを表示したことを記録する。
    await _ref.read(appReviewServiceProvider).updateReviewHistory();

    // レビューダイアログを表示する。
    _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: RequestReviewDialog(onAcceptReview: _onAcceptReview),
          barrierDismissible: false,
        );
  }

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

  Future<void> onTapReplay() async {
    await executeWithOverlayLoading(
      _ref,
      action: () async {
        _ref.invalidate(
          hitterQuizNotifierProvider(
            QuizType.normal,
            questionedAt: null,
          ),
        );
        // ラグを回避するため、作成が完了するまで待つ。
        await _ref.read(
          hitterQuizNotifierProvider(QuizType.normal, questionedAt: null)
              .future,
        );
      },
      onLoadingComplete: () =>
          _ref.read(appRouterProvider).push(PlayNormalQuizRoute()),
    );
  }

  Future<void> _onAcceptReview() async {
    await _ref.read(appRouterProvider).pop();
    await _ref.read(appReviewServiceProvider).requestAppReview();
  }
}
