import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/enum/quiz_type.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../search_condition/application/search_condition_state.dart';
import '../domain/hitter_quiz_state.dart';
import '../infrastructure/hitter_repository.dart';

part 'hitter_quiz_notifier.g.dart';

/// [HitterQuizState] を保持する。
///
/// [quizType] に [QuizType.daily] を指定する場合、
/// [questionedAt] に DailyQuiz の出題日を指定すること。
@riverpod
class HitterQuizNotifier extends _$HitterQuizNotifier {
  @override
  FutureOr<HitterQuizState> build(
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
}
