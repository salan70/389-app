import 'package:baseball_quiz_app/feature/push_notification/domain/notification_setting.dart';
import 'package:baseball_quiz_app/feature/push_notification/domain/notification_setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationSettingProvider = FutureProvider<NotificationSetting>(
  (ref) => ref.watch(notificationSettingRepositoryProvider).fetch(),
);
