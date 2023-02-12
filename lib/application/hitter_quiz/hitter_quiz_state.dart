import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/hitter_quiz.dart';

// hitterQuizをAsyncValueとして返すプロバイダー
final hitterQuizStateProvider = StateProvider<AsyncValue<HitterQuiz?>>(
  (_) => const AsyncValue.data(null),
);
