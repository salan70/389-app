import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../daily_quiz/util/daily_quiz_constant.dart';

final localPushNotificationServiceProvider =
    Provider(LocalPushNotificationService.new);

/// Analytics 関連の処理を行うサービスクラス。
class LocalPushNotificationService {
  LocalPushNotificationService(this.ref);

  final Ref ref;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> settingNotification() async {
    const initializationSettings = InitializationSettings(
      // todo: Set good icon.
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleStartDailyQuizNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '.389 / プロ野球クイズ',
      '今日の1問 が更新されました⚾⚾⚾',
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

  // 1回目に通知を飛ばす時間の作成
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
}
