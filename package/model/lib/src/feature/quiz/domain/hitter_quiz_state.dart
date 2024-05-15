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
}
