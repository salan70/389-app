import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../repository/supabase/supabase_hitter_repository.dart';

final inputAnswerViewModelProvider =
    Provider<InputAnswerViewModel>(InputAnswerViewModel.new);

final selectedHitterIdProvider = StateProvider<String>((_) => '');

class InputAnswerViewModel {
  InputAnswerViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO(me): 関数名もっといいの検討
  Future<List<HitterIdByName>> searchHitter(String searchWord) async {
    final allHitterList = await ref.watch(allHitterListProvider);
    final hitterListAfterSearch = <HitterIdByName>[];

    for (final hitter in allHitterList) {
      if (hitter.label.contains(searchWord)) {
        hitterListAfterSearch.add(hitter);
      }
    }

    return hitterListAfterSearch;
  }
}
