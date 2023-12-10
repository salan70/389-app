import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'notification_setting.dart';

part 'notification_setting_repository.g.dart';

@riverpod
NotificationSettingRepository notificationSettingRepository(
  NotificationSettingRepositoryRef ref,
) =>
    throw UnimplementedError('Provider was not initialized');

abstract class NotificationSettingRepository {
  /// [NotificationSetting] を取得する。
  Future<NotificationSetting> fetch();

  /// [NotificationSetting] を保存する。
  Future<void> save(NotificationSetting notificationSetting);
}
