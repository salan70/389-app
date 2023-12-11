import 'package:baseball_quiz_app/feature/search_condition/application/search_condition_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/constant/hitting_stats_constant.dart';
import '../../../util/extension/date_time_extension.dart';
import '../../auth/domain/auth_repository.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../daily_quiz/domain/daily_quiz.dart';
import '../../quiz/application/hitter_quiz_state.dart';
import '../../quiz/domain/hitter_quiz.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';
import 'quiz_result_state.dart';

part 'quiz_result_service.g.dart';

@riverpod
QuizResultService quizResultService(QuizResultServiceRef ref) =>
    QuizResultService(ref);

/// quizResult関連の処理を行うサービスクラス
class QuizResultService {
  const QuizResultService(this.ref);

  final Ref ref;

  /// dailyQuizResult を作成する
  Future<void> createDailyQuizResult(DailyQuiz dailyQuiz) async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      await ref
          .read(quizResultRepositoryProvider)
          .createDailyQuiz(user!, dailyQuiz);
    });
  }

  /// dailyQuizResultを更新する
  Future<void> updateDailyQuizResult() async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      await quizResultRepository.updateDailyQuizResult(
        user!,
        ref.read(dailyQuizProvider).value!,
        ref.read(hitterQuizStateProvider).value!,
      );
    });
  }

  /// normalQuizResultを作成する
  Future<void> createNormalQuizResult() async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      await quizResultRepository.createNormalQuizResult(
        user!,
        ref.read(hitterQuizStateProvider).value!,
        ref.read(searchConditionNotifierProvider),
      );
    });
  }

  /// HitterQuizResultからHitterQuizを作成し、hitterQuizStateに格納する
  void updateQuizStateFromResult(
    HitterQuizResult hitterQuizResult,
    QuizType quizType,
  ) {
    final hitterQuiz = HitterQuiz(
      id: hitterQuizResult.id,
      name: hitterQuizResult.name,
      quizType: quizType,
      yearList: hitterQuizResult.yearList,
      selectedStatsList: hitterQuizResult.selectedStatsList,
      statsMapList: hitterQuizResult.statsMapList,
      unveilCount: hitterQuizResult.unveilCount,
      isCorrect: hitterQuizResult.isCorrect,
      incorrectCount: hitterQuizResult.incorrectCount,
    );
    ref.read(hitterQuizStateProvider.notifier).state = AsyncData(hitterQuiz);
  }

  /// 指定したindexからHitterQuizResultを取得しquizResultStateを更新する
  /// normalQuizの結果表示で使用する
  void updateQuizResultStateFromIndex(int index) {
    final normalQuizResultList = ref.read(normalQuizResultListProvider).value!;

    ref.read(quizResultStateProvider.notifier).state =
        normalQuizResultList[index];
  }

  /// 指定した日付からHitterQuizResultを取得しquizResultStateを更新する
  /// dailyQuizの結果表示で使用する
  void updateQuizResultStatefromDate(DateTime data) {
    final formattedDate = data.toFormattedString();
    final dailyQuizResult = ref.read(dailyQuizResultProvider).value!;

    ref.read(quizResultStateProvider.notifier).state =
        dailyQuizResult.resultMap[formattedDate];
  }

  Future<void> deleteNormalQuizResult(String docId) async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      await ref.read(quizResultRepositoryProvider).deleteNormalQuizResult(
            user!,
            docId,
          );
      ref.invalidate(normalQuizResultListProvider);
    });
  }
}
