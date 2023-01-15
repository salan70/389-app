import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../repository/supabase/supabase_hitter_repository.dart';

final answerViewModelProvider = Provider<AnswerViewModel>(AnswerViewModel.new);

final selectedHitterIdProvider = StateProvider<String>((_) => '');

class AnswerViewModel {
  AnswerViewModel(
    this.ref,
  );

  final Ref ref;

  Future<List<HitterIdByName>> filterHitter(String searchWord) async {
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
