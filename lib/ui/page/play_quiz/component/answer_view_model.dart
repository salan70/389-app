import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../repository/supabase/supabase_hitter_repository.dart';
import '../../../../state/hitter_quiz_ui_state.dart';

final answerViewModelProvider = Provider<AnswerViewModel>(AnswerViewModel.new);

final selectedHitterIdProvider = StateProvider<String>((_) => '');

class AnswerViewModel {
  AnswerViewModel(
    this.ref,
  );

  final Ref ref;

  Future<List<HitterIdByName>> filterHitter(String searchWord) async {
    final allHitterList = await ref.read(allHitterListProvider);
    final hitterListAfterSearch = <HitterIdByName>[];

    for (final hitter in allHitterList) {
      if (hitter.label.contains(searchWord)) {
        hitterListAfterSearch.add(hitter);
      }
    }

    return hitterListAfterSearch;
  }

  /// 正解しているか否かを返す
  bool isCorrectHitterQuiz() {
    final selectedHitterId = ref.read(selectedHitterIdProvider);
    final hitterQuizUi = ref.read(hitterQuizUiStateProvider);

    return selectedHitterId == hitterQuizUi.value!.id;
  }
}
