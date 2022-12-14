import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../repository/supabase/hitter_repository.dart';
import '../../../../util/logger.dart';

final openedIdListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final id2DListProvider = Provider<List<List<String>>>((ref) {
  // TODO ref.watchの形にしたい
  // return ref.watch(quizEventButtonsViewModelProvider).createId2DList();
  return QuizEventButtonsViewModel(ref).createId2DList();
});

final quizEventButtonsViewModelProvider =
    Provider(QuizEventButtonsViewModel.new);

class QuizEventButtonsViewModel {
  QuizEventButtonsViewModel(
    this.ref,
  );

  final Ref ref;

  List<List<String>> createId2DList() {
    final List<List<String>> idList = [];

    final hitterQuizUi = ref.watch(hitterQuizUiProvider);
    const uuid = Uuid();

    hitterQuizUi.when(
        data: (data) {
          for (int cIdx = 0; cIdx < data!.statsList.length; cIdx++) {
            idList.add([]);
            for (int rIdx = 0;
                rIdx < data.selectedStatsTypeList.length;
                rIdx++) {
              idList[cIdx].add(uuid.v4());
            }
          }
        },
        error: (_, error) {
          logger.e('$error');
        },
        loading: () {});

    return idList;
  }

  void addId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);
    final openedIdListNotifier = ref.watch(openedIdListProvider.notifier);

    final random = Random();

    while (true) {
      final cIx = random.nextInt(id2DList.length);
      final rIx = random.nextInt(id2DList[cIx].length);

      if (!openedIdList.contains(id2DList[cIx][rIx])) {
        openedIdList.add(id2DList[cIx][rIx]);
        // openedIdListを再生成し、代入する
        openedIdListNotifier.state = [...openedIdList];
        return;
      }
    }
  }

  void addAllId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);
    final openedIdListNotifier = ref.watch(openedIdListProvider.notifier);

    // 1つ1つ処理していく
    for (var idList in id2DList) {
      for (var id in idList) {
        if (!openedIdList.contains(id)) {
          openedIdList.add(id);
          // openedIdListを再生成し、代入する
          openedIdListNotifier.state = [...openedIdList];
        }
      }
    }
  }

  bool canAddId() {
    final id2DList = ref.watch(id2DListProvider);
    final openedIdList = ref.watch(openedIdListProvider);

    // id2DList[0]について、id2DListの各Listの長さは全て同じとなる。
    // 確実に値が入っている[0]を指定
    if (id2DList.isEmpty || id2DList[0].isEmpty) {
      return false;
    }

    final openedIdListIsFill =
        openedIdList.length == (id2DList.length * id2DList[0].length);
    if (openedIdListIsFill) {
      return false;
    }

    return true;
  }
}
