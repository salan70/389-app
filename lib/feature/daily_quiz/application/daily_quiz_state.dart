import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_repository.dart';
import '../../quiz_result/domain/quiz_result_repository.dart';
import '../domain/daily_quiz.dart';
import '../domain/daily_quiz_repository.dart';

/// dailyQuiz を取得して保持する。
/// 
/// 有効な dailyQuiz が存在しなかった場合は、 `null` を返す。
final dailyQuizProvider = FutureProvider.autoDispose<DailyQuiz?>(
  (ref) => ref.watch(dailyQuizRepositoryProvider).fetchDailyQuiz(),
);

///  dailyQuiz をプレイ済みかどうかを返す。
final isPlayedDailyQuizProvider = FutureProvider.autoDispose<bool>(
  (ref) async {
    final dailyQuiz = await ref.watch(dailyQuizProvider.future);
    if (dailyQuiz == null) {
      return false;
    }

    final user = ref.read(authRepositoryProvider).getCurrentUser();

    return ref.read(quizResultRepositoryProvider).existSpecifiedDailyQuizResult(
          user!,
          dailyQuiz.dailyQuizId,
        );
  },
);
