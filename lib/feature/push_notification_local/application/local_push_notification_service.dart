import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../daily_quiz/application/daily_quiz_service.dart';
import '../../daily_quiz/util/daily_quiz_constant.dart';

final localPushNotificationServiceProvider =
    Provider(LocalPushNotificationService.new);

/// Analytics 関連の処理を行うサービスクラス。
class LocalPushNotificationService {
  LocalPushNotificationService(this.ref);

  final Ref ref;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const _notificationTitle = '.389 / プロ野球クイズ';

  /// ローカルプッシュ通知の初期設定、スケジュールを行う。
  ///
  /// アプリ起動時に呼ぶことを想定している。
  Future<void> onAppLaunch() async {
    // 初期設定
    await _settingNotification();

    // todo: 設定状況に応じて通知を送るようにする。
    // スケジュール関連
    await _scheduleStartDailyQuizNotification();

    // TODO(me): 個々の処理、他の Service に依存するのと、処理が冗長なの気になる。
    final dailyQuizService = ref.read(dailyQuizServiceProvider);
    await dailyQuizService.fetchDailyQuiz();
    final canPlay = await dailyQuizService.canPlayDailyQuiz();
    // プレイできるかどうかで、 dailyQuiz をプレイ済みかどうかを判別している。
    await scheduleRemindDailyQuizNotification(isDoneTodaysDailyQuiz: !canPlay);

    await _schedulePromoteAppNotification();
  }

  Future<void> _settingNotification() async {
    const initializationSettings = InitializationSettings(
      // todo: Set good icon.
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// dailyQuiz の更新日時に毎日通知を送るようスケジュールする。
  Future<void> _scheduleStartDailyQuizNotification() async {
    const notificationType = NotificationType.startDailyQuiz;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationType.id,
      _notificationTitle,
      notificationType.message,
      _nextInstanceOfStartDailyQuiz(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '389-daily-quiz-start',
          '389-daily-quiz-start',
          channelDescription: 'Start daily quiz notification',
        ),
        iOS: DarwinNotificationDetails(badgeNumber: 1),
      ),
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
  /// [isDoneTodaysDailyQuiz] は、今日分の dailyQuiz をプレイ済みかどうか。
  /// プレイ済みの場合は、今日分の dailyQuiz の分の通知を送らないようにしている。
  Future<void> scheduleRemindDailyQuizNotification({
    required bool isDoneTodaysDailyQuiz,
  }) async {
    const notificationType = NotificationType.remindDailyQUiz;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationType.id,
      _notificationTitle,
      notificationType.message,
      _nextInstanceOfRemindDailyQuiz(
        isDoneTodaysDailyQuiz: isDoneTodaysDailyQuiz,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '389-daily-quiz-remind',
          '389-daily-quiz-remind',
          channelDescription: 'Remind daily quiz notification',
        ),
        iOS: DarwinNotificationDetails(badgeNumber: 1),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 次の dailyQuiz の更新日時の30分前を返す。
  tz.TZDateTime _nextInstanceOfRemindDailyQuiz({
    required bool isDoneTodaysDailyQuiz,
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
      final addDayCount = isDoneTodaysDailyQuiz ? 2 : 1;
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
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '389-other',
          '389-other',
          channelDescription: 'Other notification',
        ),
        iOS: DarwinNotificationDetails(badgeNumber: 1),
      ),
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
        return '今日の1問 は残り30分で更新されます！！';
      case NotificationType.promoteApp:
        return '久しぶりに1問どうですか？？';
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
