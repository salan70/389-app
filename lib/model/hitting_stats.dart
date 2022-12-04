// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitting_stats.freezed.dart';
part 'hitting_stats.g.dart';

@freezed
class HittingStats with _$HittingStats {
  const factory HittingStats({
    required String playerId,
    @JsonKey(name: '年度') required String year,
    @JsonKey(name: '球団') required String team,
    @JsonKey(name: '試合') required int games,
    @JsonKey(name: '打席') required int pa,
    @JsonKey(name: '打数') required int atBats,
    @JsonKey(name: '得点') required int runs,
    @JsonKey(name: '安打') required int hits,
    @JsonKey(name: '二塁打') required int twoB,
    @JsonKey(name: '三塁打') required int threeB,
    @JsonKey(name: '本塁打') required int hr,
    @JsonKey(name: '塁打') required int tb,
    @JsonKey(name: '打点') required int rbi,
    @JsonKey(name: '盗塁') required int sb,
    @JsonKey(name: '盗塁死') required int cs,
    @JsonKey(name: '犠打') required int sac,
    @JsonKey(name: '犠飛') required int sf,
    @JsonKey(name: '四球') required int bb,
    @JsonKey(name: '敬遠') required int ibb,
    @JsonKey(name: '死球') required int hbp,
    @JsonKey(name: '三振') required int so,
    @JsonKey(name: '併殺打') required int gidp,
    @JsonKey(name: '打率') required String avg,
    @JsonKey(name: '出塁率') required String obp,
    @JsonKey(name: '長打率') required String slg,
    @JsonKey(name: 'OPS') required String ops,
  }) = _HittingStats;

  factory HittingStats.fromJson(Map<String, dynamic> json) =>
      _$HittingStatsFromJson(json);
}
