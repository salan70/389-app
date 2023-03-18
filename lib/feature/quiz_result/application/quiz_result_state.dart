import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';

/// nomalQuizResultListを返すプロバイダー
final normalQuizResultListStateProvider =
    FutureProvider.autoDispose<List<HitterQuizResult>>((ref) {
  return ref.read(quizResultRepositoryProvider).fetchNormalQuizResultList(
        ref.read(authRepositoryProvider).getCurrentUser()!,
      );
});

/// クイズ結果関連の関数の処理状態をAsyncValueとして返すプロバイダー
final quizResultFunctionStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);
