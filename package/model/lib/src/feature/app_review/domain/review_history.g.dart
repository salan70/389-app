// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewHistoryImpl _$$ReviewHistoryImplFromJson(Map<String, dynamic> json) =>
    _$ReviewHistoryImpl(
      isDisplayedReviewDialog: json['isDisplayedReviewDialog'] as bool,
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$ReviewHistoryImplToJson(_$ReviewHistoryImpl instance) =>
    <String, dynamic>{
      'isDisplayedReviewDialog': instance.isDisplayedReviewDialog,
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
