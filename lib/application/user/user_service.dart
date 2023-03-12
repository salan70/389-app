import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_info_repository.dart';
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

  /// ログインを行う（アプリ起動時に呼ぶ）
  /// 現在のUserを取得し、nullだったら匿名ユーザーを作成する
  Future<void> login() async {
    final authRepository = ref.read(authRepositoryProvider);

    // ログイン済み出ない場合、匿名ユーザーを作成する
    final user = authRepository.getCurrentUser();
    if (user == null) {
      await authRepository.signInAnonymously();
    }

    // userInfoを更新する
    await _updateUserInfo();
  }

  /// userInfoを更新する
  Future<void> _updateUserInfo() async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final userInfoRepository = ref.read(userInfoRepositoryProvider);

    await userInfoRepository.updateUserInfo(user!);
  }

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
