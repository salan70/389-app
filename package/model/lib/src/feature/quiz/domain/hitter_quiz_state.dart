import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import '../../quiz_result/domain/hitter_quiz_result.dart';
import 'hitter.dart';
import 'stats_value.dart';

part 'hitter_quiz_state.freezed.dart';

@immutable
sealed class HitterQuizState {
  const HitterQuizState({required this.hitterQuiz, required this.quizType});
  final HitterQuiz hitterQuiz;
  final QuizType quizType;

  /// 入力した選手が正解かどうか。
  bool get isCorrectEnteredHitter => throw UnimplementedError();
}

@immutable
class InputQuizState extends HitterQuizState {
  const InputQuizState.normal({
    required super.hitterQuiz,
    required this.enteredHitter,
  }) : super(quizType: QuizType.normal);

  const InputQuizState.daily({
    required super.hitterQuiz,
    required this.enteredHitter,
  }) : super(quizType: QuizType.daily);

  final Hitter? enteredHitter;

  @override
  bool get isCorrectEnteredHitter => enteredHitter?.id == hitterQuiz.hitterId;

  InputQuizState copyWith({
    HitterQuiz? hitterQuiz,
    Hitter? enteredHitter,
  }) {
    switch (quizType) {
      case QuizType.normal:
        return InputQuizState.normal(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          enteredHitter: enteredHitter ?? this.enteredHitter,
        );

      case QuizType.daily:
        return InputQuizState.daily(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          enteredHitter: enteredHitter ?? this.enteredHitter,
        );
    }
  }

  /// [ResultQuizState] に変換する。
  ResultQuizState toResultQuizState() {
    final isCorrect = isCorrectEnteredHitter;
    switch (quizType) {
      case QuizType.normal:
        return ResultQuizState.normal(
          hitterQuiz: hitterQuiz,
          isCorrect: isCorrect,
        );

      case QuizType.daily:
        return ResultQuizState.daily(
          hitterQuiz: hitterQuiz,
          isCorrect: isCorrect,
        );
    }
  }
}

@immutable
class ResultQuizState extends HitterQuizState {
  const ResultQuizState.normal({
    required super.hitterQuiz,
    required this.isCorrect,
  }) : super(quizType: QuizType.normal);

  const ResultQuizState.daily({
    required super.hitterQuiz,
    required this.isCorrect,
  }) : super(quizType: QuizType.daily);

  final bool isCorrect;

  @override
  bool get isCorrectEnteredHitter => isCorrect;

  ResultQuizState copyWith({
    HitterQuiz? hitterQuiz,
    bool? isCorrect,
  }) {
    switch (quizType) {
      case QuizType.normal:
        return ResultQuizState.normal(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          isCorrect: isCorrect ?? this.isCorrect,
        );

      case QuizType.daily:
        return ResultQuizState.daily(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          isCorrect: isCorrect ?? this.isCorrect,
        );
    }
  }
}

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
  }) = _HitterQuiz;
  const HitterQuiz._();

  factory HitterQuiz.fromHitterResult(HitterQuizResult result) {
    return HitterQuiz(
      hitterId: result.id,
      hitterName: result.name,
      yearList: result.yearList,
      selectedStatsList: result.selectedStatsList,
      statsMapList: result.statsMapList,
      unveilCount: result.unveilCount,
      incorrectCount: result.incorrectCount,
    );
  }

  /// すべての成績数。
  int get totalStatsCount => statsMapList.length * selectedStatsList.length;

  /// すべての成績が公開されているかどうか。
  bool get isAllStatsUnveiled => unveilCount >= totalStatsCount;
}
