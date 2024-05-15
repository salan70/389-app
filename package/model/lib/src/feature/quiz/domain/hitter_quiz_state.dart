import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import 'hitter.dart';
import 'hitter_quiz.dart';

@immutable
class HitterQuizState {
  const HitterQuizState.normal({
    required this.hitterQuiz,
    required this.enteredHitter,
  }) : quizType = QuizType.normal;

  const HitterQuizState.daily({
    required this.hitterQuiz,
    required this.enteredHitter,
  }) : quizType = QuizType.daily;

  final HitterQuiz hitterQuiz;
  final Hitter? enteredHitter;
  final QuizType quizType;

  bool get isCorrectEnteredHitter => enteredHitter?.id == hitterQuiz.hitterId;

  HitterQuizState copyWith({
    HitterQuiz? hitterQuiz,
    Hitter? enteredHitter,
  }) {
    switch (quizType) {
      case QuizType.normal:
        return HitterQuizState.normal(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          enteredHitter: enteredHitter ?? this.enteredHitter,
        );

      case QuizType.daily:
        return HitterQuizState.daily(
          hitterQuiz: hitterQuiz ?? this.hitterQuiz,
          enteredHitter: enteredHitter ?? this.enteredHitter,
        );
    }
  }
}
