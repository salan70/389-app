import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/supabase/supabase_hitter_repository.dart';
import '../ui/page/play_quiz/component/input_answer_view_model.dart';

final quizUsecaseProvider = Provider<QuizUsecase>(QuizUsecase.new);

class QuizUsecase {
  QuizUsecase(
    this.ref,
  );

  final Ref ref;

  bool judgeQuizResult() {
    final selectedHitterId = ref.watch(selectedHitterIdProvider);
    final hitterQuizUi = ref.watch(hitterQuizUiStateProvider);

    if (selectedHitterId == hitterQuizUi.value!.id) {
      return true;
    }
    return false;
  }
}
