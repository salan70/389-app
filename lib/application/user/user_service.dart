import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/user_info_repository.dart';
import '../../feature/auth/domain/auth_repository.dart';
import '../common/common_state.dart';
import '../quiz/daily_quiz/daily_quiz_state.dart';
import '../quiz/hitter_quiz/hitter_quiz_state.dart';

/// userサービスプロバイダー
final userServiceProvider = Provider(
  UserService.new,
);

/// User関連の処理を行うサービスクラス
class UserService {
  const UserService(this.ref);

  final Ref ref;

  /// dailyQuizResultを作成する
  Future<void> createDailyQuizResult(String dailyQuizId) async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final userInfoRepository = ref.read(userInfoRepositoryProvider);

      await userInfoRepository.createDailyQuiz(user!, dailyQuizId);
    });
  }

  /// dailyQuizResultを更新する
  Future<void> updateDailyQuizResult() async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final userInfoRepository = ref.read(userInfoRepositoryProvider);

      final dailyQuizId = ref.watch(dailyQuizStateProvider).value!.dailyQuizId;
      final hitterQuiz = ref.read(hitterQuizStateProvider).value!;
      await userInfoRepository.updateDailyQuizResult(
        user!,
        dailyQuizId,
        hitterQuiz,
      );
    });
  }

  /// normalQuizResultを作成する
  Future<void> createNormalQuizResult() async {
    final notifier = ref.read(commonFunctionStateProvider.notifier);

    notifier.state = const AsyncValue.loading();

    notifier.state = await AsyncValue.guard(() async {
      final user = ref.read(authRepositoryProvider).getCurrentUser();
      final userInfoRepository = ref.read(userInfoRepositoryProvider);

      final hitterQuiz = ref.read(hitterQuizStateProvider).value!;
      await userInfoRepository.createNormalQuizResult(
        user!,
        hitterQuiz,
      );
    });
  }

  /// dailyQuizをプレイ可能か返す
  Future<bool> canPlayDailyQuiz() async {
    final dailyQuiz = ref.read(dailyQuizStateProvider);
    if (dailyQuiz.value == null) {
      return false;
    }

    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final userInfoRepository = ref.read(userInfoRepositoryProvider);

    return !await userInfoRepository.existSpecifiedDailyQuizResult(
      user!,
      dailyQuiz.value!.dailyQuizId,
    );
  }
}
