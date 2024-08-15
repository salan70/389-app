import 'package:freezed_annotation/freezed_annotation.dart';

import '../../season/util/season_type.dart';
import 'stats_value.dart';

part 'hitter_quiz.freezed.dart';

@freezed
class HitterQuiz with _$HitterQuiz {
  const factory HitterQuiz({
    /// 回答となる [Hitter] の id.
    required String hitterId,

    /// 回答となる [Hitter] の名前。
    required String hitterName,

    /// クイズの対象となる年度のリスト。
    required List<String> yearList,

    /// クイズの対象となる成績の種類リスト。
    ///
    /// 例: ['打率', '本塁打', '打点', '盗塁']
    required List<String> selectedStatsList,

    /// クイズの対象となる成績の値のリスト。
    required List<Map<String, StatsValue>> statsMapList,

    /// 公開された成績の数。
    required int unveilCount,

    /// 不正解した回数。
    required int incorrectCount,

    /// 対象となるシーズンの種類。
    required SeasonType seasonType,
  }) = _HitterQuiz;
  const HitterQuiz._();

  /// すべての成績数。
  int get totalStatsCount => statsMapList.length * selectedStatsList.length;

  /// すべての成績が公開されているかどうか。
  bool get isAllStatsUnveiled => unveilCount >= totalStatsCount;
}
