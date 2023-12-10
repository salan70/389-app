import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/domain/auth_repository.dart';
import '../domain/daily_hitter_quiz_result.dart';
import '../domain/hitter_quiz_result.dart';
import '../domain/quiz_result_repository.dart';

part 'quiz_result_state.g.dart';

/// normalQuiz の結果をリストで返すプロバイダー。
@riverpod
Future<List<HitterQuizResult>> normalQuizResultList(
  NormalQuizResultListRef ref,
) async {
  final user = ref.read(authRepositoryProvider).getCurrentUser();
  return ref.read(quizResultRepositoryProvider).fetchNormalQuizResultList(
        user!,
      );
}

/// dailyQuiz の結果を返すプロバイダー。
@riverpod
Future<DailyHitterQuizResult> dailyQuizResult(DailyQuizResultRef ref) async {
  final user = ref.read(authRepositoryProvider).getCurrentUser();
  return ref.read(quizResultRepositoryProvider).fetchDailyHitterQuizResult(
        user!,
      );
}

// todo stateProvider
/// クイズ結果を返すプロバイダー
final quizResultStateProvider = StateProvider<HitterQuizResult?>(
  (_) => null,
);

// todo stateProvider
/// クイズ結果関連の関数の処理状態をAsyncValueとして返すプロバイダー
final quizResultFunctionStateProvider = StateProvider<AsyncValue<void>>(
  (_) => const AsyncValue.data(null),
);
