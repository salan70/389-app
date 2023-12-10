import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/hitter_quiz.dart';

// todo stateProvider
/// hitterQuizをAsyncValueとして返す
final hitterQuizStateProvider =
    StateProvider.autoDispose<AsyncValue<HitterQuiz?>>(
  (_) => const AsyncValue.data(null),
);
