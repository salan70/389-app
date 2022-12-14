import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_map.dart';
import '../../../../repository/supabase/hitter_repository.dart';

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
  Future<List<HitterIdByName>> searchHitter(String searchWord) async {
    final allHitterList = await ref.watch(allHitterListProvider);
    final hitterListAfterSearch = <HitterIdByName>[];

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
