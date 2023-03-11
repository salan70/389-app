import 'package:freezed_annotation/freezed_annotation.dart';

import '../../util/constant/hitting_stats_constant.dart';
import 'stats_value.dart';

part 'hitter_quiz.freezed.dart';

@freezed
class HitterQuiz with _$HitterQuiz {
  const factory HitterQuiz({
    required String id,
    required String name,
    required QuizType quizType,
    required List<String> yearList,
    required List<String> selectedStatsList,
    required List<Map<String, StatsValue>> statsMapList,
    required int unveilCount,
    required bool isCorrect,
    required int incorrectCount,
  }) = _HitterQuiz;

  const HitterQuiz._();

  // TODO(me): selectedStatsListに年度が含まれた場合、年度をremoveする処理を書く'

  // 成績を表示した割合
  double get unveilRate {
    final totalStatsCount = yearList.length * selectedStatsList.length;
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
