// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitter_quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HitterQuizResult _$$_HitterQuizResultFromJson(Map<String, dynamic> json) =>
    _$_HitterQuizResult(
      id: json['playerId'] as String,
      name: json['playerName'] as String,
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as Object),
      yearList:
          (json['yearList'] as List<dynamic>).map((e) => e as String).toList(),
      selectedStatsList: (json['selectedStatsList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      statsMapList: (json['statsMapList'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) =>
                    MapEntry(k, StatsValue.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
      unveilCount: json['unveilCount'] as int,
      isCorrect: json['isCorrect'] as bool,
      incorrectCount: json['incorrectCount'] as int,
    );

Map<String, dynamic> _$$_HitterQuizResultToJson(_$_HitterQuizResult instance) =>
    <String, dynamic>{
      'playerId': instance.id,
      'playerName': instance.name,
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
      'yearList': instance.yearList,
      'selectedStatsList': instance.selectedStatsList,
      'statsMapList': instance.statsMapList,
      'unveilCount': instance.unveilCount,
      'isCorrect': instance.isCorrect,
      'incorrectCount': instance.incorrectCount,
    };
