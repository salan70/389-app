import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/constant/hitting_stats_constant.dart';
import '../../auth/domain/auth_repository.dart';
import '../../daily_quiz/application/daily_quiz_state.dart';
import '../../quiz/application/hitter_quiz_state.dart';
import '../../quiz/domain/hitter_quiz.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';
import 'quiz_result_state.dart';

/// quizResultサービスプロバイダー
final quizResultServiceProvider = Provider(
  QuizResultService.new,
);

/// quizResult関連の処理を行うサービスクラス
class QuizResultService {
  const QuizResultService(this.ref);

  final Ref ref;

  /// dailyQuizResultを作成する
  Future<void> createDailyQuizResult() async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      /// 別のfeatureのapplication層を参照するの避けたみ
      // TODO(me): 引数で受け取るようにしたほうが良いか検討する
      final dailyQuiz = ref.watch(dailyQuizStateProvider).value!;

      await quizResultRepository.createDailyQuiz(user!, dailyQuiz);
    });
  }

  /// dailyQuizResultを更新する
  Future<void> updateDailyQuizResult() async {
    final notifier = ref.read(quizResultFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      /// 別のfeatureのapplication層を参照するの避けたみ
      // TODO(me): 引数で受け取るようにしたほうが良いか検討する
      final dailyQuiz = ref.watch(dailyQuizStateProvider).value!;
      final hitterQuiz = ref.read(hitterQuizStateProvider).value!;
      await quizResultRepository.updateDailyQuizResult(
        user!,
        dailyQuiz,
        hitterQuiz,
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

      /// 別のfeatureのapplication層を参照するの避けたみ
      // TODO(me): 引数で受け取るようにしたほうが良いか検討する
      final hitterQuiz = ref.read(hitterQuizStateProvider).value!;
      await quizResultRepository.createNormalQuizResult(
        user!,
        hitterQuiz,
      );
    });
  }

  /// HitterQuizResultからHitterQuizを作成し、hitterQuizStateに格納する
  void updateHitterQuizFromResult(
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

  /// selectedDateを更新する
  void updateSelectedDate(DateTime selectedDate) {
    final notifier = ref.read(selectedDateProvider.notifier);
    notifier.state = selectedDate;
  }
}
