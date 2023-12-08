// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReviewHistory _$$_ReviewHistoryFromJson(Map<String, dynamic> json) =>
    _$_ReviewHistory(
      isDisplayedReviewDialog: json['isDisplayedReviewDialog'] as bool,
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$_ReviewHistoryToJson(_$_ReviewHistory instance) =>
    <String, dynamic>{
      'isDisplayedReviewDialog': instance.isDisplayedReviewDialog,
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
