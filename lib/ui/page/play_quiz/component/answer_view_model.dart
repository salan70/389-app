import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../repository/supabase/supabase_hitter_repository.dart';
import '../../../../state/hitter_quiz_ui_state.dart';
import '../../../../state/loading_state.dart';

final answerViewModelProvider = Provider<AnswerViewModel>(AnswerViewModel.new);

final selectedHitterIdProvider = StateProvider<String>((_) => '');

final answerTextFieldProvider = StateProvider((ref) => TextEditingController());

class AnswerViewModel {
  AnswerViewModel(
    this.ref,
  );

  final Ref ref;

  // TODO(me): テスト書くことを検討する
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

  // TODO(me): テスト書く
  /// 正解しているか否かを返す
  bool isCorrectHitterQuiz() {
    final selectedHitterId = ref.read(selectedHitterIdProvider);
    final hitterQuizUi = ref.read(hitterQuizUiStateProvider);

    return selectedHitterId == hitterQuizUi.value!.id;
  }

  /// 結果表示までじらすための処理
  /// interstitial広告が表示されるために時間を稼ぐという狙いもある
  Future<void> waitResult() async {
    final loadingNotifier = ref.read(loadingProvider.notifier);
    loadingNotifier.show();
    await Future<void>.delayed(const Duration(seconds: 3));
    loadingNotifier.hide();
  }

  /// 広告を表示するかどうかを返す
  /// 50%の確率で広告を表示する
  bool isShownAds() {
    return Random().nextBool();
  }
}
