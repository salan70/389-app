import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/enum/hive_box_type.dart';
import '../domain/notification_setting.dart';

part 'notification_setting_repository.g.dart';

@riverpod
NotificationSettingRepository notificationSettingRepository(
  NotificationSettingRepositoryRef ref,
) =>
    throw UnimplementedError();

class NotificationSettingRepository {
  NotificationSettingRepository(this.box);

  final Box<NotificationSetting> box;

  final _boxKey = HiveBoxType.notificationSetting.key;

  Future<NotificationSetting> fetch() async => box.get(
        _boxKey,
        defaultValue: NotificationSetting.initial(),
      )!;

  Future<void> save(NotificationSetting notificationSetting) =>
      box.put(_boxKey, notificationSetting);
}
