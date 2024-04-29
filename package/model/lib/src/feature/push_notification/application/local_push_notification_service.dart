import 'package:common/common.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../daily_quiz/util/daily_quiz_constant.dart';
import '../domain/notification_setting.dart';
import '../infrastructure/notification_setting_repository.dart';
import 'notification_setting_state.dart';

part 'local_push_notification_service.g.dart';

@riverpod
LocalPushNotificationService localPushNotificationService(
  LocalPushNotificationServiceRef ref,
) =>
    LocalPushNotificationService(ref);

/// Analytics 関連の処理を行うサービスクラス。
class LocalPushNotificationService {
  LocalPushNotificationService(this.ref);

  final Ref ref;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const _notificationTitle = '.389 / プロ野球クイズ';

  static const _defaultNotificationDetail = NotificationDetails(
    android: AndroidNotificationDetails(
      '389-notification',
      '389-notification',
      channelDescription: '389 notification',
      importance: Importance.max,
      priority: Priority.max,
    ),
    iOS: DarwinNotificationDetails(badgeNumber: 1),
  );

  /// ローカルプッシュ通知の初期設定、スケジュールを行う。
  ///
  /// アプリ起動時に呼ぶことを想定している。
  Future<void> onAppLaunch() async {
    // 初期設定
    await _settingNotification();

    // バッジをリセット。
    await FlutterAppBadger.removeBadge();

    // スケジュール関連
    final setting = await ref.read(notificationSettingProvider.future);
    if (setting.allowStartDailyQuizNotification) {
      await _scheduleStartDailyQuizNotification();
    }
    if (setting.allowRemindDailyQuizNotification) {
      await scheduleRemindDailyQuizNotification();
    }
    if (setting.allowOtherNotification) {
      await _schedulePromoteAppNotification();
    }
  }

