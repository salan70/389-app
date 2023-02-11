import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/base_repository/hitter_repository.dart';
import '../domain/ui/hitter_quiz_ui.dart';
import 'hitter_quiz_ui_state.dart';
import 'hitter_search_condition_state.dart';

/// HitterQuizUiサービスプロバイダー
final hitterQuizUiServiceProvider = Provider(
  HitterQuizUiService.new,
);

/// HitterQuizUiサービス
///
/// HitterQuizUiに関する操作を提供する
/// Widget から呼ばれ、各 Repository や State を操作するロジックを実装する
class HitterQuizUiService {
  HitterQuizUiService(this.ref);
  final Ref ref;

  /// 出題する選手を取得する
  Future<void> fetchHitterQuizUi() async {
    final notifier = ref.read(hitterQuizUiStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    late HitterQuizUi hitterQuizUi;
    notifier.state = await AsyncValue.guard(() async {
      final searchCondition = ref.watch(hitterSearchConditionProvider);
      hitterQuizUi = await ref
          .watch(hitterRepositoryProvider)
          .createHitterQuizUi(searchCondition);
      return null;
    });

    notifier.state = AsyncData(hitterQuizUi);
  }

  // TODO(me): テスト書くことを検討する
  /// ランダムに1つ成績を公開する
  void openRandom() {
    final notifier = ref.read(hitterQuizUiStateProvider.notifier);
    final hitterQuizUi = notifier.state.value;
    final hiddenStatsIdList = hitterQuizUi!.hiddenStatsIdList;

    final hiddenIndex = Random().nextInt(hiddenStatsIdList.length);

    // TODO(me): ここの処理を関数として抽出して、テスト書く
    // hiddenStatsIdList.removeAt(removeIdx)と同様の結果になる処理
    // hiddenStatsIdListがimmutable上記関数を使用できないため、下記のように書いている
    final removedHiddenList = <String>[];
    for (var i = 0; i < hiddenStatsIdList.length; i++) {
      if (i != hiddenIndex) {
        removedHiddenList.add(hiddenStatsIdList[i]);
      }
    }

    notifier.state = AsyncData(
      hitterQuizUi.copyWith(
        hiddenStatsIdList: [...removedHiddenList],
      ),
    );
  }

  // TODO(me): テスト書くことを検討する
  /// 全ての閉じている成績を公開する
  void openAll() {
    final notifier = ref.read(hitterQuizUiStateProvider.notifier);
    final hitterQuizUi = notifier.state.value;

    notifier.state = AsyncData(
      hitterQuizUi!.copyWith(
        hiddenStatsIdList: [],
      ),
    );
  }

  // TODO(me): テスト書く
  /// 成績が公開可能か判別する
  /// 閉じている成績が残っている場合、成績が公開可能とみなす
  bool canOpen() {
    final hitterQuizUi = ref.read(hitterQuizUiStateProvider).value;
    return hitterQuizUi!.hiddenStatsIdList.isNotEmpty;
  }
}
