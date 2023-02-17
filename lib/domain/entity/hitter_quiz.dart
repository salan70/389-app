import 'package:freezed_annotation/freezed_annotation.dart';

import 'stats_value.dart';

part 'hitter_quiz.freezed.dart';

@freezed
class HitterQuiz with _$HitterQuiz {
  const factory HitterQuiz({
    required String id,
    required String name,
    required List<String> selectedStatsList,
    required List<Map<String, StatsValue>> statsMapList,
    required List<String> hiddenStatsIdList,
    required int isCorrectCount,
  }) = _HitterQuiz;
}
