import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_map.dart';
import '../../../../repository/supabase/hitter_repository.dart';

final inputAnswerViewModelProvider = StateProvider.autoDispose((ref) {
  return InputAnswerViewModel(ref);
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
}
