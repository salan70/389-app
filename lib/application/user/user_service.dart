import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/user_info_repository.dart';
import '../../feature/auth/domain/auth_repository.dart';
import '../quiz/daily_quiz/daily_quiz_state.dart';

/// userサービスプロバイダー
final userServiceProvider = Provider(
  UserService.new,
);

/// User関連の処理を行うサービスクラス
class UserService {
  const UserService(this.ref);

  final Ref ref;

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
