import 'package:common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../component/play_daily_quiz/start_todays_daily_quiz_button.dart';
import '../core/common_widget/dialog/error_dialog.dart';
import '../core/router/app_router.dart';
import '../core/router/scaffold_messenger_key.dart';
import '../core/util/context_extension.dart';
import '../core/util/controller_mixin.dart';

part 'top_page_controller.g.dart';

@riverpod
TopPageController topPageController(TopPageControllerRef ref) =>
    TopPageController(ref);

class TopPageController with ControllerMixin {
  TopPageController(this._ref);

  final Ref _ref;

  Future<void> startNormalQuiz() async {
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

  /// 今日の1問を開始する。
  ///
  /// プレイ状況などによっては、今日の1問がプレイできない場合がある。
  Future<void> startTodaysDailyQuiz() async {
    // TODO(me): ローディングダイアログを非表示にする処理、 finally でやりたい。
    // TODO(me): ローディング, エラーに関する処理もう少しきれいに書きたい。
    final loadingNotifier = _ref.read(loadingNotifierProvider.notifier)..show();
    try {
      final isPlayedDailyQuiz =
          await _ref.read(isPlayedTodaysDailyQuizProvider.future);

      // * プレイ済みの場合
      if (isPlayedDailyQuiz) {
        loadingNotifier.hide();
        _showAlertAlreadyPlayedDialog();
        return;
      }

      // * 未プレイの場合
      final dailyQuiz = await _fetchTodaysDailyQuiz();

      // ** 今日の1問が null （未登録などで取得できなかった）の場合
      if (dailyQuiz == null) {
        logger.e('今日の1問が null でした。登録漏れの可能性があります。');
        loadingNotifier.hide();
        _showAlertNotFoundDialog();
        return;
      }

      // ** 今日の1問がプレイできる場合。
      loadingNotifier.hide();
      _showConfirmPlayDialog();
    }

    // * エラーが発生した場合。
    on Exception catch (e, s) {
      logger.e(
        '[to_play_daily_quiz_button]タップ時にエラーが発生しました。',
        e,
        s,
      );
      loadingNotifier.hide();
      _showErrorDialog();
    }
  }

  Future<void> _onAcceptPlayDailyQuiz() async {
    await executeWithOverlayLoading(
      _ref,
      action: () async {
        await _createTodaysDailyQuiz();

        // ローカルプッシュ通知のスケジュールを更新し、
        // プレイ済みなのにリマインドが通知されるのを防ぐ。
        await _ref
            .read(localPushNotificationServiceProvider)
            .scheduleRemindDailyQuizNotification();
      },
      onLoadingComplete: _toPlayDailyQuizPage,
    );
  }

  Future<void> _createTodaysDailyQuiz() async {
    final nowInApp = await _nowInApp();

    // クイズを作成する。
    await _ref.read(
      hitterQuizNotifierProvider(
        QuizType.daily,
        questionedAt: nowInApp,
      ).future,
    );
  }

  Future<void> _toPlayDailyQuizPage() async {
    final nowInApp = await _nowInApp();
    await _ref
        .read(appRouterProvider)
        .push(PlayDailyQuizRoute(questionedAt: nowInApp));
  }

  Future<DailyQuiz?> _fetchTodaysDailyQuiz() async {
    // 念のため invalidate する。
    _ref.invalidate(dailyQuizProvider);
    final nowInApp = await _nowInApp();

    return await _ref.read(dailyQuizProvider(nowInApp).future);
  }

  Future<DateTime> _nowInApp() async {
    final now = await NTP.now();
    return now.calculateDateInApp();
  }

  // * ダイアログ表示関連

  void _showAlertAlreadyPlayedDialog() => _ref
      .read(scaffoldMessengerKeyProvider)
      .currentContext!
      .showDialogWithChild(const AlertAlreadyPlayedDailyQuizDialog());

  void _showAlertNotFoundDialog() => _ref
      .read(scaffoldMessengerKeyProvider)
      .currentContext!
      .showDialogWithChild(const AlertNotFoundDailyQuizDialog());

  void _showConfirmPlayDialog() => _ref
      .read(scaffoldMessengerKeyProvider)
      .currentContext!
      .showDialogWithChild(
        ConfirmPlayDailyQuizDialog(onPressedYes: _onAcceptPlayDailyQuiz),
      );

  void _showErrorDialog() => _ref
      .read(scaffoldMessengerKeyProvider)
      .currentContext!
      .showDialogWithChild(const ErrorDialog());
}