  @pragma('vm:entry-point')
  static Future<void> notificationTapBackground(
    NotificationResponse details,
  ) async {
    // バッジをリセット。
    await FlutterAppBadger.removeBadge();

    // 本来は LocalPushNotificationService で行いたい処理だが、
    // この関数は static でないといけないため、ここで直接 log 送信の処理を書いている。
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: 'tap_notification',
        parameters: {
          // 通知の種類を識別するために、通知のIDを送信している。
          // 万が一 null の場合は -999 を送信する。
          'notification_id': details.id ?? -999,
        },
      );
    } on Exception catch (e, s) {
      logger.e('通知タップのログを送信時にエラーが発生。', e, s);
    }
  }

  Future<void> _settingNotification() async {
    const initializationSettings = InitializationSettings(
      // TODO(me): Set good icon.
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
  }

  /// dailyQuiz の更新日時に毎日通知を送るようスケジュールする。
  Future<void> _scheduleStartDailyQuizNotification() async {
    const notificationType = NotificationType.startDailyQuiz;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationType.id,
      _notificationTitle,
      notificationType.message,
      _nextInstanceOfStartDailyQuiz(),
      _defaultNotificationDetail,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // 次の dailyQuiz の更新日時を返す。
  tz.TZDateTime _nextInstanceOfStartDailyQuiz() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      borderHourForTodayInApp,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// dailyQuiz の 更新30分前に通知を送るようスケジュールする。
  ///
  /// 今日分の dailyQuiz をプレイ済みの場合は、
  /// 今日分の dailyQuiz の分の通知を送らないようにしている。
  Future<void> scheduleRemindDailyQuizNotification() async {
    const notificationType = NotificationType.remindDailyQUiz;
    final isPlayedDailyQuiz =
        await ref.read(isPlayedTodaysDailyQuizProvider.future);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationType.id,
      _notificationTitle,
      notificationType.message,
      _nextInstanceOfRemindDailyQuiz(
        isPlayedTodaysDailyQuiz: isPlayedDailyQuiz,
      ),
      _defaultNotificationDetail,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 次の dailyQuiz の更新日時の30分前を返す。
  tz.TZDateTime _nextInstanceOfRemindDailyQuiz({
    required bool isPlayedTodaysDailyQuiz,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      borderHourForTodayInApp - 1,
      30,
    );
    if (scheduledDate.isBefore(now)) {
      // 今日分の dailyQuiz をプレイ済みの場合は、
      // 今日分の dailyQuiz の分を飛ばすようにしている。
      final addDayCount = isPlayedTodaysDailyQuiz ? 2 : 1;
      scheduledDate = scheduledDate.add(Duration(days: addDayCount));
    }
    return scheduledDate;
  }

  /// 最後にこの関数を呼んでから、1週間おきに通知を送るようスケジュールする。
  ///
  /// アプリ起動時に呼ぶことを想定している。
  Future<void> _schedulePromoteAppNotification() async {
    const notificationType = NotificationType.promoteApp;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationType.id,
      _notificationTitle,
      notificationType.message,
      _nextInstanceFor1WeekLater(),
      _defaultNotificationDetail,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 現在時刻の1週間後の日時を返す。
  tz.TZDateTime _nextInstanceFor1WeekLater() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }
    return scheduledDate;
  }

  /// [NotificationSetting.allowStartDailyQuizNotification] を保存し、
  /// 保存した値に応じて、通知のスケジュールを設定もしくはキャンセルする。
  Future<void> changeAllowStartDailyQuizNotificationSetting() async {
    // 保存関連の処理。
    final currentSetting = await ref.read(notificationSettingProvider.future);
    final nextSetting = currentSetting.copyWith(
      allowStartDailyQuizNotification:
          !currentSetting.allowStartDailyQuizNotification,
    );
    await ref.read(notificationSettingRepositoryProvider).save(nextSetting);

    // スケジュール変更もしくはキャンセルの処理。
    if (nextSetting.allowStartDailyQuizNotification) {
      await _scheduleStartDailyQuizNotification();
    } else {
      await _flutterLocalNotificationsPlugin
          .cancel(NotificationType.startDailyQuiz.id);
    }

    // [notificationSettingProvider] を再生成。
    ref.invalidate(notificationSettingProvider);
  }

  /// [NotificationSetting.allowRemindDailyQuizNotification] を保存し、
  /// 保存した値に応じて、通知のスケジュールを設定もしくはキャンセルする。
  Future<void> changeAllowRemindDailyQuizNotificationSetting() async {
    // 保存関連の処理。
    final currentSetting = await ref.read(notificationSettingProvider.future);
    final nextSetting = currentSetting.copyWith(
      allowRemindDailyQuizNotification:
          !currentSetting.allowRemindDailyQuizNotification,
    );
    await ref.read(notificationSettingRepositoryProvider).save(nextSetting);

    // スケジュール変更もしくはキャンセルの処理。
    if (nextSetting.allowRemindDailyQuizNotification) {
      await scheduleRemindDailyQuizNotification();
    } else {
      await _flutterLocalNotificationsPlugin
          .cancel(NotificationType.remindDailyQUiz.id);
    }

    // [notificationSettingProvider] を再生成。
    ref.invalidate(notificationSettingProvider);
  }

  /// [NotificationSetting.allowOtherNotification] を保存し、
  /// 保存した値に応じて、通知のスケジュールを設定もしくはキャンセルする。
  Future<void> changeAllowOtherNotificationSetting() async {
    // 保存関連の処理。
    final currentSetting = await ref.read(notificationSettingProvider.future);
    final nextSetting = currentSetting.copyWith(
      allowOtherNotification: !currentSetting.allowOtherNotification,
    );
    await ref.read(notificationSettingRepositoryProvider).save(nextSetting);

    // スケジュール変更もしくはキャンセルの処理。
    if (nextSetting.allowOtherNotification) {
      await _schedulePromoteAppNotification();
    } else {
      await _flutterLocalNotificationsPlugin
          .cancel(NotificationType.promoteApp.id);
    }

    // [notificationSettingProvider] を再生成。
    ref.invalidate(notificationSettingProvider);
  }
}

enum NotificationType {
  startDailyQuiz,
  remindDailyQUiz,
  promoteApp;

  String get message {
    switch (this) {
      case NotificationType.startDailyQuiz:
        return '今日の1問 が更新されました⚾⚾⚾';
      case NotificationType.remindDailyQUiz:
        return '今日の1問 は残り30分です❗❗';
      case NotificationType.promoteApp:
        return '久しぶりに1問どうですか？？🥺🥺🥺';
    }
  }

  int get id {
    switch (this) {
      case NotificationType.startDailyQuiz:
        return 0;
      case NotificationType.remindDailyQUiz:
        return 1;
      case NotificationType.promoteApp:
        return 2;
    }
  }
}
