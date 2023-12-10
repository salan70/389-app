import 'package:baseball_quiz_app/feature/push_notification/domain/notification_setting.dart';
import 'package:baseball_quiz_app/feature/push_notification/domain/notification_setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_setting_state.g.dart';

@riverpod
Future<NotificationSetting> notificationSetting(
  NotificationSettingRef ref,
) async =>
    ref.watch(notificationSettingRepositoryProvider).fetch();
