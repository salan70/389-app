import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/hitter_quiz_ui_state.dart';
import '../ui/page/play_quiz/component/answer_view_model.dart';

final quizUsecaseProvider = Provider<QuizUsecase>(QuizUsecase.new);

class QuizUsecase {
  QuizUsecase(
    this.ref,
  );

  final Ref ref;

  /// 正解しているか否かを返す
  bool isCorrectHitterQuiz() {
    final selectedHitterId = ref.watch(selectedHitterIdProvider);
    final hitterQuizUi = ref.watch(hitterQuizUiNotifierProvider);

    return selectedHitterId == hitterQuizUi.value!.id;
  }
}
