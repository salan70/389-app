import 'package:hive_flutter/hive_flutter.dart';

import '../../../util/enum/hive_box_type.dart';
import '../domain/notification_setting.dart';
import '../domain/notification_setting_repository.dart';

class HiveNotificationSettingRepository
    implements NotificationSettingRepository {
  HiveNotificationSettingRepository(
    this.box,
  );

  final Box<NotificationSetting> box;

  final _boxKey = HiveBoxType.notificationSetting.key;

  @override
  Future<NotificationSetting> fetch() async => box.get(
        _boxKey,
        defaultValue: NotificationSetting.initial(),
      )!;

  @override
  Future<void> save(NotificationSetting notificationSetting) =>
      box.put(_boxKey, notificationSetting);
}
