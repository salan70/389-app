// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingAdapter extends TypeAdapter<NotificationSetting> {
  @override
  final int typeId = 2;

  @override
  NotificationSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSetting(
      allowStartDailyQuizNotification: fields[0] as bool,
      allowRemindDailyQuizNotification: fields[1] as bool,
      allowOtherNotification: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.allowStartDailyQuizNotification)
      ..writeByte(1)
      ..write(obj.allowRemindDailyQuizNotification)
      ..writeByte(2)
      ..write(obj.allowOtherNotification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingImpl _$$NotificationSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingImpl(
      allowStartDailyQuizNotification:
          json['allowStartDailyQuizNotification'] as bool,
      allowRemindDailyQuizNotification:
          json['allowRemindDailyQuizNotification'] as bool,
      allowOtherNotification: json['allowOtherNotification'] as bool,
    );

Map<String, dynamic> _$$NotificationSettingImplToJson(
        _$NotificationSettingImpl instance) =>
    <String, dynamic>{
      'allowStartDailyQuizNotification':
          instance.allowStartDailyQuizNotification,
      'allowRemindDailyQuizNotification':
          instance.allowRemindDailyQuizNotification,
      'allowOtherNotification': instance.allowOtherNotification,
    };
