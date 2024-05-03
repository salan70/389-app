import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import '../../quiz_result/domain/hitter_quiz_result.dart';
import 'hitter.dart';
import 'stats_value.dart';

part 'hitter_quiz.freezed.dart';

@freezed
class HitterQuiz with _$HitterQuiz {
  const factory HitterQuiz({
    required String id,
    required String name,

    /// ユーザーが回答として入力した Hitter
    required Hitter? enteredHitter,
    required QuizType? quizType,
    required List<String> yearList,
    required List<String> selectedStatsList,
    required List<Map<String, StatsValue>> statsMapList,
    required int unveilCount,
    required bool isCorrect,
    required int incorrectCount,
  }) = _HitterQuiz;
  const HitterQuiz._();

  factory HitterQuiz.fromHitterResult(
    HitterQuizResult result,
    QuizType quizType,
  ) {
    return HitterQuiz(
      id: result.id,
      name: result.name,
      enteredHitter: null,
      quizType: quizType,
      yearList: result.yearList,
      selectedStatsList: result.selectedStatsList,
      statsMapList: result.statsMapList,
      unveilCount: result.unveilCount,
      isCorrect: result.isCorrect,
      incorrectCount: result.incorrectCount,
    );
  }
}
