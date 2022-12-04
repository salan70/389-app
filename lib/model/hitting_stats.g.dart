// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitting_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HittingStats _$$_HittingStatsFromJson(Map<String, dynamic> json) =>
    _$_HittingStats(
      playerId: json['playerId'] as String,
      year: json['年度'] as String,
      team: json['球団'] as String,
      games: json['試合'] as int,
      pa: json['打席'] as int,
      atBats: json['打数'] as int,
      runs: json['得点'] as int,
      hits: json['安打'] as int,
      twoB: json['二塁打'] as int,
      threeB: json['三塁打'] as int,
      hr: json['本塁打'] as int,
      tb: json['塁打'] as int,
      rbi: json['打点'] as int,
      sb: json['盗塁'] as int,
      cs: json['盗塁死'] as int,
      sac: json['犠打'] as int,
      sf: json['犠飛'] as int,
      bb: json['四球'] as int,
      ibb: json['敬遠'] as int,
      hbp: json['死球'] as int,
      so: json['三振'] as int,
      gidp: json['併殺打'] as int,
      avg: json['打率'] as String,
      obp: json['出塁率'] as String,
      slg: json['長打率'] as String,
      ops: json['OPS'] as String,
    );

Map<String, dynamic> _$$_HittingStatsToJson(_$_HittingStats instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      '年度': instance.year,
      '球団': instance.team,
      '試合': instance.games,
      '打席': instance.pa,
      '打数': instance.atBats,
      '得点': instance.runs,
      '安打': instance.hits,
      '二塁打': instance.twoB,
      '三塁打': instance.threeB,
      '本塁打': instance.hr,
      '塁打': instance.tb,
      '打点': instance.rbi,
      '盗塁': instance.sb,
      '盗塁死': instance.cs,
      '犠打': instance.sac,
      '犠飛': instance.sf,
      '四球': instance.bb,
      '敬遠': instance.ibb,
      '死球': instance.hbp,
      '三振': instance.so,
      '併殺打': instance.gidp,
      '打率': instance.avg,
      '出塁率': instance.obp,
      '長打率': instance.slg,
      'OPS': instance.ops,
    };
