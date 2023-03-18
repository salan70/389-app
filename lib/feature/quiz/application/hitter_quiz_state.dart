import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/hitter_quiz.dart';

/// hitterQuizをAsyncValueとして返す
final hitterQuizStateProvider = StateProvider<AsyncValue<HitterQuiz?>>(
  (_) => const AsyncValue.data(null),
);
