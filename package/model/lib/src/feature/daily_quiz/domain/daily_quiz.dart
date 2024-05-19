import 'package:freezed_annotation/freezed_annotation.dart';

import '../../season/util/season_type.dart';

part 'daily_quiz.freezed.dart';

@freezed
class DailyQuiz with _$DailyQuiz {
  const factory DailyQuiz({
    required String dailyQuizId,
    required DateTime questionedAt,
    required String playerId,
    required List<String> selectedStatsList,
    required SeasonType seasonType,
  }) = _DailyQuiz;
}
