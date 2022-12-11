import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_map.dart';
import '../../../../repository/supabase/hitter_repository.dart';
//TODO 別のviewModelに依存しちゃってるのよくないから治す
import 'quiz_view_model.dart';

final inputAnswerViewModelProvider = Provider.autoDispose((ref) {
  return InputAnswerViewModel(ref);
});

final selectedHitterIdProvider = StateProvider((ref) {
  return '';
});

class InputAnswerViewModel {
  InputAnswerViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO 関数名もっといいの検討
  Future<List<HitterMap>> searchHitter(String searchWord) async {
    final allHitterList = await ref.watch(allHitterListProvider);
    final hitterListAfterSearch = <HitterMap>[];

    for (var hitter in allHitterList) {
      if (hitter.label.contains(searchWord)) {
        hitterListAfterSearch.add(hitter);
      }
    }

    return hitterListAfterSearch;
  }

  bool judgeQuizResult() {
    final selectedHitterId = ref.watch(selectedHitterIdProvider);
    final hitterQuizUi = ref.watch(hitterQuizUiProvider);

    if (selectedHitterId == hitterQuizUi.value!.id) {
      return true;
    }
    return false;
  }
}
