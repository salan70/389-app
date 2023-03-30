import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../domain/daily_hitter_quiz_result.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';

/// nomalQuizの結果をリストで返すプロバイダー
final normalQuizResultListProvider =
    FutureProvider.autoDispose<List<HitterQuizResult>>((ref) {
  return ref.read(quizResultRepositoryProvider).fetchNormalQuizResultList(
        ref.read(authRepositoryProvider).getCurrentUser()!,
      );
});

/// dailyQuizの結果を返すプロバイダー
final dailyQuizResultProvider =
    FutureProvider.autoDispose<DailyHitterQuizResult>((ref) {
  return ref.read(quizResultRepositoryProvider).fetchDailyHitterQuizResult(
        ref.read(authRepositoryProvider).getCurrentUser()!,
      );
});

/// クイズ結果関連の関数の処理状態をAsyncValueとして返すプロバイダー
final quizResultFunctionStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);

/// 選択した日付を返すプロバイダー
/// dailyQuizの詳細画面への遷移で使用
final selectedDateProvider = StateProvider<DateTime?>((_) => null);
