import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../domain/daily_quiz.dart';
import '../domain/daily_quiz_repository.dart';
import 'daily_quiz_state.dart';

final dailyQuizServiceProvider = Provider.autoDispose<DailyQuizService>( 
  DailyQuizService.new,
);

class DailyQuizService {
  DailyQuizService(
    this.ref,
  );

  final Ref ref;

  // TODO(me): 単にStateProviderに入れてるだけっぽいから、この関数消して、FutureProviderで扱うで良さそう
  /// dailyQuizを取得し、dailyQuizStateProviderのstateを更新
  Future<void> fetchDailyQuiz() async {
    final notifier = ref.read(dailyQuizStateProvider.notifier);

    notifier.state = const AsyncValue.loading();
    late DailyQuiz dailyQuiz;
    notifier.state = await AsyncValue.guard(() async {
      dailyQuiz = await ref.watch(dailyQuizRepositoryProvider).fetchDailyQuiz();
      return null;
    });

    notifier.state = AsyncData(dailyQuiz);
  }

  /// dailyQuizをプレイ可能か返す
  Future<bool> canPlayDailyQuiz() async {
    final dailyQuiz = ref.read(dailyQuizStateProvider);
    if (dailyQuiz.value == null) {
      return false;
    }

    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final userInfoRepository = ref.read(quizResultRepositoryProvider);

    return !await userInfoRepository.existSpecifiedDailyQuizResult(
      user!,
      dailyQuiz.value!.dailyQuizId,
    );
  }
}
