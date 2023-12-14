import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/constant/hitting_stats_constant.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../search_condition/application/search_condition_notifier.dart';
import '../domain/hitter.dart';
import '../domain/hitter_quiz.dart';
import '../domain/hitter_repository.dart';

part 'hitter_quiz_notifier.g.dart';

@riverpod
class HitterQuizNotifier extends _$HitterQuizNotifier {
  @override
  FutureOr<HitterQuiz> build(QuizType quizType) async {
    switch (quizType) {
      case QuizType.normal:
        final searchCondition = ref.watch(searchConditionNotifierProvider);
        return ref
            .watch(hitterRepositoryProvider)
            .fetchHitterQuizBySearchCondition(searchCondition);

      case QuizType.daily:
        final dailyQuiz = await ref.watch(dailyQuizProvider.future);
        // TODO(me): null チェックしたほうがいいかも。
        return ref
            .read(hitterRepositoryProvider)
            .fetchHitterQuizById(dailyQuiz!);
    }
  }

  /// ランダムに1つ成績を公開する
  void openRandom() {
    state = AsyncData(
      state.value!.copyWith(
        unveilCount: state.value!.unveilCount + 1,
      ),
    );
  }

  /// 成績が公開可能か判別する。
  ///
  /// 閉じている成績が残っている場合、成績が公開可能とみなす。
  bool canOpen() {
    final totalStatsCount = state.value!.statsMapList.length *
        state.value!.selectedStatsList.length;

    return state.value!.unveilCount < totalStatsCount;
  }

  /// 全ての閉じている成績を公開する。
  void openAll() {
    final totalStatsCount = state.value!.statsMapList.length *
        state.value!.selectedStatsList.length;

    state = AsyncData(
      state.value!.copyWith(
        unveilCount: totalStatsCount,
      ),
    );
  }

  /// 正解しているか否かを返す。
  bool isCorrectHitterQuiz() =>
      state.value!.enteredHitter?.id == state.value!.id;

  /// isCorrect を true にする。
  void markCorrect() {
    state = AsyncData(
      state.value!.copyWith(
        isCorrect: true,
      ),
    );
  }

  /// 不正解数を1増やす。
  void addIncorrectCount() {
    state = AsyncData(
      state.value!.copyWith(
        incorrectCount: state.value!.incorrectCount + 1,
      ),
    );
  }

  /// 最後の回答かどうかを返す。
  bool isFinalAnswer(int? maxCanIncorrectCount) {
    if (maxCanIncorrectCount == null) {
      return false;
    }
    return state.value!.incorrectCount == maxCanIncorrectCount;
  }

  /// enteredHitter を更新する。
  void updateEnteredHitter(Hitter? enteredHitter) {
    state = AsyncData(
      state.value!.copyWith(
        enteredHitter: enteredHitter,
      ),
    );
  }
}
