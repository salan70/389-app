import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import 'hitter.dart';
import 'hitter_quiz.dart';

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
