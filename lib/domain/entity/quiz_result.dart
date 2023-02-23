// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result.freezed.dart';

@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
    required String playerId,
    required bool isCorrect,
    required int totalStatsCount,
    required int openStatsCount,
    required int incorrectCount,
  }) = _QuizResult;
}
