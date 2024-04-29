import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/notification_setting.dart';
import '../infrastructure/notification_setting_repository.dart';

part 'notification_setting_state.g.dart';

@riverpod
Future<NotificationSetting> notificationSetting(
  NotificationSettingRef ref,
) async =>
    ref.watch(notificationSettingRepositoryProvider).fetch();
