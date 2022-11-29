import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'hitter_stats.freezed.dart';

@freezed
class HitterStats with _$HitterStats {
  const factory HitterStats({
    required String playerId,
    required String year, // 年度
    required String team, // 球団
    required int games, // 試合
    required int pa, // 打席
    required int atBats, // 打数
    required int runs, // 得点
    required int hits, // 安打
    required int twoB, // 2塁打
    required int threeB, // 3塁打
    required int hr, // 本塁打
    required int tb, // 塁打
    required int rbi, // 打点
    required int sb, // 盗塁
    required int cs, // 盗塁死
    required int sac, // 犠打
    required int sf, // 犠飛
    required int bb, // 四球
    required int ibb, // 敬遠
    required int hbp, // 死球
    required int so, // 三振
    required int gidp, // 併殺打
    required String avg, // 打率
    required String obp, // 出塁率
    required String slg, // 長打率
    required String ops, // OPS
  }) = _HitterStats;
}
