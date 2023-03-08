import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/hitter_quiz.dart';

/// hitterQuizをAsyncValueとして返す
final hitterQuizStateProvider = StateProvider<AsyncValue<HitterQuiz?>>(
  (_) => const AsyncValue.data(null),
);

/// クイズの回答として選択した選手のIDを返す
final selectedHitterIdProvider = StateProvider<String>((_) => '');
