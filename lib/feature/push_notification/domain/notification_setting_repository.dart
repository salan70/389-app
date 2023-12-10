import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notification_setting.dart';

final notificationSettingRepositoryProvider =
    Provider<NotificationSettingRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class NotificationSettingRepository {
  /// [NotificationSetting] を取得する。
  Future<NotificationSetting> fetch();

  /// [NotificationSetting] を保存する。
  Future<void> save(NotificationSetting notificationSetting);
}
