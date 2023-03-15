import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/common/common_state.dart';
import '../../../application/quiz/daily_quiz/daily_quiz_state.dart';
import '../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../auth/domain/auth_repository.dart';
import '../domain/quiz_result_repository.dart';

/// quizResultサービスプロバイダー
final quizResultServiceProvider = Provider(
  QuizResultService.new,
);

/// quizResult関連の処理を行うサービスクラス
class QuizResultService {
  const QuizResultService(this.ref);

  final Ref ref;

  /// dailyQuizResultを作成する
  Future<void> createDailyQuizResult(String dailyQuizId) async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      await quizResultRepository.createDailyQuiz(user!, dailyQuizId);
    });
  }

  /// dailyQuizResultを更新する
  Future<void> updateDailyQuizResult() async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final quizResultRepository = ref.read(quizResultRepositoryProvider);

      /// 別のfeatureのapplication層を参照するの避けたみ
      // TODO(me): 引数で受け取るようにしたほうが良いか検討する
      final dailyQuizId = ref.watch(dailyQuizStateProvider).value!.dailyQuizId;
      final hitterQuiz = ref.read(hitterQuizStateProvider).value!;
      await quizResultRepository.updateDailyQuizResult(
        user!,
        dailyQuizId,
        hitterQuiz,
      );
    });
  }

  /// normalQuizResultを作成する
  Future<void> createNormalQuizResult() async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

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
}
