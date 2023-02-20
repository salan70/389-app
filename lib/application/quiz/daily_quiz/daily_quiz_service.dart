import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/daily_quiz.dart';
import '../../../domain/repository/daily_quiz_repository.dart';
import 'daily_quiz_state.dart';

final dailyQuizServiceProvider = Provider.autoDispose<DailyQuizService>(
  DailyQuizService.new,
);

class DailyQuizService {
  DailyQuizService(
    this.ref,
  );

  final Ref ref;

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
}
