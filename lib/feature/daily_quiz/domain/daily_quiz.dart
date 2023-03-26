// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_quiz.freezed.dart';

@freezed
class DailyQuiz with _$DailyQuiz {
  const factory DailyQuiz({
    required String dailyQuizId,
    required DateTime questionedAt,
    required String playerId,
    required List<String> selectedStatsList,
  }) = _DailyQuiz;
}
