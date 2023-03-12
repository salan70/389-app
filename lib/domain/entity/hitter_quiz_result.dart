// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../util/constant/hitting_stats_constant.dart';
import '../../util/json_converter.dart';
import 'stats_value.dart';

part 'hitter_quiz_result.freezed.dart';
part 'hitter_quiz_result.g.dart';

@freezed
class HitterQuizResult with _$HitterQuizResult {
  const factory HitterQuizResult({
    @JsonKey(name: 'playerId') required String id,
    @JsonKey(name: 'playerName') required String name,
    @DateTimeConverter() required DateTime updatedAt,
    required List<String> yearList,
    required List<String> selectedStatsList,
    required List<Map<String, StatsValue>> statsMapList,
    required int unveilCount,
    required bool isCorrect,
    required int incorrectCount,
  }) = _HitterQuizResult;

  const HitterQuizResult._();

  factory HitterQuizResult.fromJson(Map<String, dynamic> json) =>
      _$HitterQuizResultFromJson(json);

  // TODO(me): selectedStatsListに年度が含まれた場合、年度をremoveする処理を書く'

  // 表示しうる成績の数
  int get totalStatsCount {
    return statsMapList.length * statsMapList.first.keys.length;
  }

  // 成績を表示した割合
  double get unveilRate {
    return unveilCount / totalStatsCount;
  }

  // 間違えた数と表示した割合から評価を行う
  ResultRank get resultRank {
    // 不正解の場合
    if (!isCorrect) {
      return ResultRank.incorrect;
    }

    // 正解の場合
    if (incorrectCount == 0 && unveilRate <= 0.1) {
      return ResultRank.ss;
    }

    if (incorrectCount <= 2 && unveilRate <= 0.2) {
      return ResultRank.s;
    }

    if (incorrectCount <= 4 && unveilRate <= 0.5) {
      return ResultRank.a;
    }

    if (incorrectCount <= 9 && unveilRate <= 0.7) {
      return ResultRank.b;
    }

    return ResultRank.c;
  }
}
