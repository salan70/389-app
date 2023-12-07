import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification_setting.freezed.dart';
part 'notification_setting.g.dart';

@HiveType(typeId: 2)
@freezed
class NotificationSetting with _$NotificationSetting {
  const factory NotificationSetting({
    @HiveField(0) required bool allowStartDailyQuizNotification,
    @HiveField(1) required bool allowRemindDailyQuizNotification,
    @HiveField(2) required bool allowOtherNotification,
  }) = _NotificationSetting;

  /// ユーザーが未設定の場合の初期値
  factory NotificationSetting.initial() => const NotificationSetting(
        allowStartDailyQuizNotification: true,
        allowRemindDailyQuizNotification: true,
        allowOtherNotification: true,
      );

  factory NotificationSetting.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
