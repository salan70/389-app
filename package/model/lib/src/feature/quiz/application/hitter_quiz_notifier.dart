import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../search_condition/application/search_condition_state.dart';
import '../domain/hitter.dart';
import '../domain/hitter_quiz.dart';
import '../infrastructure/hitter_repository.dart';

part 'hitter_quiz_notifier.g.dart';

/// [HitterQuiz] を保持する。
///
/// [quizType] に [QuizType.daily] を指定する場合、
/// [questionedAt] に DailyQuiz の出題日を指定すること。
@riverpod
class HitterQuizNotifier extends _$HitterQuizNotifier {
  @override
  FutureOr<HitterQuiz> build(
    QuizType quizType, {
    required DateTime? questionedAt,
  }) async {
    switch (quizType) {
      case QuizType.normal:
        final searchCondition = ref.watch(searchConditionProvider);
        return ref
            .watch(hitterRepositoryProvider)
            .fetchHitterQuizBySearchCondition(searchCondition);

      case QuizType.daily:
        if (questionedAt == null) {
          throw ArgumentError.notNull('questionedAt');
        }
        final dailyQuiz =
            await ref.watch(dailyQuizProvider(questionedAt).future);
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
