import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/router/app_router.dart';
import '../../core/util/controller_mixin.dart';
import '../component/common/dialog/error_dialog.dart';
import '../component/play_quiz_daily/start_todays_daily_quiz_button.dart';
import '../component/setting/notification_setting_dialog.dart';
import '../component/setting/setting_dialog.dart';
import 'common/navigator_key_controller.dart';

part 'top_page_controller.g.dart';

@riverpod
TopPageController topPageController(TopPageControllerRef ref) =>
    TopPageController(ref);

class TopPageController with ControllerMixin {
  TopPageController(this._ref);

  final Ref _ref;

  /// 設定画面（ダイアログ）を開く。
  void onTapOpenSetting() {
    _showDialog(
      child: SettingDialog(onTapNotificationSetting: _onTapNotificationSetting),
    );
  }

  Future<void> startNormalQuiz() async {
    await executeWithOverlayLoading(
      _ref,
      // クイズ取得時のエラーをキャッチできるよう、ここで `hitterQuizStateProvider` を取得しておく。
      action: () async => _ref.read(hitterQuizStateProvider.future),
      onLoadingComplete: () async =>
          _ref.read(appRouterProvider).push(PlayNormalQuizRoute()),
    );
  }

  /// 今日の1問を開始する。
  ///
  /// プレイ状況などによっては、今日の1問がプレイできない場合がある。
  Future<void> onTapPlayTodaysDailyQuiz() async {
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
      logger.e('[to_play_daily_quiz_button]タップ時にエラーが発生しました。', e, s);
      loadingNotifier.hide();
      _showDialog(child: ErrorDialog(error: e));
    }
  }

  Future<void> _onAcceptPlayDailyQuiz() async {
    await executeWithOverlayLoading(
      _ref,
      // ローカルプッシュ通知のスケジュールを更新し、
      // プレイ済みなのにリマインドが通知されるのを防ぐ。
      action: () async => _ref
          .read(localPushNotificationServiceProvider)
          .scheduleRemindDailyQuizNotification(),
      onLoadingComplete: _toPlayDailyQuizPage,
    );
  }

  Future<void> _toPlayDailyQuizPage() async {
    final nowInApp = await _nowInApp();

    // dailyQuizResult ドキュメントを保存（新規作成）する。
    await _ref.read(quizResultServiceProvider).createDailyQuizResult(nowInApp);

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

  // * ダイアログ表示関連（ private ）

  Future<void> _onTapNotificationSetting() async =>
      _showDialog(child: const NotificationSettingDialog());

  void _showDialog({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    _ref.read(navigatorKeyControllerProvider).showDialogWithChild(
          child: child,
          barrierDismissible: barrierDismissible,
        );
  }

  void _showAlertAlreadyPlayedDialog() =>
      _showDialog(child: const AlertAlreadyPlayedDailyQuizDialog());

  void _showAlertNotFoundDialog() =>
      _showDialog(child: const AlertNotFoundDailyQuizDialog());

  void _showConfirmPlayDialog() => _showDialog(
        child: ConfirmPlayDailyQuizDialog(onPressedYes: _onAcceptPlayDailyQuiz),
      );
}
