import 'package:common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/controller_mixin.dart';
import '../component/gallery/confirm_play_past_daily_quiz_dialog.dart';
import 'common/navigator_key_controller.dart';

part 'gallery_list_page_controller.g.dart';

@riverpod
GalleryListPageController galleryListPageController(
  GalleryListPageControllerRef ref,
) =>
    GalleryListPageController(ref);

class GalleryListPageController with ControllerMixin {
  GalleryListPageController(this._ref);

  final Ref _ref;

  Future<void> onTapPlayedDailyQuiz(HitterQuizResult hitterQuizResult) async {
    await _ref
        .read(analyticsServiceProvider)
        .logTapButton('to_daily_quiz_gallery_detail_page');

    await _ref
        .read(appRouterProvider)
        .push(QuizHistoryDailyRoute(hitterQuizResult: hitterQuizResult));
  }

  Future<void> onTapNotPlayedDailyQuiz(DateTime date) async {
    await executeWithOverlayLoading(
      _ref,
      action: () async {
        // 念のため、 invalidate する。
        _ref.invalidate(dailyQuizProvider(date));
        final dailyQuiz = await _ref.read(dailyQuizProvider(date).future);

        // * null （未登録などで取得できなかった）の場合。
        if (dailyQuiz == null) {
          final formattedDate = date.toFormattedString();
          logger.e('$formattedDate分の今日の1問が null でした。登録漏れの可能性があります。');
          throw Exception('daily quiz is null.');
        }
      },
      onLoadingComplete: () async {
        await _ref
            .read(analyticsServiceProvider)
            .logTapButton('show_confirm_play_past_daily_quiz_dialog');

        _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
              child: ConfirmPlayPastDailyQuizDialog(
                date: date,
                onPressed: () async => _onAcceptPlayPastDailyQuiz(date),
              ),
            );
      },
    );
  }

  Future<void> _onAcceptPlayPastDailyQuiz(DateTime questionedAt) async {
    await _ref
        .read(analyticsServiceProvider)
        .logTapButton('approved_play_past_daily_quiz');

    _ref.read(rewardedAdNotifierProvider.notifier).showAd(
          onUserEarnedReward: () => _ref
              .read(appRouterProvider)
              .push(PlayDailyQuizRoute(questionedAt: questionedAt)),
        );
  }
}
