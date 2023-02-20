import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/daily_quiz.dart';

/// dailyQuizをAsyncValueとして返す
final dailyQuizStateProvider = StateProvider<AsyncValue<DailyQuiz?>>(
  (_) => const AsyncValue.data(null),
);
