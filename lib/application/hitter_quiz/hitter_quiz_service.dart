import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/hitter_quiz.dart';
import '../../domain/repository/hitter_repository.dart';
import '../hitter_search_condition/hitter_search_condition_state.dart';
import 'hitter_quiz_state.dart';

/// HitterQuizサービスプロバイダー
final hitterQuizServiceProvider = Provider(
  HitterQuizService.new,
);

/// HitterQuizサービス
///
/// HitterQuizに関する操作を提供する
/// Widgetから呼ばれ、各RepositoryやStateを操作するロジックを実装する
class HitterQuizService {
  HitterQuizService(this.ref);
  final Ref ref;

  /// 出題する選手を取得する
  Future<void> fetchHitterQuiz() async {
    final notifier = ref.read(hitterQuizStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    late HitterQuiz hitterQuiz;
    notifier.state = await AsyncValue.guard(() async {
      final searchCondition = ref.watch(hitterSearchConditionProvider);
      hitterQuiz = await ref
          .watch(hitterRepositoryProvider)
          .createHitterQuiz(searchCondition);
      return null;
    });

    notifier.state = AsyncData(hitterQuiz);
  }

  // TODO(me): テスト書くことを検討する
  /// ランダムに1つ成績を公開する
  void openRandom() {
    final notifier = ref.read(hitterQuizStateProvider.notifier);
    final hitterQuiz = notifier.state.value;
    final hiddenStatsIdList = hitterQuiz!.hiddenStatsIdList;

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
      hitterQuiz.copyWith(
        hiddenStatsIdList: [...removedHiddenList],
      ),
    );
  }

  // TODO(me): テスト書くことを検討する
  /// 全ての閉じている成績を公開する
  void openAll() {
    final notifier = ref.read(hitterQuizStateProvider.notifier);
    final hitterQuiz = notifier.state.value;

    notifier.state = AsyncData(
      hitterQuiz!.copyWith(
        hiddenStatsIdList: [],
      ),
    );
  }

  // TODO(me): テスト書く
  /// 成績が公開可能か判別する
  /// 閉じている成績が残っている場合、成績が公開可能とみなす
  bool canOpen() {
    final hitterQuiz = ref.read(hitterQuizStateProvider).value;
    return hitterQuiz!.hiddenStatsIdList.isNotEmpty;
  }
}