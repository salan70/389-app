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
}
